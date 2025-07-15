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

params ["_medic", "_patient"];

[(side group _patient), GVAR(ticketConversionGain)] call BIS_fnc_respawnTickets;

if (GVAR(enableSpectatorRespawn)) then {
    if (lifeState (_patient getVariable [QGVAR(associatedPlayer), objNull]) isEqualTo "DEAD-RESPAWN") then {
        [QGVAR(respawnTimer), [0, _patient], _patient] call CBA_fnc_targetEvent;
    };
};

_patient setDamage 1; 
deleteVehicle _patient;