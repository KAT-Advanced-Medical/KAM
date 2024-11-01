#include "..\script_component.hpp"
/*
* Author: DiGii
* This cannot be called manually!
* Handles the Gas effect for the player
*
* Arguments:
* 0: Target <OBJECT>
* 1: Module <logic>
* 2: Position <ARRAY>
* 3: Max_radius <NUMBER>
* 4: Min_radius <NUMBER>
* 5: Gastype <STRING>
*
* Return Value:
* NONE
*
* Example:
* [player, logic, getPos player, 50, 20, 0] call kat_chemical_fnc_gasChecklocal;
*
* Public: No
*/

params ["_unit", "_logic", "_position", "_radius_max", "_radius_min", "_gasType"];

if (!isDamageAllowed _unit) exitWith {
    [_unit] call FUNC(fullHealLocal);
};

private _timeEntered = CBA_MissionTime;

// Function to handle the per-frame logic for gas effects

[{
    params ["_args", "_handler"];
    _args params ["_logic", "_unit", "_position"];

    if (_unit getVariable [QGVAR(isTreated), false] || !(_logic getVariable [QGVAR(gas_active), false])) exitWith {
        _unit setVariable [QGVAR(enteredPoison), false, true];
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

}, 3, [_logic, _unit, _position]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_handler"];
    _args params ["_unit", "_logic", "_position", "_radius_max", "_radius_min", "_gasType", "_timeEntered"];

    if (!(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic || _unit getVariable [QGVAR(isTreated), false]) exitWith {
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

    _position = _logic getVariable [QGVAR(gas_position), [0, 0, 0]];
    private _distance = _unit distance _position;
    private _min_to_max = _radius_max - _radius_min;
    private _dis_to_min = _distance - _radius_min;
    private _percent = 0;

    if (_distance > _radius_min) then {
        _percent = _dis_to_min / _min_to_max;
    };

    private _timeLeft = _unit getVariable [QGVAR(timeleft), 0];
    if (_timeLeft <= 0) exitWith
    {
        [_handler] call CBA_fnc_removePerFrameHandler;
        [QGVAR(afterWait), [_unit, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
        _unit setVariable [QGVAR(timeleft), 0];
    };

    if (_distance < _radius_max) then {
        if !(_unit getVariable [QGVAR(enteredPoison), false]) then {
            _unit setVariable [QGVAR(enteredPoison), true, true];
            [QGVAR(enteredZone), [_unit], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(Poisen_logic), _logic, true];
        };

        _timeLeft = (missionNamespace getVariable [QGVAR(infectionTime),60]) - (CBA_MissionTime - _timeEntered);
        _unit setVariable [QGVAR(timeleft), _timeLeft];
    };

    if (_distance > _radius_max || !(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic) then {
        _unit setVariable [QGVAR(enteredPoison), false, true];
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

    if (_gasType isEqualTo 1) then {
        [_handler] call CBA_fnc_removePerFrameHandler;
        [QGVAR(afterWait), [_unit, _logic, _gasType, _radius_max], _unit] call CBA_fnc_targetEvent;
    };

}, 2, [_unit, _logic, _position, _radius_max, _radius_min, _gasType, _timeEntered]] call CBA_fnc_addPerFrameHandler;
