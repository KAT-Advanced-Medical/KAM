#include "..\script_component.hpp"
/*
 * Author: Glowbal, Edited by MiszczuZPolski
 * Local callback for applying a tourniquet to a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "LeftLeg"] call kat_misc_fnc_headTourniquetLocal
 *
 * Public: No
 */

params ["_patient", "_bodyPart"];
TRACE_2("tourniquetLocal",_patient,_bodyPart);

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

private _tourniquets = GET_TOURNIQUETS(_patient);
_tourniquets set [_partIndex, CBA_missionTime];
_patient setVariable [VAR_TOURNIQUET, _tourniquets, true];

[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);

private _nearPlayers = (_patient nearEntities ["CAManBase", 6]) select {_x call ACEFUNC(common,isPlayer)};
TRACE_1("clearConditionCaches: tourniquetLocal",_nearPlayers);
[QACEGVAR(interact_menu,clearConditionCaches), [], _nearPlayers] call CBA_fnc_targetEvent;

[{
    params ["_patient", "_tourniquets", "_partIndex"];

    private _tourniquetActual = _tourniquets select _partIndex;
    if (_tourniquetActual == 0) exitWith {};

    [_patient, "Tourniqueted to death!"] call ACEFUNC(medical_status,setDead);
}, [_patient, _tourniquets, _partIndex], 60] call CBA_fnc_waitAndExecute;
