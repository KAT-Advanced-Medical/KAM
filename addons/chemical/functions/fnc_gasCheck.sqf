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
 * [logic, getpos player, 50, 20, 1] call kat_chemical_fnc_gasCheck;
 *
 * Public: No
 */

params ["_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];

// Set default values if needed
_gastype = [_gastype, "Toxic"] select (_gastype isEqualTo "");
_radius_min = if (_radius_min isEqualTo 0) then {_radius_max / 2} else {_radius_min};

_logic setVariable [QGVAR(gas_active), true, true];
_logic setVariable [QGVAR(gas_playerArr), [], true];
_logic setVariable [QGVAR(gas_pos), _pos, true];

// Function to check players within the gas zone
private _checkPlayers = {
    params ["_args"];
    _args params ["_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];
    private _playerArr = _logic getVariable [QGVAR(gas_playerArr), []];
    private _allUnits = if (missionNamespace getVariable [QGVAR(affectAI), false]) then {allUnits} else {allPlayers};

    {
        if (!isDamageAllowed _x) then {
            [_x] call FUNC(clearChemicalInjuriesLocal);
            continue;
        };

        _pos = if ((toString (_pos) != toString (getpos _logic))) then {getpos _logic} else {_pos};
        _logic setVariable [QGVAR(gas_pos), _pos, true];

        private _distance = _x distance _pos;

        if (isPlayer _x) then {
            if (_x getVariable [QGVAR(isTreated), false]) then {
                _x setVariable [QGVAR(isTreated), false, true];

                _playerArr deleteAt (_playerArr find _x);
                _logic setVariable [QGVAR(gas_playerArr), _playerArr, true];
            };

            if (!(_x in _playerArr) && _distance < _radius_max) then {
                _playerArr pushBack _x;

                _logic setVariable [QGVAR(gas_playerArr), _playerArr, true];
                [QGVAR(gasCheck_local), [_x, _logic, _pos, _radius_max, _radius_min, _gastype], _x] call CBA_fnc_targetEvent;
            } else {
                if (_x in _playerArr && _distance > _radius_max) then {

                    _playerArr deleteAt (_playerArr find _x);
                    _logic setVariable [QGVAR(gas_playerArr), _playerArr, true];
                };
            };
        } else {
            if (_distance < _radius_max && alive _x && !(_x getVariable [QGVAR(enteredPoison), false])) then {
                [QGVAR(gasCheck_ai), [_x, _logic, _pos, _radius_max, _gastype], _x] call CBA_fnc_targetEvent;
            };
        };
    } forEach _allUnits;
};

// Add per frame handler to check players
[_checkPlayers, 3, [_logic, _pos, _radius_max, _radius_min, _gastype]] call CBA_fnc_addPerFrameHandler;

// Remove handler when logic is no longer valid
[
    {
        params ["_args", "_pfhHandle"];
        _args params ["_logic", "_checkPlayers"];
        
        if (isNull _logic || !alive _logic || !(_logic getVariable [QGVAR(gas_active), false])) exitWith {
            _logic setVariable [QGVAR(gas_active), false, true];
            [_checkPlayers] call CBA_fnc_removePerFrameHandler;
            [_pfhHandle] call CBA_fnc_removePerFrameHandler;
        };
    },
    0,
    [_logic, _checkPlayers]
] call CBA_fnc_addPerFrameHandler;
