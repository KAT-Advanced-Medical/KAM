#include "..\script_component.hpp"
/*
 * Author: YetheSamartaka, Brett Mayson
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_misc_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

if (!local _unit) exitWith {};

[_unit] call FUNC(fullHealLocal);

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