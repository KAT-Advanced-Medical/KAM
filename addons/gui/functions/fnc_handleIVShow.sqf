#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Changes the visibility of the IV Menu
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call kat_medical_gui_fnc_handleIVShow;
 *
 * Public: No
 */

params ["_target"];

private _IVMenu = [true, false] select (_target getVariable [QEGVAR(pharma,IVmenuActive), false]);
_target setVariable [QEGVAR(pharma,IVmenuActive), _IVMenu, true];