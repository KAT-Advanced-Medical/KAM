#include "script_component.hpp"
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
private _playerhasGasmask = false;
private _playerGasMask = "";
{ if(_x in GVAR(availGasmaskList)) then {_playerhasGasmask = true; _playerGasMask = _x} } forEach _itemArr;

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

if (_playerhasGasmask) then {
    [_medic,_playerGasMask] call ACEFUNC(common,useItem);
    [_medic,_patient,_playerGasMask] call _fnc_replaceItem;
} else {
    _itemArr = _patient call ACEFUNC(common,uniqueItems);
    { if(_x in GVAR(availGasmaskList)) then {_playerGasMask = _x} } forEach _itemArr;
    [_medic,_patient,_playerGasMask] call _fnc_replaceItem;
};
