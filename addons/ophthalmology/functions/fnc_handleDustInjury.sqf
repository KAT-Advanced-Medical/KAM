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
    case "dirt";
    case "rotorWash": {
        if (_random < GVAR(probability_dust_heavy)) exitWith {
            _unit setVariable [QGVAR(dust_injury_heavy), true, true];
        };
    };
    case "rain";
    default {};
};
