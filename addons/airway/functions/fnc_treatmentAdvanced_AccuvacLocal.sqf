#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding local
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Accuvac"] call kat_airway_fnc_treatmentAdvanced_accuvacLocal;
 *
 * Public: No
 */

params ["_patient"];

if (_patient getVariable [QGVAR(occluded), false]) then {
    _patient setVariable [QGVAR(occluded), false, true];

    if (GVAR(occlusion_cooldownPeriod) > 0) then {
        _patient setVariable [QGVAR(clearedTime), CBA_missionTime, true];
    };
};
