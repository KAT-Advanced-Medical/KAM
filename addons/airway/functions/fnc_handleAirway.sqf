#include "script_component.hpp"
/*
 * Author: Katalam
 * Handler for airway damage.
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

// Contusion -> pneumo?

private "_className";
private _airwayInjuries = 0;

{
    _x params ["", "_woundClassID", "_bodyPartN"];

    // If any single gun shot wound is here go ahead (or burns)
    if (_bodyPartN == 0) exitWith {
        _className = ace_medical_damage_woundsData select _woundClassID select 6;
        if (toLower _className in ["velocitywound", "contusion"]) then {
            _airwayInjuries = _airwayInjuries + 1;
        };
    };
    false;
} forEach (_unit getVariable ["ace_medical_openWounds", []]);

if (_airwayInjuries == 0) exitWith {};

[{
    params ["_unit"];
    if (((eyeDirection _unit) select 2) < -0.02) then {
        if !(_unit getVariable [QGVAR(obstruction), false]) then {
            _unit setVariable [QGVAR(obstruction), true, true];
        };
    };
}, [_unit], 2] call CBA_fnc_waitAndExecute;
