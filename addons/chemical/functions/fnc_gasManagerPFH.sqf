#include "..\script_component.hpp"
/*
 * Author: tcvm, johnb43
 * Handles various objects on fire and determines if units close to objects deserve to get burned.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * ace_fire_fnc_fireManagerPFH call CBA_fnc_addPerFrameHandler
 *
 * Public: No
 */

{
    _y params ["_gasLogic", "_radius", "_gasLevel", "_condition", "_conditionArgs"];
    TRACE_2("fireManagerPFH loop",_x,_y);

    // Remove when condition is no longer valid
    if !(_conditionArgs call _condition) then {
        TRACE_2("condition no longer valid, deleting",_x,_y);

        detach _gasLogic;
        deleteVehicle _gasLogic;

        GVAR(gasSources) deleteAt _x;

        continue;
    };

    // Burn units (alive or dead) close to the fire
    {
        // Don't burn if intensity is too low or already burning with higher intensity
        if (_x getVariable [QGVAR(poisoned), false]) then {
            continue;
        };

        diag_log "Poison Gas!";
        [QGVAR(poison), [_x, _gasLevel], _x] call CBA_fnc_targetEvent;

    } forEach nearestObjects [_gasLogic, ["CAManBase"], _radius];
} forEach GVAR(gasSources);
