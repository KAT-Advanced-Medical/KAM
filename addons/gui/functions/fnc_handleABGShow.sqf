#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Changes the visibility of the ABG Menu
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call kat_medical_gui_fnc_handleABGShow;
 *
 * Public: No
 */

params ["_target"];

private _ABGMenu = [true, false] select (_target getVariable [QEGVAR(pharma,ABGmenuShow), false]);
_target setVariable [QEGVAR(pharma,ABGmenuShow), _ABGMenu, true];