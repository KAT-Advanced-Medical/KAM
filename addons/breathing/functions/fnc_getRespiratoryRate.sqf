#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Calculate patient's Respiratory Rate based on status of their vitals.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * Respiratory Rate <INT>
 *
 * Example:
 * [player] call kat_breathing_fnc_getRespiratoryRate;
 *
 * Public: No
 */

params ["_patient"];

if !(alive _patient) exitWith {0};

private _bloodVolume = GET_BLOOD_VOLUME(_patient);
private _lostBlood = 6.0 - _bloodVolume;

private _ptxTarget = _patient getVariable [QGVAR(pneumothorax), 0]; // more deteriorated closer to 4, at 4 likely to become advanced
private _hasHtx = _patient getVariable [QGVAR(hemopneumothorax), false];
private _hasTptx = _patient getVariable [QGVAR(tensopneumothorax), false];

private _airwayObstructed = _patient getVariable [QEGVAR(airway,obstruction), false] && !(_patient getVariable [QEGVAR(airway,overstretch), false]);
private _airwayOccluded = _patient getVariable [QEGVAR(airway,occluded), false];

private _randomOffset = selectRandom [-1,0,1];
private _respiratoryRate = 16 + _randomOffset;

// calculate respiratoryrate for blood loss
if (_lostBlood >= 0.2) then {
    _respiratoryRate = (_respiratoryRate + (floor (_lostBlood / 0.2))); // increase breath rate by 1 per 200ml lost
};
// calculate respiratoryrate for ptxs
_respiratoryRate = [_respiratoryRate + 9,  _respiratoryRate + (_ptxTarget * 2)] select (_hasHtx || _hasTptx);

switch (true) do {
    //cardiac arrest
    case (IN_CRDC_ARRST(_patient)): {0};

    //airways blocked
    case (_airwayObstructed || _airwayOccluded): {0};

    //able to breathe
    default {_respiratoryRate};
};