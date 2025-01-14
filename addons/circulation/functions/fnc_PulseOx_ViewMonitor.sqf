#include "..\script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Mazinski
 * Open PulseOx View Monitor
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 1] call kat_circulation_fnc_PulseOx_ViewMonitor.sqf;
 *
 * Public: No
 */

params ["_medic", "_target"];

private _dlg = uiNamespace getVariable ["kat_pulseox", displayNull];

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg", "_target"];

    if !(GVAR(PulseOxDisplay)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    (_dlg displayCtrl 22802) ctrlSetText (format["%1", (GET_KAT_SPO2(_target)) toFixed 1]);
    (_dlg displayCtrl 22803) ctrlSetText (format["%1", round(GET_HEART_RATE(_target))]);
}, 1, [_dlg, _target]] call CBA_fnc_addPerFrameHandler;