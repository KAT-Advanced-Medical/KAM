/*
 * Author: Katalam
 * Checks if a patient has a pulseoximeter connected
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Has pulseoximeter <BOOLEAN>
 *
 * Example:
 * [cursorTarget] call kat_aceBreathing_fnc_canPulseoximeter;
 *
 * Public: No
 */

params ["_target"];

if (_target getVariable ["kat_aceBreathing_pulseoximeter", false]) exitWith {true};
false;
