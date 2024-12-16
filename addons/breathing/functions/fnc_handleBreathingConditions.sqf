#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Monitors breathing conditions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_handleBreathingConcidtions;
 *
 * Public: No
 */

params ["_unit"];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _alive = alive _unit;

    if (!_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _spo2 = GET_KAT_SPO2(_unit);

    if (GVAR(staminaLossAtLowSPO2)) then {
        if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_spo2 <= GVAR(lowSPO2Level)}) then {
            if (ACEGVAR(advanced_fatigue,enabled)) then {
                ["kat_LSDF", 1.5] call ACEFUNC(advanced_fatigue,addDutyFactor);
            } else {
                _unit setStamina(getStamina _unit - 3);
            };
        } else {
            ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
        };
    };
}, 10, [_unit]] call CBA_fnc_addPerFrameHandler;
