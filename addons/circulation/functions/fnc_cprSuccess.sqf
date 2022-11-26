#include "script_component.hpp"
/*
 * Author: Glowbal
 * Handles finishing performing CPR on the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: CPR type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Body", "CPR"] call ace_medical_treatment_fnc_cprSuccess
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_reviveObject"];
TRACE_2("cprSuccess",_medic,_patient);

_patient setVariable [QACEGVAR(medical,CPR_provider), objNull, true];

if (alive _patient && {_patient getVariable [QACEGVAR(medical,inCardiacArrest), false]}) then {
    TRACE_1("sending cprLocal event",_patient);
    [QACEGVAR(medical_treatment,cprLocal), [_medic, _patient, _reviveObject], _patient] call CBA_fnc_targetEvent;
} else {
    TRACE_1("not alive or in cardiac arrest",_patient);
};