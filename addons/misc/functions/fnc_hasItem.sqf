#include "script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Checks if one of the given items are present between the medic and patient.
 * Does not respect the priority defined by the allowSharedEquipment setting.
 * Will check medic first and then patient if shared equipment is allowed.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Items <ARRAY>
 *
 * Return Value:
 * Has Item <BOOL>
 *
 * Example:
 * [player, cursorObject, ["ACE_fieldDressing"]] call ace_medical_treatment_fnc_hasItem
 *
 * Public: No
 */

params ["_medic", "_patient", "_items"];

private _fnc_checkItems = {
    params ["_origin",["_isVehicle",false]];

    private _containedItems = [_origin,_isVehicle] call FUNC(getUniqueItems);
    private _foundItem = _items findIf {_x in _containedItems} != -1;

    if !(_foundItem) then {
        _containedItems = [_origin,_isVehicle, true] call FUNC(getUniqueItems);
        _foundItem = _items findIf {_x in _containedItems} != -1;
    };

    _foundItem
};

private _vehicleCondition = (vehicle _medic) != _medic && (vehicle _medic) isEqualTo (vehicle _patient);

_medic call _fnc_checkItems || {ACEGVAR(medical_treatment,allowSharedEquipment) != 2 && {_patient call _fnc_checkItems}} || {_vehicleCondition && [(vehicle _medic), true] call _fnc_checkItems && (GVAR(allowSharedVehicleEquipment) in [1,3,4] || (GVAR(allowSharedVehicleEquipment) isEqualTo 2 && _patient != _medic))}