#include "..\script_component.hpp"
/*
* Author: DiGii
* This cant be called manualy!
* Handles the Gas effect for the player
*
* Arguments:
* 0: Unit <OBJECT>
* 1: Module <LOGIC>
* 2: Gastype <STRING>
* 3: Max_radius <NUMBER>
*
* Return Value:
* NONE
*
* Example:
* [player, logic, "Toxic", 50] call kat_chemical_fnc_afterWait;
*
* Public: No
*/

params ["_unit", "_logic", "_gastype", "_radius_max"];

if (!isDamageAllowed _unit) exitWith {
    [_unit] call FUNC(clearChemicalInjuriesLocal);
};

if ((goggles _unit) in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {
    private _isinGas = true;
    [
        {
            params["_args", "_pfhHandler"];
            _args params["_unit", "_logic", "_gastype", "_radius_max", "_isinGas"];

            if !(_isinGas) exitwith {
                [_pfhHandler] call CBA_fnc_removePerFrameHandler;
            };

            private _timeleft = _unit getVariable[QGVAR(gasmask_durability), 10];
            _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
            if (_unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active), false]) || isNull _logic) exitwith {
                _unit setVariable[QGVAR(enteredPoison), false, true];
                _isinGas = false;
            };

            if !((goggles _unit) in (missionNamespace getVariable [QGVAR(availGasmaskList), []]) && _timeleft > 0) then {
                _unit setVariable [QGVAR(poisonType), _gastype, true];
                switch (_gastype) do {
                    case "Toxic": {
                        _unit setVariable [QGVAR(airPoisoning), true, true];
                    };
                    case "CS": {
                        _unit setVariable [QGVAR(CS), true, true];
                        [_unit, _logic, _radius_max] call FUNC(handleCSGas);
                    };
                };
                [_unit] call EFUNC(breathing,handleBreathing);
                _isinGas = false;
            };

            if (_timeleft <= 0 && _unit getVariable [QGVAR(enteredPoison), false]) then {
                _unit setVariable [QGVAR(poisonType), _gastype, true];
                switch (_gastype) do {
                    case "Toxic": {
                        _unit setVariable [QGVAR(airPoisoning), true, true];
                    };
                    case "CS": {
                        _unit setVariable [QGVAR(CS), true, true];
                        [_unit, _logic, _radius_max] call FUNC(handleCSGas);
                    };
                };
                [_unit] call EFUNC(breathing,handleBreathing);
                _isinGas = false;
            };

            if (!(_unit getVariable [QGVAR(enteredPoison), false]) || !(_logic getVariable [QGVAR(gas_active), false])) then {
                _isinGas = false;
                _unit setVariable [QGVAR(enteredPoison), false];
            };
        },
        1,
        [_unit, _logic, _gastype, _radius_max, _isinGas]
    ] call CBA_fnc_addPerFrameHandler;
} else {
    if (_unit getVariable [QGVAR(enteredPoison), false]) then {
        _unit setVariable [QGVAR(poisonType), _gastype, true];
        switch (_gastype) do {
            case "Toxic": {
                _unit setVariable [QGVAR(airPoisoning), true, true];
            };
            case "CS": {
                _unit setVariable [QGVAR(CS), true, true];
                [_unit, _logic, _radius_max] call FUNC(handleCSGas);
            };
        };
        [_unit] call EFUNC(breathing,handleBreathing);
    };
};
