#include "script_component.hpp"
/*
* Author: DiGii
* This cant be called manualy!
* Handles the Gas effect for the player
*
* Arguments:
* 0: Target <OBJECT>
* 1: module <logic>
* 2: position <position>
* 3: max_radius <NUMBER>
* 4: min_radius <NUMBER>
* 5: Gastype <strinG>
*
* Return Value:
* NONE
*
* Example:
* [player, logic, getPos player, 50, 20, 1] call kat_chemical_fnc_gasChecklocal;
*
* Public: No
*/

params ["_unit", "_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];

[
    {
        params["_args", "_handler"];
        _args params ["_logic", "_unit", "_pos"];
        private _posstring = toString (_logic getVariable [QGVAR(gas_pos), [0, 0, 0]]);
        private _logicPos = toString (getPos _logic);
        if !(_logic getVariable [QGVAR(gas_active), false]) then {
            if (_unit getVariable [QGVAR(enteredPoisen), false]) then {
                _unit setVariable [QGVAR(enteredPoisen), false, true];
                [_handler] call CBA_fnc_removePerFrameHandler;
            };
        };
    }, 3, [_logic, _unit, _pos]
] call CBA_fnc_addPerFrameHandler;

[
    {
        params["_args", "_handler"];
        _args params ["_unit", "_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];
        
        if (!(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic || !(_unit in (_logic getVariable [QGVAR(gas_playerArr), []]))) then {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };
        
        _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
        if (_unit distance _pos <= _radius_max && !(_unit getVariable[QGVAR(enteredPoisen), false]) && !(_unit getVariable ["ACE_isUnconscious", false])) then {
            _unit setVariable [QGVAR(enteredPoisen), true, true];
            _unit setVariable [QGVAR(Poisen_logic), _logic, true];
            private _timeEntered = CBA_missiontime;            
            private _prozent = 1;

            [
                {
                    params["_args", "_pfhandler"];
                    _args params["_prozent", "_radius_max", "_radius_min", "_unit", "_timeEntered", "_logic", "_gastype"];
                    _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
                    private _distance = _unit distance _pos;
                    private _min_to_max = _radius_max - _radius_min;
                    private _dis_to_min = _distance - _radius_min;
                    if (_distance > _radius_min) then {
                        _prozent = 1-(_dis_to_min / _min_to_max);
                        if (_prozent > 1) then {
                            _prozent = 1
                        };
                    } else {
                        _prozent = 1;
                    };
                    _unittime = _unit getVariable [QGVAR(timeleft), 60];
                    _unittime = _unittime - _prozent;
                    _unit setVariable [QGVAR(timeleft), _unittime];
                    _unit setVariable [QGVAR(gasPercentage), _prozent];
                    if (_unittime <= 0) exitwith {
                        [QGVAR(afterWait), [_unit, _timeEntered, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
                        _unit setVariable [QGVAR(timeleft), 0];
                        [_pfhandler] call CBA_fnc_removePerFrameHandler;
                    };
                    
                    if (_unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active), false]) || isNull _logic) exitwith {
                        _unit setVariable[QGVAR(enteredPoisen), false, true];
                        [_pfhandler] call CBA_fnc_removePerFrameHandler;
                    };
                    
                    if (_gastype isEqualto "CS") exitwith {
                        [_pfhandler] call CBA_fnc_removePerFrameHandler;
                        [QGVAR(afterWait), [_unit, _timeEntered, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
                    };
                },
                1,
                [_prozent, _radius_max, _radius_min, _unit, _timeEntered, _logic, _gastype]
            ] call CBA_fnc_addPerFrameHandler;
        };
    },
    2,
    [_unit, _logic, _pos, _radius_max, _radius_min, _gastype]
] call CBA_fnc_addPerFrameHandler;