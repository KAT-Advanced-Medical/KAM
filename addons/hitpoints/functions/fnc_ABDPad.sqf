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

_this set [7, _this param [7, 1]]; // set bandage effectiveness coefficient
[QACEGVAR(medical_treatment,bandaged), _this] call CBA_fnc_localEvent;

params ["_medic", "_patient", "_bodyPart", "_classname", "", "", "", "_bandageEffectiveness"];

[_patient, "activity", LSTRING(Activity_bandagedPatient), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QACEGVAR(medical_treatment,bandageLocal), [_patient, _bodyPart, _classname, _bandageEffectiveness], _patient] call CBA_fnc_targetEvent;

[_patient, _bodyPart] call FUNC(ABDPadLocal);