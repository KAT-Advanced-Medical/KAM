#include "..\script_component.hpp"
/*
 * Author: Glowbal, Mazinski
 * Updates the vitals. Called from the statemachine's onState functions.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * Update Ran (at least 1 second between runs) <BOOL>
 *
 * Example:
 * [player] call ace_medical_vitals_fnc_handleUnitVitals
 *
 * Public: No
 */

params ["_unit"];

if ((!(isPlayer _unit)) && (_unit getVariable [QGVAR(simpleMedical),false])) exitWith { [_unit] call FUNC(handleSimpleVitals); };

private _lastTimeUpdated = _unit getVariable [QACEGVAR(medical_vitals,lastTimeUpdated), 0];
private _deltaT = (CBA_missionTime - _lastTimeUpdated) min 10;
if (_deltaT < 1) exitWith { false }; // state machines could be calling this very rapidly depending on number of local units

BEGIN_COUNTER(Vitals);

_unit setVariable [QACEGVAR(medical_vitals,lastTimeUpdated), CBA_missionTime];
private _lastTimeValuesSynced = _unit getVariable [QACEGVAR(medical_vitals,lastMomentValuesSynced), 0];
private _syncValues = (CBA_missionTime - _lastTimeValuesSynced) >= (10 + floor(random 10));

if (_syncValues) then {
    _unit setVariable [QACEGVAR(medical_vitals,lastMomentValuesSynced), CBA_missionTime];
};

//Get Blood Volume from previous cycle
private _bloodVolume = ([_unit, _deltaT, _syncValues] call EFUNC(pharma,getBloodVolumeChange));
_unit setVariable [VAR_BLOOD_VOL, _bloodVolume, _syncValues];

private _temperature = 37;
private _baroPressure = 760;

if (EGVAR(hypothermia,hypothermiaActive)) then {
    // Enviromental Impact (Altitude, Temperature, Pressure)
    private _altitude = (getPosASL _unit) select 2;
    private _altitudeTempImpact = switch (true) do {
        case (_altitude >= 10): { abs(_altitude/153) * -1 }; //For every 1000 meters of elevation gain, temperature decreases by ~6.5 degrees celsius
        case (_altitude <= -1): { -35 max((abs(_altitude/50) * -1) - 17) }; //Average water temperature is 20 degrees celsius. Decreases to 2 degrees celsius at 1000 meters
        default { 0 };
    };

    _baroPressure = 760 * exp((-(_altitude)) / 8400);
    _temperature = [_unit, _altitudeTempImpact, _bloodVolume, _deltaT, _syncValues] call FUNC(handleTemperatureFunction);
};

// Set variables for synchronizing information across the net
private _hemorrhage = switch (true) do {
    case (_bloodVolume < BLOOD_VOLUME_CLASS_4_HEMORRHAGE): { 4 };
    case (_bloodVolume < BLOOD_VOLUME_CLASS_3_HEMORRHAGE): { 3 };
    case (_bloodVolume < BLOOD_VOLUME_CLASS_2_HEMORRHAGE): { 2 };
    case (_bloodVolume < BLOOD_VOLUME_CLASS_1_HEMORRHAGE): { 1 };
    default {0};
};

if (_hemorrhage != GET_HEMORRHAGE(_unit)) then {
    _unit setVariable [VAR_HEMORRHAGE, _hemorrhage, true];
};

private _inPain = GET_PAIN_PERCEIVED(_unit) > 0;
if !(_inPain isEqualTo IS_IN_PAIN(_unit)) then {
    _unit setVariable [VAR_IN_PAIN, _inPain, true];
};

// Handle pain due tourniquets, that have been applied more than 120 s ago
private _tourniquetPain = 0;
private _tourniquets = GET_TOURNIQUETS(_unit);
{
    if (_x > 0 && (CBA_missionTime - _x > 120)) then {
        _tourniquetPain = _tourniquetPain max (CBA_missionTime - _x - 120) * 0.001;
    };
} forEach _tourniquets;

if (_tourniquetPain > 0) then {
    [_unit, _tourniquetPain] call ACEFUNC(medical_status,adjustPainLevel);
};

// Get Medication Adjustments:
private _hrTargetAdjustment = 0;
private _painSupressAdjustment = 0;
private _peripheralResistanceAdjustment = 0;
private _alphaFactorAdjustment = 0;
private _opioidAdjustment = 0;
private _opioidEffectAdjustment = 0;
private _adjustments = _unit getVariable [VAR_MEDICATIONS,[]];

if !(_adjustments isEqualTo []) then {
    private _deleted = false;
    {
        _x params ["_medication", "_timeAdded", "_timeTillMaxEffect", "_maxTimeInSystem", "_hrAdjust", "_painAdjust", "_flowAdjust", "_alphaFactor", "_opioidRelief", "_opioidEffect"];
        private _timeInSystem = CBA_missionTime - _timeAdded;
        if (_timeInSystem >= _maxTimeInSystem) then {
            _deleted = true;
            _adjustments set [_forEachIndex, objNull];
        } else {
            private _effectRatio = (((_timeInSystem / _timeTillMaxEffect) ^ 2) min 1) * (_maxTimeInSystem - _timeInSystem) / _maxTimeInSystem;
            if (_hrAdjust != 0) then { _hrTargetAdjustment = _hrTargetAdjustment + _hrAdjust * _effectRatio; };
            if (_painAdjust != 0) then { _painSupressAdjustment = _painSupressAdjustment + _painAdjust * _effectRatio; };
            if (_flowAdjust != 0) then { _peripheralResistanceAdjustment = _peripheralResistanceAdjustment + _flowAdjust * _effectRatio; };
            if (_alphaFactor != 0) then { _alphaFactorAdjustment = _alphaFactorAdjustment + _alphaFactor * _effectRatio; };
            if (_opioidRelief != 0) then {_opioidAdjustment = _opioidAdjustment + _opioidRelief * _effectRatio; };
            if (_opioidEffect != 0) then {_opioidEffectAdjustment = _opioidEffectAdjustment + _opioidEffect * _effectRatio; };
        };
    } forEach _adjustments;

    if (_deleted) then {
        _unit setVariable [VAR_MEDICATIONS, _adjustments - [objNull], true];
        _syncValues = true;
    };
};

