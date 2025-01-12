#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Converts patient to respawn tickets
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_ticketConversion
 *
 * Public: No
 */

params ["_patient"];

[(side _patient), GVAR(ticketConversionGain)] call BIS_fnc_respawnTickets;

_patient setDamage 1; 
deleteVehicle _patient;