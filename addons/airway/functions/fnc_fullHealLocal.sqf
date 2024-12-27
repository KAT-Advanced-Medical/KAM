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
 * [player] call kat_airway_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

/* 
0 = No Stenosis (Grade 1)
1 = Light Stenosis (Grade 2)
2 = Heavy Stenosis (Grade 3)
3 = Full Stenosis/Removable (Grade 4)
4 = Full Stenosis/Not Removable (Surgical Grade 4)
*/
_patient setVariable [QGVAR(occlusion), 0, true];
_patient setVariable [QGVAR(airwaySurgical), false, true];

// Oral Obstruction, Upper Obstruction, Lower Obstruction
_patient setVariable [QGVAR(obstruction), [false, false, false], true];
_patient setVariable [QGVAR(airwayClear), true, true];

_patient setVariable [QGVAR(airway_item), "", true];

_patient setVariable [QGVAR(headTilt), false, true];
_patient setVariable [QGVAR(recovery), false, true];
