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

if (GVAR(enableSpectatorRespawn)) then {
    if (lifeState (_patient getVariable [QGVAR(associatedPlayer), objNull]) isEqualTo "DEAD-RESPAWN") then {
        [QGVAR(respawnTimer), 0] call CBA_fnc_localEvent;
    };
};

_patient setDamage 1; 
deleteVehicle _patient;