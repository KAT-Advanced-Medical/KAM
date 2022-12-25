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

params ["_unit", "_timeEntered", "_logic", "_gastype", "_radius_max"];

if (goggles _unit in GVAR(availGasmasklist)) then {
    private _isinGas = true;
    [
        {
            params["_args", "_pfhHandler"];
            _args params["_unit", "_timeEntered", "_logic", "_gastype", "_radius_max", "_isinGas"];
            
            if !(_isinGas) exitwith {
                [_pfhHandler] call CBA_fnc_removePerFrameHandler;
            };
            
            private _timeleft = _unit getVariable[QGVAR(gasmask_durability), 10];
            _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
            if (_unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active), false]) || isNull _logic) exitwith {
                _unit setVariable[QGVAR(enteredPoisen), false, true];
                _isinGas = false;
            };
            
            if !(goggles _unit in GVAR(availGasmasklist) && _timeleft > 0) then {
                _unit setVariable [QGVAR(poisentype), _gastype, true];
                switch (_gastype) do {
                    case "Toxic": {
                        _unit setVariable [QGVAR(airPoisend), true, true];
                    };
                    case "CS": {
                        _unit setVariable [QGVAR(CS), true, true];
                        [_logic, _radius_max] spawn FUNC(handleCSGas);
                    };
                };
                [_unit] call EFUNC(breathing,handleBreathing);
                _isinGas = false;
            };
            
            if (_timeleft <= 0 && _unit getVariable [QGVAR(enteredPoisen), false]) then {
                _unit setVariable [QGVAR(poisentype), _gastype, true];
                switch (_gastype) do {
                    case "Toxic": {
                        _unit setVariable [QGVAR(airPoisend), true, true];
                    };
                    case "CS": {
                        _unit setVariable [QGVAR(CS), true, true];
                        [_logic, _radius_max] spawn FUNC(handleCSGas);
                    };
                };
                [_unit] call EFUNC(breathing,handleBreathing);
                _isinGas = false;
            };
            
            if (!(_unit getVariable [QGVAR(enteredPoisen), false]) || !(_logic getVariable [QGVAR(gas_active), false])) then {
                _isinGas = false;
                _unit setVariable [QGVAR(enteredPoisen), false];
            };
        },
        1,
        [_unit, _timeEntered, _logic, _gastype, _radius_max, _isinGas]
    ] call CBA_fnc_addPerFrameHandler;
} else {
    if (_unit getVariable [QGVAR(enteredPoisen), false]) then {
        _unit setVariable [QGVAR(poisentype), _gastype, true];
        switch (_gastype) do {
            case "Toxic": {
                _unit setVariable [QGVAR(airPoisend), true, true];
            };
            case "CS": {
                _unit setVariable [QGVAR(CS), true, true];
                [_logic, _radius_max] spawn FUNC(handleCSGas);
            };
        };
        [_unit] call EFUNC(breathing,handleBreathing);
    };
};