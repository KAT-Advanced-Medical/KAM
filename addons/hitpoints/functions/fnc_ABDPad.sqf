#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * splitter function for ABD pad treatment
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Head", "FieldDressing"] call kat_hitpoints_ABDPad
 *
 * Public: No
 */

[QACEGVAR(medical_treatment,bandaged), _this] call CBA_fnc_localEvent;

params ["_medic", "_patient", "_bodyPart", "_classname"];

[_patient, "activity", ACELSTRING(medical_treatment,Activity_bandagedPatient), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
[_patient, _bodyPart, _classname] call EFUNC(misc,bandageLocal);

[_patient, _bodyPart] call FUNC(ABDPadLocal);