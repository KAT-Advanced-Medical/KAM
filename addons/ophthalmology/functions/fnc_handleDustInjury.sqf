#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handles the possibility to have dust in the eye.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Cause <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "dust"] call kat_ophthalmology_fnc_handleDustInjury;
 *
 * Public: No
 */

params ["_unit", "_cause"];
systemchat format ["Cause: %1", _cause];
if !(GVAR(enable)) exitWith {};

// get a random integer
private _random = floor (random [0, 50, 100]);

switch (_cause) do {
    case "dust": {
        if (_random < GVAR(probability_dust)) exitWith {
            _unit setVariable [QGVAR(dust_injury), true, true];
        };
    };
    case "dirt": {
        // Get the current state of the eyes (defaulting to healthy if not set)
        private _eyeInjuries = _unit getVariable [QGVAR(eyeInjuries), [1, 1]];

        // Randomly choose which eye to injure (0 = left, 1 = right)
        private _injuredEye = floor random 2;

        // Set the chosen eye to injured
        _eyeInjuries set [_injuredEye, 0];

        _unit setVariable [QGVAR(eyeInjuries), _eyeInjuries, true];
    };
    case "rotorWash": {
        if (_random < GVAR(probability_dust)) exitWith {
            _unit setVariable [QGVAR(dust_injury), true, true];
        };
    };
    case "rain": {
        TRACE_1("No effect applied, cause: %1",_cause);
    };
    default {};
};
