#include "..\script_component.hpp"
/*
 * Author: Glowbal
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

if (!(isPlayer _unit) && (_unit getVariable [QEGVAR(circulation,simpleMedical), false])) exitWith { [_unit] call FUNC(handleSimpleVitals) };

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

//Get Blood Loss and Blood Volume from previous cycle
private _bloodVolume = ([_unit, _deltaT, _syncValues] call ACEFUNC(medical_status,getBloodVolumeChange));
_bloodVolume set [0, (GET_BLOOD_VOLUME(_unit) + (_bloodVolume select 0))];

private _bloodLoss = (6 - (_bloodVolume select 0));

// Acidosis from Blood Volume matching between ECP/ECB and ISP
private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh),0];
private _ph = 10 ^ (((_bloodVolume select 2) / (_bloodVolume select 1) + 0.0518));
private _acidosis = 1.5 min ((0 max ((7.4 - _ph) - ((_bloodVolume select 0) / 6))) + (_externalPh / 2000));
_unit setVariable [QEGVAR(pharma,pH), _acidosis, _syncValues];

// Altitude 
private _altitude = (getPosASL _unit) select 2;
private _altitudeTempImpact = switch (true) do {
    case (_altitude >= 10): { abs(_altitude/153) * -1 }; //For every 1000 meters of elevation gain, temperature decreases by ~6.5 degrees celcius
    case (_altitude <= -1): { -35 max((abs(_altitude/50) * -1) - 17) }; //Average water temperature is 20 degrees celcius. Decreases to 2 degrees celcius at 1000 meters
    default { 0 };
};

private _temperatureImpact = [_unit, _altitudeTempImpact, (_bloodVolume select 0), _deltaT, _syncValues] call FUNC(handleTemperatureFunction); 

// Metabolic Rate (MR) with decreases due to temperature and SpO2 impacts
private _metabolicRate = (100 - ((100 - GET_SPO2(_unit))/5)) + (9.0757 * _bloodLoss^5) - (54.5562 * _bloodLoss^4) + (94.0381 * _bloodLoss^3) - (44.6435 * _bloodLoss^2) + (8.8576 * _bloodLoss) - _temperatureImpact;

// Cardiac Demand from MR with increases due to altitude
private _cardiacDemand = 0.1266666667 + (_metabolicRate - 100) * 0.003 + (_altitude * 0.00002);

// (START VENTILATION BRANCH)
// Ventilation Demand from Cardiac Demand (V from Q) with Acidosis decreasing exchange efficiency 
private _ventilationDemand = (((_cardiacDemand + (_acidosis / 5)) / 5) * 4);

// BR Actual from Ventilation Demand and Surface Area
private _breathingRate = [(0.67 min ((_ventilationDemand / (GET_KAT_SURFACEAREA(_unit) * (-0.006158583526))) * (-0.006158583526))), 0] select (IN_CRDC_ARRST(_unit));
private _spo2Adjustment = (((_breathingRate * 0.1) + _cardiacDemand) - (_breathingRate * GET_KAT_SURFACEAREA(_unit)));
private _spo2 = [_unit, _spo2Adjustment, GET_SPO2(_unit), _deltaT, _syncValues] call FUNC(handleOxygenFunction);
//(END VENTILATION BRANCH)

// Note: Flip Ventilation and Cardiac Branch positions. Need to take in BP/S into the _spo2Adjustment somehow to simulate pulmonary hypertension. Higher pressure in the arteries should decrease BLIND _cardiacDemand to decrease _spo2 with no actual change in BR. 

// (START CARDIAC BRANCH)
// Heart Rate from Blood Volume and Cardiac Demand with negative Acidosis impacts (Forgot what the 105 value is, pulse per second impact? I lost the notecard on this)
private _heartRate = (_bloodVolume select 0) * ((_cardiacDemand + (_acidosis / 4)) * 105.2631579);

// Systolic Blood Pressure from Metabolic Rate with negative Acidosis impacts, Diastolic Blood Pressure from Metabolic Rate and Blood Loss
private _bloodPressureSystolic = 120 * ((_unit getVariable [VAR_PERIPH_RES, DEFAULT_PERIPH_RES]) / 100) + (((_metabolicRate - 100)) - (_acidosis * 6));
private _bloodPressureDiastolic = 80 * ((_unit getVariable [VAR_PERIPH_RES, DEFAULT_PERIPH_RES]) / 100) + (((_metabolicRate - 100)) + (_bloodLoss * 3));

private _woundBloodLoss = GET_WOUND_BLEEDING(_unit);
_unit setVariable [VAR_BLOOD_VOL, (_bloodVolume select 0), _syncValues];

// Set variables for synchronizing information across the net
private _hemorrhage = switch (true) do {
    case ((_bloodVolume select 0) < BLOOD_VOLUME_CLASS_4_HEMORRHAGE): { 4 };
    case ((_bloodVolume select 0) < BLOOD_VOLUME_CLASS_3_HEMORRHAGE): { 3 };
    case ((_bloodVolume select 0) < BLOOD_VOLUME_CLASS_2_HEMORRHAGE): { 2 };
    case ((_bloodVolume select 0) < BLOOD_VOLUME_CLASS_1_HEMORRHAGE): { 1 };
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
private _adjustments = _unit getVariable [VAR_MEDICATIONS,[]];

if !(_adjustments isEqualTo []) then {
    private _deleted = false;
    {
        _x params ["_medication", "_timeAdded", "_timeTillMaxEffect", "_maxTimeInSystem", "_hrAdjust", "_painAdjust", "_flowAdjust", "_alphaFactor"];
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
        };
    } forEach _adjustments;

    if (_deleted) then {
        _unit setVariable [VAR_MEDICATIONS, _adjustments - [objNull], true];
        _syncValues = true;
    };
};

_heartRate = [_unit, _hrTargetAdjustment, _heartRate, _deltaT, _syncValues] call FUNC(handleCardiacFunction); //Rename
[_unit, _painSupressAdjustment, _deltaT, _syncValues] call ACEFUNC(medical_vitals,updatePainSuppress); //Leave alone
[_unit, _peripheralResistanceAdjustment, _deltaT, _syncValues] call ACEFUNC(medical_vitals,updatePeripheralResistance);

// Remeber to change getBloodPressure macro ----------------------------------------------------------

// Vasoconstriction from Diastolic Blood Pressure and Alpha Adjustment
private _vasoconstriction = switch (true) do {
    case (_bloodPressureDiastolic <= 40): { 1.5 + _alphaFactorAdjustment };
    case (_bloodPressureDiastolic >= 120): { 0.5 + _alphaFactorAdjustment };
    default { (1.5 - (_bloodPressureDiastolic - 40) * (1 / 80)) + _alphaFactorAdjustment };
};

_unit setVariable [QEGVAR(pharma,alphaAction), (1.7 min (0.3 max _vasoconstriction)), _syncValues];
// (END CARDIAC BRANCH)

private _bloodPressure = [round(_bloodPressureDiastolic),round(_bloodPressureSystolic)];
_unit setVariable [VAR_BLOOD_PRESS, _bloodPressure, _syncValues];

_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];

// Statements are ordered by most lethal first.
// Add SpO2 reactions to switch statement ---------------------------------------------------------------------
switch (true) do {
    case ((_bloodVolume select 0) < BLOOD_VOLUME_FATAL): {
        TRACE_3("BloodVolume Fatal",_unit,BLOOD_VOLUME_FATAL,(_bloodVolume select 0));
        [QACEGVAR(medical,Bleedout), _unit] call CBA_fnc_localEvent;
    };
    case (_spo2 < EGVAR(breathing,SpO2_dieValue) && EGVAR(breathing,SpO2_dieActive)): {
        TRACE_3("O2 Fatal",_unit,OXYGEN_PERCENTAGE_FATAL,_spo2);
        [QACEGVAR(medical,Bleedout), _unit] call CBA_fnc_localEvent;
    };
    case (IN_CRDC_ARRST(_unit)): {}; // if in cardiac arrest just break now to avoid throwing unneeded events
    case (_spo2 < EGVAR(breathing,SpO2_cardiacValue) && EGVAR(breathing,SpO2_cardiacActive)): {
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_hemorrhage == 4): {
        TRACE_3("Class IV Hemorrhage",_unit,_hemorrhage,(_bloodVolume select 0));
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_heartRate < 20 || {_heartRate > 220}): {
        TRACE_2("heartRate Fatal",_unit,_heartRate);
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_bloodPressureH < 50 && {_bloodPressureL < 40} && {_heartRate < 40}): {
        TRACE_4("bloodPressure (H & L) + heartRate Fatal",_unit,_bloodPressureH,_bloodPressureL,_heartRate);
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_bloodPressureL >= 190): {
        TRACE_2("bloodPressure L above limits",_unit,_bloodPressureL);
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_heartRate < 30): {  // With a heart rate below 30 but bigger than 20 there is a chance to enter the cardiac arrest state
        private _nextCheck = _unit getVariable [QACEGVAR(medical_vitals,nextCheckCriticalHeartRate), CBA_missionTime];
        private _enterCardiacArrest = false;
        if (CBA_missionTime >= _nextCheck) then {
            _enterCardiacArrest = random 1 < (0.4 + 0.6*(30 - _heartRate)/10);  // Variable chance of getting into cardiac arrest.
            _unit setVariable [QACEGVAR(medical_vitals,nextCheckCriticalHeartRate), CBA_missionTime + 5];
        };
        if (_enterCardiacArrest) then {
            TRACE_2("Heart rate critical. Cardiac arrest",_unit,_heartRate);
            [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
        } else {
            TRACE_2("Heart rate critical. Critical vitals",_unit,_heartRate);
            [QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
        };
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
    hintSilent format["blood volume: %1, blood loss: [%2, %3]\nhr: %4, bp: %5, pain: %6", round((_bloodVolume select 0) * 100) / 100, round(_woundBloodLoss * 1000) / 1000, round((_woundBloodLoss / (0.001 max _cardiacOutput)) * 100) / 100, round(_heartRate), _bloodPressure, round(_painLevel * 100) / 100];
};
#endif

END_COUNTER(Vitals);

true
