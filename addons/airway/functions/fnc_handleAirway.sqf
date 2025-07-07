#include "..\script_component.hpp"
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
 * [player] call kat_airway_fnc_handleAirway;
 *
 * Public: No
 */

params ["_unit"];

//Other mods can utilise KAT_Obstruction_Exclussion variable to prevent obstructions from happening
if !(GVAR(enable)) exitWith {};
if (random(100) < GVAR(airwayObstructionChance)) then {
    private _obstruction = _unit getVariable [QGVAR(obstruction), [0, 0, 0]];
    _obstruction set [0, (((_obstruction select 0) + 1) min 2)];
    _unit setVariable [QGVAR(obstruction), _obstruction, true];
};
[{
    params ["_unit"];
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _airwayStatus = _unit getVariable [QGVAR(airwayStatus), [0, 0, 0]];
    if (_isUnconscious && (_airwayStatus select 1 == 0)) then {
    private _obstruction = _unit getVariable [QGVAR(obstruction), [0, 0, 0]];
    _obstruction set [1, (((_obstruction select 1) + 1) min 2)];
    _unit setVariable [QGVAR(obstruction), _obstruction, true];
    };
}, [_unit], (GVAR(airwayCollapse_Timer)  * random [0.8, 1, 1.3])] call CBA_fnc_waitAndExecute;

[{
    params ["_unit"];
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _airwayStatus = _unit getVariable [QGVAR(airwayStatus), [0, 0, 0]];
    if (_isUnconscious && (_airwayStatus select 2 == 0)) then {
    private _obstruction = _unit getVariable [QGVAR(obstruction), [0, 0, 0]];
    _obstruction set [2, (((_obstruction select 2) + 1) min 2)];
    _unit setVariable [QGVAR(obstruction), _obstruction, true];
    };
}, [_unit], (GVAR(airwayCollapse_Timer)  * random [0.8, 1, 1.3] * 2)] call CBA_fnc_waitAndExecute;


