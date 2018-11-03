/*
 * Author: Katalam
 * Checks if a patient has a pulsoxymeter connected
 *
 * Arguments:
 * 0: None
 * 1: target <OBJECT>
 *
 * Return Value:
 * True or false
 *
 * Example:
 * call kat_aceBreathing_fnc_canPulsoxymeter;
 *
 * Public: No
 */

params ["_target"];

if !(missionNamespace getVariable 'kat_aceBreathing_enable') exitWith {false};
if (_target getVariable ["kat_aceBreathing_pulsoxymeter", false]) exitWith {true};
false;
