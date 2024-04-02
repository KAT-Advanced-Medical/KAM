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
 * [player, 15, false] call kat_breathing_fnc_inflictAdvancedPneumothorax;
 *
 * Public: No
 */

params ["_unit", "_chanceIncrease", ["_deteriorated", false]];

// Prevent the patient from getting both hemothorax and tension pneumothorax at the same time
private _hemo = _unit getVariable [QGVAR(hemopneumothorax), false];
private _tension = _unit getVariable [QGVAR(tensionpneumothorax), false];

// Roll chance to get advanced pneumothorax or skip chance if deteriorated
if ((floor (random 100) <= (GVAR(advPtxChance) + _chanceIncrease) || _deteriorated) && !(_hemo || _tension)) then {
    [_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);

    if (floor (random 100) <= GVAR(hptxChance)) then {
        _unit setVariable [QGVAR(hemopneumothorax), true, true];
        _unit setVariable [QGVAR(pneumothorax), 4, true];
        [_unit] call EFUNC(circulation,updateInternalBleeding);
    } else {
        _unit setVariable [QGVAR(tensionpneumothorax), true, true];
        _unit setVariable [QGVAR(pneumothorax), 4, true];
    };
};