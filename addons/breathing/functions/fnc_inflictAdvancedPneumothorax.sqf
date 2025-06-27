#include "..\script_component.hpp"
/*
 * Author: Blue
 * Inflict advanced pneumothorax
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Deterioration chance increase <NUMBER>
 * 2: Has deteriorated? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 15, 1, false] call kat_breathing_fnc_inflictAdvancedPneumothorax;
 *
 * Public: No
 */

params ["_unit", "_chanceIncrease", "_side", ["_deteriorated", false]];

// Retrieve current state for the specified side
private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]];
private _hemoState = (_unit getVariable [QGVAR(hemopneumothorax), [false, false]]) select _side;
private _tensionState = (_unit getVariable [QGVAR(tensionpneumothorax), [false, false]]) select _side;
if ((floor (random 100) < (GVAR(advPtxChance) + _chanceIncrease) || _deteriorated) && !(_hemo || _tension)) then {
    [_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);

    if (floor (random 100) < GVAR(hptxChance)) then {
        _hemoState set [_side, true];
        _unit setVariable [QGVAR(hemopneumothorax), _hemoState, true];

        private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
            if ((_ht findIf {_x isEqualTo "hemo"}) == -1) then {
            _ht pushBack "hemo";
            };
        _pneumothoraxState set [_side, 16];
        _unit setVariable [QGVAR(pneumothorax), _pneumothoraxState, true];

        [_unit] call EFUNC(circulation,updateInternalBleeding);
    } else {
        _tensionState set [_side, true];
        _unit setVariable [QGVAR(tensionpneumothorax), _tensionState, true];

        _pneumothoraxState set [_side, 16];
        _unit setVariable [QGVAR(pneumothorax), _pneumothoraxState, true];
    };
};