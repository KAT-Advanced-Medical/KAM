#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Returns the ACE actions for spawning several patients at once, one for every amount from 1
 * up to the number of free patient spots around the training computer.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 * 1: Severity, 0 (healthy) to 4 (critical) <NUMBER>
 *
 * Return Value:
 * ACE actions <ARRAY>
 *
 * Example:
 * [cursorObject, 3] call kat_training_fnc_getAmountActions
 *
 * Public: No
 */

// The menu asks for these actions continuously while it is open
#define FREE_SPOTS_CACHE_TIME 1

params [["_computer", objNull, [objNull]], ["_severity", 0, [0]]];

private _freeSpots = [[_computer, true], FUNC(getSpots), _computer, QGVAR(freeSpotsCache), FREE_SPOTS_CACHE_TIME] call ACEFUNC(common,cachedCall);
private _actions = [];

for "_amount" from 1 to (count _freeSpots) do {
    _actions pushBack [
        [
            format [QGVAR(spawnAmount_%1_%2), _severity, _amount],
            format [LLSTRING(Amount), _amount],
            "",
            {
                params ["_computer", "_player", "_args"];
                _args params ["_severity", "_amount"];

                [_computer, _player, _severity, _amount] call FUNC(spawnPatient);
            },
            {true},
            {},
            [_severity, _amount]
        ] call ACEFUNC(interact_menu,createAction),
        [],
        _computer
    ];
};

_actions
