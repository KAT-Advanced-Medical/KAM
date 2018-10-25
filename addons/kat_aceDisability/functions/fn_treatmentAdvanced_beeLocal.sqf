/*
 * Author: Katalam
 * Function for treatment of the alergical reaction to a bee thing
 *
 * Arguments:
 * 0: _target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceDisability_fnc_treatmentAdvanced_beeLocal;
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable ["kat_aceDisability_allergicalreaction", false];
//_unit setVariable ["kat_aceAirway_swollen", false];
[_unit, false] call ace_medical_fnc_setUnconscious;
_unit setVariable ["kat_aceDisability_checked", false];
