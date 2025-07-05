#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * outputs current unit state to that units RPT for debug tracing
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
 * Public: Yes
 */
params ["_logic"];
if !(local _logic) exitWith {};

private _mouseOver = GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""]);

if ((_mouseOver select 0) != "OBJECT") then {
    [ACELSTRING(zeus,NothingSelected)] call FUNC(showMessage);
} else {
    private _unit = effectiveCommander (_mouseOver select 1);
    if !(_unit isKindOf "CAManBase") then {
        [ACELSTRING(zeus,OnlyInfantry)] call FUNC(showMessage);
    } else {
        private _json = _unit call EFUNC(misc,serializeState);
        missionNameSpace setVariable [QGVAR(serializedState), _json, true];
        deleteVehicle _logic;
    };
};
deleteVehicle _logic;
