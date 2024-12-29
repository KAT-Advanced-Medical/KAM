#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
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

        private _dustInjurySeverity = _unit getVariable [QGVAR(dustInjurySeverity), 0];
        _unit setVariable [QGVAR(dustInjurySeverity), ((_dustInjurySeverity + (random 1)) min 5), true];
    };
};
