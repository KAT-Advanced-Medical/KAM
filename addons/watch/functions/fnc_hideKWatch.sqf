#include "..\script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet
 * Modified: Mazinski
 * Removes the KWatch from the screen.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_watch_fnc_hideKWatch
 *
 * Public: No
 */
GVAR(KatminActive) = false;
"KAT_Katmin" cutText ["","PLAIN",0,true];