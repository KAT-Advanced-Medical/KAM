/*
 * Author: Katalam
 * Function for treatment of the allergical reaction to a bee thing
 *
 * Arguments:
 * 0: _unit <OBJECT>
 * 1: _target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceDisability_fnc_treatmentAdvanced_tracheaLocal;
 *
 * Public: No
 */

params ["_unit", "_target"];

_target setVariable ["kat_aceAirway_swollen", false, true];
[_target, false] call ace_medical_fnc_setUnconscious;
_target setVariable ["kat_aceDisability_checked", false, true];

// message output
private _output = localize "STR_kat_aceDisability_Done";
[_output, 1.5, _unit] call ace_common_fnc_displayTextStructured;

// medical menu output
[_target, localize "STR_kat_aceDisability_Done_log2"] call ace_medical_fnc_addToTriageCard;
[_target, "activity", localize "STR_kat_aceDisability_Done_log", [[_unit] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;
[_target, "quick_view", localize "STR_kat_aceDisability_Done_log", [[_unit] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;

// destroy pp effect in 30 sec smoothly
private _allergical = _target getVariable ["kat_aceDisability_allergicalreaction", []];
_allergical params ["", "_ppeffect"];
_ppeffect ppEffectAdjust [
 1,
 1,
 0,
 [0, 0, 0, 0],
 [1, 1, 1, 1],
 [0.6, 0.6, 0.2, 0],
 [-1, -1, 0, 1, 0, 0, 0]
];
_ppeffect ppEffectCommit 30;
[{ppEffectDestroy _this}, [_ppeffect], 30] call CBA_fnc_waitAndExecute;
