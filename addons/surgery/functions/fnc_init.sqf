#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_surgery_fnc_init;
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

_unit setVariable [QGVAR(fractures), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(lidocaine), false, true];
_unit setVariable [QGVAR(etomidate), false, true];
_unit setVariable [QGVAR(sedated), false, true];
_unit setVariable [QGVAR(imaging), false, true];
_unit setVariable [QGVAR(reboa), false, true];
_unit setVariable [QGVAR(surgicalBlock), [0,0,0,0,0,0], true];

/*
* 0 = Unaffected
* 1 = Stable Fracture
* 2 = Compound Fracture
* 3 = Comminuted Fracture
* 2.1/3.1 = Open Fracture
* 2.2/3.2 = Prepared Fracture
* 2.5 = Irrigated Fracture
* 3.5 = Clamped Fracture
*/
