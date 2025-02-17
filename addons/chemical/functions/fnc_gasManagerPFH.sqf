#include "..\script_component.hpp"
/*
 * Author: tcvm, johnb43
 * Modified by: MiszczuZPolski
 * Handles various objects on gas and determines if units close to objects deserve to get poisoned
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * kat_chemical_fnc_gasManagerPFH call CBA_fnc_addPerFrameHandler
 *
 * Public: No
 */

{
    _y params ["_gasLogic", "_radius", "_gasLevel", "_condition", "_conditionArgs", "_isSealable"];
    TRACE_2("gasManagerPFH loop",_x,_y);

    private _infectedObject = _y;

    // Remove when condition is no longer valid
    if !(_conditionArgs call _condition) then {
        TRACE_2("condition no longer valid, deleting",_x,_y);

        detach _gasLogic;
        deleteVehicle _gasLogic;

        GVAR(gasSources) deleteAt _x;

        continue;
    };

    // Poison units (alive or dead) close to the gas source
    {
        // Get the distance of the unit from the center of the sphere (_gasLogic)
        private _distance = _x distance _gasLogic;

        // Ensure the distance does not exceed the radius (prevents going beyond the sphere)
        _distance = _distance min _radius;

        // Calculate the intensity as a normalized value (1 at center, 0 at the edge)
        private _intensity = 1 - (_distance / _radius);

        _x setVariable [QGVAR(areaIntensity), _intensity, true];

        [QGVAR(poison), [_x, _gasLevel, _infectedObject], _x] call CBA_fnc_targetEvent;

    } forEach nearestObjects [_gasLogic, ["CAManBase"], _radius];
} forEach GVAR(gasSources);