[_unit, _painSupressAdjustment, _deltaT, _syncValues] call ACEFUNC(medical_vitals,updatePainSuppress); //Leave alone
[_unit, _peripheralResistanceAdjustment, _deltaT, _syncValues] call ACEFUNC(medical_vitals,updatePeripheralResistance);
[_unit, _opioidAdjustment, _deltaT, _syncValues] call FUNC(updateOpioidRelief);
[_unit, _opioidEffectAdjustment, _deltaT, _syncValues] call FUNC(updateOpioidEffect);
[_unit, POISON_DECREASE, _deltaT, _syncValues] call FUNC(handlePoisoning);

private _heartRate = [_unit, _hrTargetAdjustment, 0, _bloodVolume, _deltaT, _syncValues] call FUNC(handleCardiacFunction);

private _spo2 = 97;
if (EGVAR(breathing,enable)) then {
    // Additional variables for Respiration functions
    private _bloodGas = GET_BLOOD_GAS(_unit);
    private _opioidDepression = GET_OPIOID_FACTOR(_unit);
    private _anerobicPressure = (DEFAULT_ANEROBIC_EXCHANGE * (6 / (_bloodVolume max 6))) min 1.2;

    _spo2 = [_unit, _heartRate, _anerobicPressure, _bloodGas, _temperature, _baroPressure, _opioidDepression, _deltaT, _syncValues] call FUNC(handleOxygenFunction);
};

// Vasoconstriction from Wound Blood Loss and Alpha Adjustment
_vasoconstriction = 1 + (0.5 * _woundBloodLoss) + _alphaFactorAdjustment;
_unit setVariable [VAR_VASOCONSTRICTION, (1.8 min (0.2 max _vasoconstriction)), _syncValues];

private _woundBloodLoss = GET_WOUND_BLEEDING(_unit);

private _bloodPressure = [_unit] call EFUNC(circulation,getBloodPressure);
_unit setVariable [VAR_BLOOD_PRESS, _bloodPressure, _syncValues];

_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];

// Statements are ordered by most lethal first.
switch (true) do {
    case ((_spo2 < EGVAR(breathing,SpO2_dieValue)) && EGVAR(breathing,SpO2_dieActive)): {
        TRACE_3("O2 Fatal",_unit,EGVAR(breathing,SpO2_dieValue),_spo2);
        [_unit, "Fatal_Blood_Oxygen"] call ACEFUNC(medical_status,setDead);
    };
    case (_bloodVolume < BLOOD_VOLUME_FATAL): {
        TRACE_3("BloodVolume Fatal",_unit,BLOOD_VOLUME_FATAL,_bloodVolume);
        [QACEGVAR(medical,Bleedout), _unit] call CBA_fnc_localEvent;
    };
    case (IN_CRDC_ARRST(_unit)): {}; // if in cardiac arrest just break now to avoid throwing unneeded events
    case ((_spo2 < EGVAR(breathing,SpO2_cardiacValue)) && EGVAR(breathing,SpO2_cardiacActive)): {
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_hemorrhage == 4): {
        TRACE_3("Class IV Hemorrhage",_unit,_hemorrhage,_bloodVolume);
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_heartRate < 20 || {_heartRate > 220}): {
        TRACE_2("heartRate Fatal",_unit,_heartRate);
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_bloodPressureL < 20 || {_bloodPressureL > 180}): {
        TRACE_2("bloodPressure L above or below limits",_unit,_bloodPressureL);
        [QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_spo2 < EGVAR(breathing,SpO2_unconscious)): {
        [QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_woundBloodLoss > BLOOD_LOSS_KNOCK_OUT_THRESHOLD): {
        [QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_woundBloodLoss > 0): {
        [QACEGVAR(medical,LoweredVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_inPain): {
        [QACEGVAR(medical,LoweredVitals), _unit] call CBA_fnc_localEvent;
    };
};

#ifdef DEBUG_MODE_FULL
private _cardiacOutput = [_unit] call ACEFUNC(medical_status,getCardiacOutput);
if (!isPlayer _unit) then {
    private _painLevel = _unit getVariable [VAR_PAIN, 0];
    hintSilent format["blood volume: %1, blood loss: [%2, %3]\nhr: %4, bp: %5, pain: %6", round(_bloodVolume * 100) / 100, round(_woundBloodLoss * 1000) / 1000, round((_woundBloodLoss / (0.001 max _cardiacOutput)) * 100) / 100, round(_heartRate), _bloodPressure, round(_painLevel * 100) / 100];
};
#endif

END_COUNTER(Vitals);

//placed outside the counter as 3rd-party code may be called from this event
[QACEGVAR(medical,handleUnitVitals), [_unit, _deltaT]] call CBA_fnc_localEvent;

true
