#include "..\script_component.hpp"

params ["_player"];

private _itemList = _player call ACEFUNC(common,uniqueItems);

{
    if (_x in GVAR(availGasmaskList)) then {
        _player assignItem _x;
        _player call FUNC(maskOverlay);
        break;
    };

} forEach _itemList;
