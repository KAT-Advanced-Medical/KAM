#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Check for time to wrap a limb
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body part ("Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg") <STRING>
 *
 * Return Value:
 * Number
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_getWrapTime
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];
private _allowedBandages = ["Compressed_Gauze", "fourByfour_Gauze", "Burn_Dressing", "Hemostatic_Gauze"];
private _wounds = (_patient getVariable ["ace_medical_bandagedWounds", []]) getOrDefault [_bodyPart, []];
private _filtered = _wounds select {
    _x isEqualType [] && {(_x select 4) in _allowedBandages}
};
private _number = count _filtered;
private _time = _number * QGVAR(woundWrapTime);
_time