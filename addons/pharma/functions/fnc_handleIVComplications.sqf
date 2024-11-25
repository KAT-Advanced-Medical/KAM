#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles advanced IV complications
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: flowDifference (difference in fluid between the cap and the actual)<Number>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1] call kat_pharma_fnc_handleIVComplications
 *
 * Public: No
 */
 params ["_unit", "_flowDifference"];
 if (_flowDifference > 1) then (hint str "oops, you blew a vein");