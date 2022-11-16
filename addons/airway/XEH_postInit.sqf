#include "script_component.hpp"

if !(GVAR(enable)) exitWith {};

[QGVAR(larynxLocal), LINKFUNC(treatmentAdvanced_larynxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(airwayLocal), LINKFUNC(treatmentAdvanced_airwayLocal)] call CBA_fnc_addEventHandler;
[QGVAR(guedelLocal), LINKFUNC(treatmentAdvanced_guedelLocal)] call CBA_fnc_addEventHandler;
[QGVAR(accuvacLocal), LINKFUNC(treatmentAdvanced_accuvacLocal)] call CBA_fnc_addEventHandler;
[QGVAR(recoveryPositionLocal), LINKFUNC(treatmentAdvanced_RecoveryPositionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(cancelRecoveryPositionLocal), LINKFUNC(treatmentAdvanced_CancelRecoveryPositionLocal)] call CBA_fnc_addEventHandler;

["ace_unconscious", {
    params ["_unit", "_state"];
    if !(_state) exitWith {
        _unit call FUNC(init);
    };

    private _alive = alive _unit;
    if ((!_alive) || (_unit getVariable [GVAR(string_exit), ""] isEqualTo "keko_wasPunched") || KAT_forceWakeup) exitWith {};
    if (EGVAR(breathing,enable)) then {
        [QEGVAR(breathing,handleBreathing), [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
    };
    [_unit] call FUNC(handleAirway);
    [_unit] call FUNC(handlePuking);
}] call CBA_fnc_addEventHandler;

["ace_treatmentSucceded",{
    params ["", "_target", "", "_className"];
    if (toUpper _className isEqualTo "PERSONALAIDKIT" && local _target) exitWith {
        _target call FUNC(init);
        _target setVariable [QEGVAR(circulation,IV_counts), 0, true];
    };
 }] call CBA_fnc_addEventHandler;
