#include "..\script_component.hpp"
/*
 * Author: Glowbal, Mazinski
 * Updates the vitals for simple AI. Called from the statemachine's onState functions.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * Update Ran (at least 1 second between runs) <BOOL>
 *
 * Example:
 * [player] call kat_vitals_fnc_handleSimpleVitals;
 *
 * Public: No
 */

params ["_unit"];

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
private _bloodVolume = GET_SIMPLE_BLOOD_VOLUME(_unit);
private _woundBloodLoss = GET_WOUND_BLEEDING(_unit);

private _bloodVolume = _bloodVolume - (_woundBloodLoss / 100);
_unit setVariable [VAR_BLOOD_VOL, _bloodVolume, _syncValues];

private _inPain = GET_PAIN_PERCEIVED(_unit) > 0;
if !(_inPain isEqualTo IS_IN_PAIN(_unit)) then {
    _unit setVariable [VAR_IN_PAIN, _inPain, true];
};

// Get Medication Adjustments:
private _hrTargetAdjustment = 0;
private _painSupressAdjustment = 0;
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
        };
    } forEach _adjustments;

    if (_deleted) then {
        _unit setVariable [VAR_MEDICATIONS, _adjustments - [objNull], true];
        _syncValues = true;
    };
};

private _heartRate = [_unit, _hrTargetAdjustment, _deltaT, _syncValues] call ACEFUNC(medical_vitals,updateHeartRate); //Rename
[_unit, _painSupressAdjustment, _deltaT, _syncValues] call ACEFUNC(medical_vitals,updatePainSuppress); //Leave alone
[_unit, POISON_DECREASE, _deltaT, _syncValues] call FUNC(handlePoisoning);

private _bloodPressure = [80,120];
_unit setVariable [VAR_BLOOD_PRESS, _bloodPressure, _syncValues];

// Statements are ordered by most lethal first.
switch (true) do {
    case (IN_CRDC_ARRST(_unit)): {}; // if in cardiac arrest just break now to avoid throwing unneeded events
    case (_heartRate < 20 || {_heartRate > 220}): {
        TRACE_2("heartRate Fatal",_unit,_heartRate);
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
    case (_bloodVolume < 5): {
        TRACE_2("bloodVolume Fatal",_unit,_heartRate);
        [QACEGVAR(medical,Bleedout), _unit] call CBA_fnc_localEvent;
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
    case (_inPain): {
        [QACEGVAR(medical,LoweredVitals), _unit] call CBA_fnc_localEvent;
    };
};

#ifdef DEBUG_MODE_FULL
if (!isPlayer _unit) then {
    private _painLevel = _unit getVariable [VAR_PAIN, 0];
    hintSilent format["blood volume: %1, blood loss: [%2, %3]\nhr: %4, bp: %5, pain: %6", round(_bloodVolume * 100) / 100, round(_woundBloodLoss * 1000) / 1000, round((_woundBloodLoss / (0.001 max _cardiacOutput)) * 100) / 100, round(_heartRate), _bloodPressure, round(_painLevel * 100) / 100];
};
#endif

END_COUNTER(Vitals);

//placed outside the counter as 3rd-party code may be called from this event
[QACEGVAR(medical,handleUnitVitals), [_unit, _deltaT]] call CBA_fnc_localEvent;

true