#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for applying Deep REBOA.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_reboaDeepApplyLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _tourniquets = GET_TOURNIQUETS(_patient);
private _surgicalBlock = _patient getVariable [QGVAR(surgicalBlock), [0,0,0,0,0,0]];

_tourniquets set [1, CBA_missionTime];
_patient setVariable [VAR_TOURNIQUET, _tourniquets, true];

_surgicalBlock set [1, 1];
_patient setVariable [QGVAR(surgicalBlock), _surgicalBlock, true];

[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);

private _nearPlayers = (_patient nearEntities ["CAManBase", 6]) select {_x call ACEFUNC(common,isPlayer)};
TRACE_1("clearConditionCaches: tourniquetLocal",_nearPlayers);
[QACEGVAR(interact_menu,clearConditionCaches), [], _nearPlayers] call CBA_fnc_targetEvent;