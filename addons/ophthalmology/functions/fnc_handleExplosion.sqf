#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles explosions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Damage Source <OBJECT>
 * 2: Explosion Source <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, damage, explosion] call kat_ophthalmology_fnc_handleExplosion
 *
 * Public: No
 */

params ["_unit", "_damage", "_explosionSource"];

if (_unit != ACE_player) exitWith {};

private _eyePos = eyePos _unit;
private _grenadePosASL = getPosASL _explosionSource;
_grenadePosASL set [2, (_grenadePosASL select 2) + 0.2]; // compensate for grenade glitching into ground

// Calculate distance-based strength
private _distance = _eyePos vectorDistance _grenadePosASL;
private _strength = 1 - (_distance min 30) / 30;

private _losCount = {
    !lineIntersects [_grenadePosASL vectorAdd _x, _eyePos, _unit]
} count [[0, 0, 0], [0, 0, 0.2], [0.1, 0.1, 0.1], [-0.1, -0.1, 0.1]];

// Adjust strength based on line of sight
private _losCoefficient = [1, 0.1] select (_losCount <= 1);
_strength = _strength * _losCoefficient;

// Account for player's viewing direction
private _eyeDir = ((AGLToASL positionCameraToWorld [0, 0, 1]) vectorDiff (AGLToASL positionCameraToWorld [0, 0, 0]));
private _dirToGrenade = _eyePos vectorFromTo _grenadePosASL;
private _angleDiff = acos (_eyeDir vectorDotProduct _dirToGrenade); // Angle difference in radians

if (_angleDiff > 50) exitWith {};

// Add visual and hearing effects
if (_strength > 0.2) then {

    // Eye closure from shock
    [(_strength * 2), true] call EFUNC(feedback,effectEyeBlink);
    private _random = floor (random 101);

    if (_random < GVAR(probability_dust_heavy)) then {

        // Get the current state of the eyes (defaulting to healthy if not set)
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

    // Reaction blink
    [{
        [0.1, true] call EFUNC(feedback,effectEyeBlink);
        [{ [0.05, true] call EFUNC(feedback,effectEyeBlink);  }, [], 0.3] call CBA_fnc_waitAndExecute;
    }, [], (_strength * 2.2)] call CBA_fnc_waitAndExecute;
};
