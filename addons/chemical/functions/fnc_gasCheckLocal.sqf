#include "..\script_component.hpp"
/*
* Author: DiGii
* This cant be called manualy!
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

[
    {
        params["_args", "_handler"];
        _args params ["_logic", "_unit", "_pos"];
        private _posstring = toString (_logic getVariable [QGVAR(gas_pos), [0, 0, 0]]);
        private _logicPos = toString (getPos _logic);
        if (_unit getVariable [QGVAR(isTreated), false]) exitWith {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };
        if !(_logic getVariable [QGVAR(gas_active), false]) then {
            if (_unit getVariable [QGVAR(enteredPoison), false]) then {
                _unit setVariable [QGVAR(enteredPoison), false, true];
                [_handler] call CBA_fnc_removePerFrameHandler;
            };
        };
    }, 3, [_logic, _unit, _pos]
] call CBA_fnc_addPerFrameHandler;

[
    {
        params["_args", "_handler"];
        _args params ["_unit", "_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];

        if(!(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic || _unit getVariable [QGVAR(isTreated), false]) exitWith {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };

        _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
        private _distance = _unit distance _pos;
        private _min_to_max = _radius_max - _radius_min;
        private _dis_to_min = _distance - _radius_min;
        private _percent = 0;
        if (_distance > _radius_min) then {
            _percent = 1-(_dis_to_min / _min_to_max);
            if (_percent > 1) then {
                _percent = 1
            };
        } else {
            _percent = 1;
        };
        _unit setVariable [QGVAR(gasPercentage), _percent];

    }, 1, [_unit, _logic, _pos, _radius_max, _radius_min, _gastype]
] call CBA_fnc_addPerFrameHandler;

[
    {
        params["_args", "_pfhandler"];
        _args params ["_unit", "_logic", "_pos", "_radius_max", "_radius_min", "_gastype"];

        if (!(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic || !(_unit in (_logic getVariable [QGVAR(gas_playerArr), []])) || !(_unit getVariable[QGVAR(enteredPoison), false])) then {
            [_pfhandler] call CBA_fnc_removePerFrameHandler;
        };

        _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
        if (_unit distance _pos <= _radius_max && !(_unit getVariable [QGVAR(enteredPoison), false]) && !(_unit getVariable ["ACE_isUnconscious", false])) then {
            _unit setVariable [QGVAR(enteredPoison), true, true];
            [QGVAR(enteredPoisonEvent), [_unit], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(Poisen_logic), _logic, true];
            private _timeEntered = CBA_missiontime;

            [
                {
                    params["_args", "_pfhandler"];
                    _args params[ "_radius_max", "_radius_min", "_unit", "_logic", "_gastype"];
                    _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
                    _unittime = _unit getVariable [QGVAR(timeleft), 60];
                    _percent = _unit getVariable [QGVAR(gasPercentage), 0];
                    _unittime = _unittime - _percent;
                    _unit setVariable [QGVAR(timeleft), _unittime];

                    if (_unittime <= 0) exitwith {
                        [QGVAR(afterWait), [_unit, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
                        _unit setVariable [QGVAR(timeleft), 0];
                        [_pfhandler] call CBA_fnc_removePerFrameHandler;
                    };

                    if (_unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active), false]) || isNull _logic) exitwith {
                        _unit setVariable[QGVAR(enteredPoison), false, true];
                        [_pfhandler] call CBA_fnc_removePerFrameHandler;
                    };

                    if (_gastype isEqualto "CS") exitwith {
                        [_pfhandler] call CBA_fnc_removePerFrameHandler;
                        [QGVAR(afterWait), [_unit, _logic, _gastype, _radius_max], _unit] call CBA_fnc_targetEvent;
                    };
                },
                1,
                [ _radius_max, _radius_min, _unit, _logic, _gastype]
            ] call CBA_fnc_addPerFrameHandler;

        };
    },
    2,
    [_unit, _logic, _pos, _radius_max, _radius_min, _gastype]
] call CBA_fnc_addPerFrameHandler;
