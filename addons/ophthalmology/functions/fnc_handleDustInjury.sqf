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

        private _dustInjuryLight = _unit getVariable [QGVAR(dustInjuryLight), 0];

        if (_random < GVAR(probability_dust_heavy)) then {
            private _dustInjuryHeavy = _unit getVariable [QGVAR(dustInjuryHeavy), 0];

            _unit setVariable [QGVAR(dustInjuryHeavy), ((_dustInjuryHeavy + (random 1)) min 5), true];
        } else {
            _unit setVariable [QGVAR(dustInjuryLight), ((_dustInjuryLight + (random 1)) min 5), true];
        };

        if (GET_DUST_INJURY(_unit) > 5) then {
            private _eyeInjuries = _unit getVariable [QGVAR(eyeInjuries), [1, 1]];

            // Randomly choose which eye to injure (0 = right, 1 = left)
            private _injuredEye = floor random 2;

            // Set the chosen eye to injured
            _eyeInjuries set [_injuredEye, 0];

            if (({_x == 0} count _eyeInjuries) > 1) then {
                _unit setVariable [QGVAR(eyeInjurySevere), true, true];
            };

            _unit setVariable [QGVAR(eyeInjuries), _eyeInjuries, true];
        };
    };
};
