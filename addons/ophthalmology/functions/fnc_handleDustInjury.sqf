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

private _random = floor (random 100);

if (_cause in ["dust", "rotorWash"]) then {
    if (_random < GVAR(probability_dust)) exitWith {
        [0.1, false] call EFUNC(feedback,effectEyeBlink);
        _unit setVariable [QGVAR(dust_injury), true, true];
    };
};