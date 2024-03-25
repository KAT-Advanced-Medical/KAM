#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_surgery_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

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

_patient setVariable [QGVAR(fractures), [0,0,0,0,0,0], true];
_patient setVariable [QGVAR(lidocaine), false, true];
_patient setVariable [QGVAR(etomidate), false, true];
_patient setVariable [QGVAR(sedated), false, true];
