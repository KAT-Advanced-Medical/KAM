#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_displaySCBADur;
 *
 * Public: No
*/

params ["_target"];

// If target has no SCBA backpack, do nothing.
if !(backpack _target in (missionNamespace getVariable [QGVAR(availBackpackList), []])) exitWith {};

// Get max oxygen time from mission settings, default to 3600 seconds (60 minutes).
private _maxOxygenTime = missionNamespace getVariable [QGVAR(SCBA_maxOxygenTime), 3600];

// Get the backpack object itself.
private _backpack = backpackContainer _target;

// Get remaining oxygen from the backpack item.
private _remaining = _backpack getVariable [QGVAR(SCBA_oxygen), _maxOxygenTime];

// Calculate the number of bars to display (out of 10).
private _bars = round ((_remaining / _maxOxygenTime) * 10);
if (_bars isEqualTo 0 && {_remaining > 0}) then {
    _bars = 1; // Show at least one bar if there's any oxygen left.
};
private _emptyBars = 10 - _bars;

// Determine the color of the bar based on remaining oxygen.
private _color = [((2 * (1 - _remaining / _maxOxygenTime)) min 1), ((2 * _remaining / _maxOxygenTime) min 1), 0];

// Build the colored string for the filled bars.
private _string = "";
for "_a" from 1 to _bars do {
    _string = _string + "|";
};
private _text = [_string, _color] call ACEFUNC(common,stringToColoredText);

// Build the grey string for the empty bars.
_string = "";
for "_a" from 1 to _emptyBars do {
    _string = _string + "|";
};
_text = composeText [_text, [_string, "#808080"] call ace_common_fnc_stringToColoredText];

// Get the picture of the backpack from its config.
private _picture = getText (configFile >> "CfgVehicles" >> (backpack _target) >> "picture");

// Display the text and picture to the player.
[_text, _picture] call ACEFUNC(common,displayTextPicture);
