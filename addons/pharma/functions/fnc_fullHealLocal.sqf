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
 * [player] call kat_pharma_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal kat pharma",_patient);

/*
* 0 = No IV
* 1 = IO
* 2 = IV
* 3 = IV w/ Block
* 4 = IV w/ Flush
*/

_patient setVariable [QGVAR(alphaAction), 1, true];
_patient setVariable [QGVAR(IV), [0,0,0,0,0,0], true];
_patient setVariable [QGVAR(IVpfh), [0,0,0,0,0,0], true];
_patient setVariable [QGVAR(active), false, true];
_patient setVariable [QGVAR(IVPharma_PFH), nil, true];
_patient setVariable [QGVAR(pH), 1500, true];
_patient setVariable [QGVAR(kidneyFail), false, true];
_patient setVariable [QGVAR(kidneyArrest), false, true];
_patient setVariable [QGVAR(kidneyPressure), false, true];
_patient setVariable [QGVAR(coagulationFactor), 10, true];
