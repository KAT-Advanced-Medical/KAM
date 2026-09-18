#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Removes a gas source from the gas manager and tears down its logic, JIP event and
 * client particles.
 *
 * Everything needed is read from the stored entry rather than from the gas logic, so
 * this still works when the logic has already been deleted, e.g. together with the Zeus
 * module it was attached to. Safe to call for a key that is no longer registered.
 *
 * Server only.
 *
 * Arguments:
 * 0: Hashed key <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [hashValue _key] call kat_chemical_fnc_deleteGasSource;
 *
 * Public: No
 */

params ["_hashedKey"];

private _entry = GVAR(gasSources) deleteAt _hashedKey;
if (isNil "_entry") exitWith {};

_entry params ["_gasLogic", "", "", "", "", "", "_zoneId", "_effectsJipID"];

// Particles only exist if the JIP event was sent, so gate on that rather than on the current setting, which may have changed since the zone was created
if (_effectsJipID != "") then {
    [_effectsJipID] call CBA_fnc_removeGlobalEventJIP;
    [QGVAR(removeZoneParticles), [_zoneId]] call CBA_fnc_globalEvent;
};

detach _gasLogic;
deleteVehicle _gasLogic;
