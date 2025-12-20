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

params ["_unit", "_side", ["_deteriorated", false]];
TRACE_3("advanced PTX",_unit,_chanceIncrease,_side);
// Retrieve current state for the specified side
private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]];
private _tensionState = _unit getVariable [QGVAR(tensionpneumothorax), [false, false]];
if ((floor (random 100) < (GVAR(advPtxChance)) || _deteriorated) && !(_tensionState select _side)) then {
    [_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);
    _tensionState set [_side, true];
    _unit setVariable [QGVAR(tensionpneumothorax), _tensionState, true];
    private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
    if ((_ht findIf {_x isEqualTo "tension"}) == -1) then {
    _ht pushBack "tension";
    _unit setVariable [QEGVAR(circulation,ht), _ht, true];
    };
};