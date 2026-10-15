#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Removes the dosimeter HUD from the screen.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_chemical_fnc_hideDosimeter
 *
 * Public: No
 */

GVAR(DosimeterActive) = false;
"KAT_Dosimeter" cutText ["", "PLAIN", 0, true];
