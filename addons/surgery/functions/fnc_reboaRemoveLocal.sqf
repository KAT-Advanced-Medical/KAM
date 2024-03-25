#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for removing REBOA.
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_reboaRemoveLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _tourniquets = GET_TOURNIQUETS(_patient);
private _surgicalBlock = GET_SURGICAL_TOURNIQUETS(_patient);

_tourniquets set [1, 0];
_tourniquets set [4, 0];
_tourniquets set [5, 0];
_patient setVariable [VAR_TOURNIQUET, _tourniquets, true];

_surgicalBlock set [1, 0];
_surgicalBlock set [4, 0];
_surgicalBlock set [5, 0];
_patient setVariable [QGVAR(surgicalBlock), _surgicalBlock, true];

_patient setVariable [QGVAR(reboa), false, true];

[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);

[_patient] call EFUNC(misc,updateDamageEffects);

private _nearPlayers = (_patient nearEntities ["CAManBase", 6]) select {_x call ACEFUNC(common,isPlayer)};
TRACE_1("clearConditionCaches: tourniquetRemove",_nearPlayers);
[QACEGVAR(interact_menu,clearConditionCaches), [], _nearPlayers] call CBA_fnc_targetEvent;

// Handle occluded medications that were blocked due to tourniquet
private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
private _arrayModified = false;

if !(((_patient getVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0]]) select _partIndex) isEqualTo 3) then {
    {
        _x params ["_bodyPartN", "_medication"];

        if (_partIndex == _bodyPartN) then {
            TRACE_1("delayed medication call after tourniquet removal",_x);
            [QEGVAR(pharma,medicationLocal), [_patient, _bodyPart, _medication], _patient] call CBA_fnc_targetEvent;
            _occludedMedications set [_forEachIndex, []];
            _arrayModified = true;
        };

    } forEach _occludedMedications;

    if (_arrayModified) then {
        _occludedMedications = _occludedMedications - [[]];
        _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
    };
};
