#include "..\script_component.hpp"
/*
 * Author: AmsteadRayle
 * Modified: Blue
 * Counts how many of the given items are present between the medic and patient.
 * If medic or patient are in a vehicle then vehicle's inventory will also be checked.
 *
 * Arguments:
 * 0: Items <ARRAY>
 *
 * Return Value:
 * Counts (can be nil) <ARRAY>
 *
 * Example:
 * [items] call ace_medical_gui_fnc_countTreatmentItems
 *
 * Public: No
 */

params ["_items"];

private _medicCount = 0;
private _patientCount = nil;
private _vehicleCount = nil;

// Medic
{
    _medicCount = _medicCount + ([ACE_player, _x] call ACEFUNC(common,getCountOfItem));
} forEach _items;

// Patient
if (ACE_player != ACEGVAR(medical_gui,target)) then {
    _patientCount = 0;
    {
        _patientCount = _patientCount + ([ACEGVAR(medical_gui,target), _x] call ACEFUNC(common,getCountOfItem));
    } forEach _items;
};

// Vehicle
private _medicVehicle = objectParent ACE_player;
private _patientVehicle = objectParent ACEGVAR(medical_gui,target);
private _vehicle = ([_patientVehicle, _medicVehicle] select (!isNull _medicVehicle));

if !(isNull _vehicle) then {
    _vehicleCount = 0;
    if (((_items select 0) call BIS_fnc_itemType) select 0 isEqualTo "Magazine") then {
        (getMagazineCargo _vehicle) params ["_itemTypes", "_itemCounts"];
        {
            private _item = _x;
            private _index = _itemTypes find _item;
            _vehicleCount = _vehicleCount + (_itemCounts param [_index, 0]);
        } forEach _items;
    } else {
        (getItemCargo _vehicle) params ["_itemTypes", "_itemCounts"];
        {
            private _item = _x;
            private _index = _itemTypes find _item;
            _vehicleCount = _vehicleCount + (_itemCounts param [_index, 0]);
        } forEach _items;
    };
};

[_medicCount, _patientCount, _vehicleCount]
