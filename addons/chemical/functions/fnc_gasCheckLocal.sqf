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
* [player, logic, getPos player, 50, 20, "Toxic"] call kat_chemical_fnc_gasChecklocal;
*
* Public: No
*/

params ["_unit", "_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];

if (!isDamageAllowed _unit) exitWith {
    [_unit] call FUNC(clearChemicalInjuriesLocal);
};

// Function to handle the per-frame logic for gas effects
private _perFrameHandler = {
    params ["_args"];
    _args params ["_logic", "_unit", "_pos"];

    if (_unit getVariable [QGVAR(isTreated), false] || !(_logic getVariable [QGVAR(gas_active), false])) exitWith {
        _unit setVariable [QGVAR(enteredPoison), false, true];
        [_handler] call CBA_fnc_removePerFrameHandler;
    };
};

private _perFrameHandlerArgs = [_logic, _unit, _pos];
[_perFrameHandler, 3, _perFrameHandlerArgs] call CBA_fnc_addPerFrameHandler;

// Main per-frame handler to apply gas effects
private _mainHandler = {
    params ["_args"];
    _args params ["_unit", "_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];

    if (!(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic || _unit getVariable [QGVAR(isTreated), false]) exitWith {
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

    _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
    private _distance = _unit distance _pos;
    private _min_to_max = _radius_max - _radius_min;
    private _dis_to_min = _distance - _radius_min;
    private _percent = 0;

    if (_distance > _radius_min) then {
        _percent = _dis_to_min / _min_to_max;
    };

    if (_distance < _radius_max) then {
        if !(_unit getVariable [QGVAR(enteredPoison), false]) then {
            _unit setVariable [QGVAR(enteredPoison), true, true];
            [QGVAR(enteredPoisonEvent), [_unit], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(Poisen_logic), _logic, true];
            _unit setVariable [QGVAR(timeleft), CBA_missiontime];
        };

        [QGVAR(afterWait), [_unit, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
        _unit setVariable [QGVAR(timeleft), 0];
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

    if (_distance > _radius_max || !(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic) then {
        _unit setVariable [QGVAR(enteredPoison), false, true];
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

    if (_gastype isEqualTo "CS") then {
        [_handler] call CBA_fnc_removePerFrameHandler;
        [QGVAR(afterWait), [_unit, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
    };
};

private _mainHandlerArgs = [_unit, _logic, _pos, _radius_max, _radius_min, _gastype];
[_mainHandler, 2, _mainHandlerArgs] call CBA_fnc_addPerFrameHandler;
