#include "..\script_component.hpp"
/*
 * Author: DiGii
 * This cannot be called manually!
 *
 * Arguments:
 * 0: Module <Logic>
 * 1: Position <Position>
 * 2: Max_Radius <NUMBER>
 * 3: Min_Radius <Number>
 * 4: GasType <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [logic, getPos player, 50, 20, 1] call kat_chemical_fnc_gasCheck;
 *
 * Public: No
 */

params ["_logic", "_position", "_radius_max", "_radius_min", "_gasType"];

// Set default values if needed
_radius_min = if (_radius_min isEqualTo 0) then {_radius_max / 2} else {_radius_min};

_logic setVariable [QGVAR(gas_active), true, true];
_logic setVariable [QGVAR(gas_playerArr), [], true];
_logic setVariable [QGVAR(gas_position), _position, true];
_logic setVariable [QGVAR(gas_radius), _radius_max, true];

// Function to check players within the gas zone
private _checkPlayers = {
    params ["_args"];
    _args params ["_logic", "_position", "_radius_max", "_radius_min", "_gasType"];
    private _playerArr = _logic getVariable [QGVAR(gas_playerArr), []];
    private _allUnits = if (missionNamespace getVariable [QGVAR(affectAI), false]) then {allUnits} else {allPlayers};


    {
        if (!isDamageAllowed _x) then {
            [_x] call FUNC(fullHealLocal);
            continue;
        };

        _position = if ((toString (_position) != toString (getPos _logic))) then {getPos _logic} else {_position};
        _logic setVariable [QGVAR(gas_position), _position, true];

        private _distance = _x distance _position;

        if (isPlayer _x) then {
            if (_x getVariable [QGVAR(isTreated), false]) then {
                _x setVariable [QGVAR(isTreated), false, true];

                _playerArr deleteAt (_playerArr find _x);
                _logic setVariable [QGVAR(gas_playerArr), _playerArr, true];
            };

            if (!(_x in _playerArr) && _distance < _radius_max) then {
                _playerArr pushBack _x;

                _logic setVariable [QGVAR(gas_playerArr), _playerArr, true];
                [QGVAR(gasPlayer), [_x, _logic, _position, _radius_max, _radius_min, _gasType], _x] call CBA_fnc_targetEvent;
            } else {
                if (_x in _playerArr && _distance > _radius_max) then {

                    _playerArr deleteAt (_playerArr find _x);
                    _logic setVariable [QGVAR(gas_playerArr), _playerArr, true];
                };
            };
        } else {
            if (_distance < _radius_max && alive _x && !(_x getVariable [QGVAR(enteredPoison), false])) then {
                [QGVAR(gasAI), [_x, _logic, _position, _radius_max, _gasType], _x] call CBA_fnc_targetEvent;
            };
        };
    } forEach _allUnits;
};

// Add per frame handler to check players
private _handle = [_checkPlayers, 3, [_logic, _position, _radius_max, _radius_min, _gasType]] call CBA_fnc_addPerFrameHandler;

// Remove handler when logic is no longer valid
[
    {
        params ["_args", "_pfhHandle"];
        _args params ["_logic", "_handle"];

        if (isNull _logic || !alive _logic || !(_logic getVariable [QGVAR(gas_active), false])) exitWith {
            _logic setVariable [QGVAR(gas_active), false, true];
            [_handle] call CBA_fnc_removePerFrameHandler;
            [_pfhHandle] call CBA_fnc_removePerFrameHandler;
        };
    },
    0,
    [_logic, _handle]
] call CBA_fnc_addPerFrameHandler;
