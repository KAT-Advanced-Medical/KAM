#include "..\script_component.hpp"
/*
 * Author: DiGii
 * This cant be called manualy!
 * Handles the Gas effect for the AI
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Module <Logic>
 * 2: Position <Position>
 * 3: Radius <NUMBER>
 * 4: GasType <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, logic, getPos player, 50, "Toxic"] call kat_chemical_fnc_gasAI;
 *
 * Public: No
*/

params ["_unit", "_logic", "_pos", "_radius_max", "_gastype"];

if (!isDamageAllowed _unit) exitWith {
    [_unit] call FUNC(clearChemicalInjuriesLocal);
};

[
    {
        params["_args","_handler"];
        _args params ["_logic","_unit"];
        if(!(_logic getVariable [QGVAR(gas_active),false]) || !(alive _unit) || isNull _unit) then {
            _unit setVariable [QGVAR(enteredPoison), false, true];
            [_handler] call CBA_fnc_removePerFrameHandler;
        };
    },
    3,
    [_logic,_unit]
] call CBA_fnc_addPerFrameHandler;

[
    {
        params["_args","_handler"];
        _args params ["_unit", "_logic", "_pos", "_radius_max", "_gastype"];

        if(!(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic || !(alive _unit) || _unit getVariable ["ACE_isUnconscious", false]) exitWith {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };

        if ((_unit distance _pos) <= _radius_max && !(_unit getVariable [QGVAR(enteredPoison), false])) then {
            _unit setVariable [QGVAR(enteredPoison), true, true];
            private _skill = _unit skill "aimingAccuracy";
            private _fnc_afterwait = {
                params ["_unit", "_gastype", "_pos", "_skill"];
                if !((goggles _unit) in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) exitwith {
                    if (_gastype isEqualTo "CS") then {
                        if {_unit distance _pos < 10 && _unit getVariable [QGVAR(enteredPoison), false]} do {
                            _unit say3D QGVAR(cough_1);
                            _unit setskill ["aimingAccuracy", 0.001];
                            [
                                {
                                    params["_unit", "_skill"];
                                    _unit setskill ["aimingAccuracy", _skill];
                                },
                                [_unit, _skill],
                                30
                            ] call CBA_fnc_waitAndExecute;
                        };
                    } else {
                        if (ACEGVAR(medical_statemachine,AIUnconsciousness)) then {
                            for "_i" from 0 to 10 step 1 do {
                                [
                                    {
                                        params["_unit"];
                                        [_unit, "PoisenBP", 300, 30, -10, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);
                                    },
                                    [_unit],
                                    5
                                ] call CBA_fnc_waitAndExecute;
                            };
                        } else {
                            [{
                                private _unit = _this select 0;
                                _unit setDamage 1;
                            }, [_unit], 20]call CBA_fnc_waitAndExecute;
                        };
                    };
                };
            };
            private _timeleft = 30;
            for "_i" from 0 to 1 step 0 do {
                _timeleft = _timeleft - 1;
                if (_timeleft <= 0) exitwith {
                    [_unit, _gastype, _pos, _skill] call _fnc_afterwait;
                    _i = 2;
                };
                if (_gastype isEqualto "CS") exitwith {
                    [_unit, _gastype, _pos, _skill] call _fnc_afterwait;
                    _i = 2;
                };
                _pos = _logic getVariable [QGVAR(gas_pos), [0, 0, 0]];
                if (_unit distance _pos > _radius_max || !(_logic getVariable [QGVAR(gas_active), false]) || isNull _logic) exitwith {
                    _unit setVariable [QGVAR(enteredPoison), false, true];
                    _i = 2;
                };
            };
        };
    },
    5,
    [_unit,_logic,_pos,_radius_max,_gastype]
] call CBA_fnc_addPerFrameHandler;
