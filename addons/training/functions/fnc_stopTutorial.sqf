#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Stops the guided training of the player and hides the heart rhythm chart. The patient is left as they are.
 *
 * Arguments:
 * 0: Clear the current hint <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_training_fnc_stopTutorial
 *
 * Public: No
 */

params [["_clearHint", true, [true]]];

if (GVAR(tutorialHandle) == -1) exitWith {};

[GVAR(tutorialHandle)] call CBA_fnc_removePerFrameHandler;
GVAR(tutorialHandle) = -1;

QGVAR(rhythmChart) cutText ["", "PLAIN", 0];

if (_clearHint) then {
    hintSilent "";
};
