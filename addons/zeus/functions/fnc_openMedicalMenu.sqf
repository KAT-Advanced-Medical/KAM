#include "..\script_component.hpp"
/*
 * Author: DiGi
 * Initalizes the "Open Unit medical menu" Zeus module.
 *
 * Arguments:
 * 0: GVAR(checkmedical_module) zeus module <LOGIC>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call kat_zeus_fnc_openMedicalMenu
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
        [_unit] call ACEFUNC(medical_gui,openMenu);
    };
};

deleteVehicle _logic;
