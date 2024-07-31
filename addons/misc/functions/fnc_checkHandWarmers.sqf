#include "..\script_component.hpp"
/*
 * Author: SzwedzikPL, mharis001
 * Modified: Mazinski
 * Add arterial blood gas test action to vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Ace actions <ARRAY>
 *
 * Example:
 * [vehicle] call kat_misc_fnc_addArterialTestActions;
 *
 * Public: No
 */

params ["_player", "_target"];

private _warmers = _target getVariable [QEGVAR(hypothermia,handWarmers),[0,0,0,0,0,0]];

if (_player == _target) exitWith {
    if (({_x == 0} count _warmers) >= 5) exitWith {
        ["No Hand Warmers are active at this time", 1.5, _target] call ACEFUNC(common,displayTextStructured);
    };

    private _output = format ["This is where you have handwarmers and how much longer you think they have in minutes: %1, %2, %3, %4, %5", 
        [[format ["Body: %1", (random[10, _warmers select 1, 60]) toFixed 0]], "Body: None"] select {(_warmers select 1) < 10},
        [[format ["Left Arm: %1", (random[10, _warmers select 2, 60]) toFixed 0]], "Left Arm: None"] select {(_warmers select 2) < 10},
        [[format ["Right Arm: %1", (random[10, _warmers select 3, 60]) toFixed 0]], "Right Arm: None"] select {(_warmers select 3) < 10},
        [[format ["Left Leg: %1", (random[10, _warmers select 4, 60]) toFixed 0]], "Left Leg: None"] select {(_warmers select 4) < 10},
        [[format ["Right Leg: %1", (random[10, _warmers select 5, 60]) toFixed 0]], "Right Leg: None"] select {(_warmers select 5) < 10}
    ];

    [_output, 5, _target] call ACEFUNC(common,displayTextStructured);
};

if (({_x == 0} count _warmers) >= 5) exitWith {
        ["No Hand Warmers are active at this time", 1.5, _player] call ACEFUNC(common,displayTextStructured);
};

private _output = format ["This patient has handwarmers and they will probably last this many more minutes at this locations: %1, %2, %3, %4, %5", 
    [[format ["Body: %1", (random[10, _warmers select 1, 60]) toFixed 0]], "Body: None"] select {(_warmers select 1) < 10},
    [[format ["Left Arm: %1", (random[10, _warmers select 2, 60]) toFixed 0]], "Left Arm: None"] select {(_warmers select 2) < 10},
    [[format ["Right Arm: %1", (random[10, _warmers select 3, 60]) toFixed 0]], "Right Arm: None"] select {(_warmers select 3) < 10},
    [[format ["Left Leg: %1", (random[10, _warmers select 4, 60]) toFixed 0]], "Left Leg: None"] select {(_warmers select 4) < 10},
    [[format ["Right Leg: %1", (random[10, _warmers select 5, 60]) toFixed 0]], "Right Leg: None"] select {(_warmers select 5) < 10}
];

[_output, 5, _player] call ACEFUNC(common,displayTextStructured);