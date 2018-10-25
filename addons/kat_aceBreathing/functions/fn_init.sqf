/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceBreathing_fnc_init
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable ["kat_aceBreathing_pulsoximeter", false];
/*
_a = (_unit getVariable "ace_medical_airwayStatus") - 0.1;
_unit setVariable ["ace_medical_airwayStatus", _a];
_unit setVariable ["ace_medical_airwayStatus", 100];
*/
