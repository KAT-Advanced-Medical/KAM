#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Player <Player>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_giveUnitGasMask;
 *
 * Public: No
*/

params ["_medic", "_patient"];

private _itemArr = _medic call ACEFUNC(common,uniqueItems);
private _playerHasGasmask = false;
private _playerGasMask = "";
{ if (_x in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {_playerHasGasmask = true; _playerGasMask = _x} } forEach _itemArr;

private _fnc_replaceItem = {
    params["_medic", "_patient", "_playerGasMask"];

    if (goggles _patient == "") then {
        _patient linkItem _playerGasMask;
    } else {
        private _pCurGoggles = goggles _patient;
        [_patient, _pCurGoggles] call ACEFUNC(common,addToInventory);
        _patient linkItem _playerGasMask;
    };
};

// Take the mask out of the inventory it came from, so it isn't duplicated when linked to the patient
private _maskRemoved = if (_playerHasGasmask) then {
    [_medic,_playerGasMask] call ACEFUNC(common,useItem)
} else {
    _itemArr = _patient call ACEFUNC(common,uniqueItems);
    { if (_x in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {_playerGasMask = _x} } forEach _itemArr;
    [_patient,_playerGasMask] call ACEFUNC(common,useItem)
};

// Mask is gone (e.g. moved during the treatment), don't create one from nothing
if !(_maskRemoved) exitWith {};

[_medic,_patient,_playerGasMask] call _fnc_replaceItem;
