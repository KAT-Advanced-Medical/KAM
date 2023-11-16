#include "..\script_component.hpp"
/*
 * Author: Blue
 * Toggle whether AI unit can die instantly from fatal injury
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call kat_zeus_fnc_toggleAIDeathModule;
 *
 * Public: No
 */

params ["_logic"];

if !(local _logic) exitWith {};

private _mouseOver = GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""]);

if ((_mouseOver select 0) != "OBJECT") then {
    [ACELSTRING(zeus,NothingSelected)] call FUNC(showMessage);
} else {
    private _unit = effectivecommander (_mouseOver select 1);
    if !(_unit isKindOf "CAManBase") then {
        [ACELSTRING(zeus,OnlyInfantry)] call FUNC(showMessage);
    } else {
        if !(alive _unit) then {
            [ACELSTRING(zeus,OnlyAlive)] call FUNC(showMessage);
        } else {
            if !(isPlayer _unit) then {
                private _enabled = _unit getVariable [QEGVAR(misc,PreventInstantAIDeath), false];

                if (_enabled) then {
                    [LSTRING(toggleAIDeath_Module_Toggled), ACELSTRING(Common,Enabled)] call FUNC(showMessage);
                } else {
                    [LSTRING(toggleAIDeath_Module_Toggled), ACELSTRING(Common,Disabled)] call FUNC(showMessage);
                };

                _unit setVariable [QEGVAR(misc,PreventInstantAIDeath), !_enabled, true];
            } else {
                [LSTRING(OnlyAI)] call FUNC(showMessage);
            };
        };
    };
};

deleteVehicle _logic;
