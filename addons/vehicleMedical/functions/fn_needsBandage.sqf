#include "function_macros.hpp"

params[
    "_patient"
];

_needBandage = false;
_wounds = _patient call FUNC(getOpenWounds);
{ 
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"]; 
    if ((_amountOf * _bleeding) > 0) exitWith {
        _needBandage = true;
    }; 
    false
}forEach _wounds;
_needBandage