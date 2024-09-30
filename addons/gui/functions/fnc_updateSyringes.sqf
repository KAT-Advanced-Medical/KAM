#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks the syringes in the players inventory and then populates the listbox with the syringes,
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call kat_medical_gui_fnc_updateSyringes;
 *
 * Public: No
 */
private _syringes = [
    "kat_10ml_syringe",
    "kat_5ml_syringe"
];
private _playerInventory = items player;
private _foundSyringes = [];
{
    if (_x in _syringes) then {
        _foundSyringes pushBack _x;
    };
} forEach _playerInventory;
private _listBox = findDisplay 38580 displayCtrl 71303;
lbClear _listBox;
{
    _listBox lbAdd _x;
} forEach _foundSyringes;