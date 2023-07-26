#include "script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Removes the tourniquet from the patient on the given body part.
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_tourniquetRemove
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];
TRACE_3("tourniquetRemove",_medic,_patient,_bodyPart);

// Remove tourniquet from body part, exit if no tourniquet applied
private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _tourniquets = GET_TOURNIQUETS(_patient);

if (_tourniquets select _partIndex == 0) exitWith {
    [ACELSTRING(medical_treatment,noTourniquetOnBodyPart), 1.5] call ACEFUNC(common,displayTextStructured);
};

_tourniquets set [_partIndex, 0];
_patient setVariable [VAR_TOURNIQUET, _tourniquets, true];

[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);

private _nearPlayers = (_patient nearEntities ["CAManBase", 6]) select {_x call ACEFUNC(common,isPlayer)};
TRACE_1("clearConditionCaches: tourniquetRemove",_nearPlayers);
[QEGVAR(interact_menu,clearConditionCaches), [], _nearPlayers] call CBA_fnc_targetEvent;

// Add tourniquet item to medic or patient
private _receiver = [_patient, _medic, _medic] select ACEGVAR(medical_treatment,allowSharedEquipment);
[_receiver, "ACE_tourniquet"] call ACEFUNC(common,addToInventory);

// Handle occluded medications that were blocked due to tourniquet
private _occludedMedications = _patient getVariable [QEGVAR(medical,occludedMedications), []];
private _arrayModified = false;

if !(((_patient getVariable [QGVAR(IV), [0,0,0,0,0,0]]) select _partIndex) isEqualTo 3) then {
    {
        _x params ["_bodyPartN", "_medication"];

        if (_partIndex == _bodyPartN) then {
            TRACE_1("delayed medication call after tourniquet removeal",_x);
            [QGVAR(medicationLocal), [_patient, _bodyPart, _medication], _patient] call CBA_fnc_targetEvent;
            _occludedMedications set [_forEachIndex, []];
            _arrayModified = true;
        };

    } forEach _occludedMedications;

    if (_arrayModified) then {
        _occludedMedications = _occludedMedications - [[]];
        _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
    };
};