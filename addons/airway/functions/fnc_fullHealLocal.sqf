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

_patient setVariable [QGVAR(airway_item), "", true];
_patient setVariable [QGVAR(airway), false, true];
_patient setVariable [QGVAR(clearedTime), 0, true];
_patient setVariable [QGVAR(surgicalAirway), false, true];
_patient setVariable [QGVAR(catastrophicAirway), [false, false], true];
_patient setVariable [QGVAR(obstruction), [0, 0, 0], true];
_patient setVariable [QGVAR(occlusion), [0, 0, 0], true];
_patient setVariable [QGVAR(occlusionMitigation), [false, false, false], true];
_patient setVariable [QGVAR(overstretch), false, true];
_patient setVariable [QGVAR(recovery), false, true];
_patient setVariable [QGVAR(wasOccluded), [0, 0, 0]];
_patient setVariable [QGVAR(hasPuked), false, true];
_patient setVariable [QGVAR(airwayStatus), [0, 0, 0], true]
