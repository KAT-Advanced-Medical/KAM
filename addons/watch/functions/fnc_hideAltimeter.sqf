#include "..\script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet
 * Removes the altimeter from the screen.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ACE_Parachute_fnc_hideAltimeter
 *
 * Public: No
 */
GVAR(GarminActive) = false;
"KAT_Garmin" cutText ["","PLAIN",0,true];
