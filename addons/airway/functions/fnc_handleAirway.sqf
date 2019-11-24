#include "script_component.hpp"
/*
 * Author: Katalam
 * Will add a airway injury if possible. Called with the ace_medical_injured cba event.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call KAM_airway_fnc_handleAirway;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(enable)) exitWith {};

private _reasons = _unit call FUNC(possibleAirwayInjury);
_reasons params ["_possible", "_array"];
_array params ["_airwayInjuries", "_chestWounds"];

if (_possible) then { // _reasons return in the first value a quick boolean if injurys are possible
    if (_airwayInjuries > 0) then {
        _unit call FUNC(bloodHandler);
    };
    if (_chestWounds > 0 && {EGVAR(breathing,enable)}) then {
        if (selectRandom [true, false]) then {
            // call hemothorax
        } else {
            // call pneumothorax
        };
    };
};

/*

    Bleeding neck?
    Blocked airway tonque?
    pneumo?

*/
