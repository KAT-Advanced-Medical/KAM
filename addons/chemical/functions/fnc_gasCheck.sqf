#include "..\script_component.hpp"
/*
 * Author: DiGii
 * This cant be called manualy!
 *
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

params ["_logic","_pos","_radius_max","_radius_min","_gastype"];

if (_gastype isEqualTo "") then {_gastype = "Toxic"};
if (_radius_min isEqualTo 0) then {_radius_min = _radius_max / 2};
_logic setVariable [QGVAR(gas_active), true, true];
_logic setVariable [QGVAR(gas_playerArr), [], true];
_logic setVariable [QGVAR(gas_pos), _pos, true];


private _checkplayers = [{
    params ["_args"];
    _args params ["_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];
    private _playerARR = _logic getVariable [QGVAR(gas_playerArr), []];
    private _allUnits = if (missionNamespace getVariable [QGVAR(affectAI), false]) then {allUnits} else {allPlayers};
    {
        if (!isDamageAllowed _x) then {
            [_x] call FUNC(clearChemicalInjuriesLocal);
            continue;
        };

        private _posString = toString (_pos);
        private _logicPos = toString (getpos _logic);
        if (_posString != _logicPos) then { _pos = getpos _logic; _logic setVariable [QGVAR(gas_pos), _pos, true];};
        private _distance = position _x distance _pos;
        if (isPlayer _x) then {

            if (_x getVariable [QGVAR(isTreated), false]) then {
                _x setVariable [QGVAR(isTreated), false, true];
                private _arrPos = _playerARR find _x;
                _playerARR deleteAt _arrPos;
                _logic setVariable [QGVAR(gas_playerArr), _playerARR, true];
            };

            if (_x in _playerARR && _distance > _radius_max) then {
                private _arrPos = _playerARR find _x;
                _playerARR deleteAt _arrPos;
                _logic setVariable [QGVAR(gas_playerArr), _playerARR, true];
            };

            if (!(_x in _playerARR) && _distance < _radius_max) then {
                _playerARR pushBack _x;
                _logic setVariable [QGVAR(gas_playerArr), _playerARR, true];
                [QGVAR(gasCheck_local), [_x, _logic, _pos, _radius_max, _radius_min, _gastype], _x] call CBA_fnc_targetEvent;
            };

        } else {
            if (_distance < _radius_max && alive _x && !(_x getVariable [QGVAR(enteredPoison), false])) then {
                [QGVAR(gasCheck_ai), [_x, _logic, _pos, _radius_max, _gastype], _x] call CBA_fnc_targetEvent;
            };
        };
    } forEach _allUnits;

}, 3, [_logic,_pos,_radius_max,_radius_min,_gastype]] call CBA_fnc_addPerFrameHandler;



[{
    params["_args","_pfhHandle"];
    _args params["_logic","_checkplayers"];
    if (isNull _logic || !alive _logic || !(_logic getVariable [QGVAR(gas_active),false])) exitWith {
        _logic setVariable [QGVAR(gas_active), false, true];
        [_checkplayers] call CBA_fnc_removePerFrameHandler;
        [_pfhHandle] call CBA_fnc_removePerFrameHandler;
    };
}, 0, [_logic,_checkplayers]]call CBA_fnc_addPerFrameHandler;
