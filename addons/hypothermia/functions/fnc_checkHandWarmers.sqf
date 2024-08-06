#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks handwarmer status
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle] call kat_hypothermia_fnc_addArterialTestActions;
 *
 * Public: No
 */

params ["_target"];

private _warmers = _target getVariable [QEGVAR(hypothermia,handWarmers),[0,0,0,0,0,0]];
_warmers params ["_head", "_body", "_larm", "_rarm", "_lleg", "_rleg"];

if (_player == _target) exitWith {
    if (({_x == 0} count _warmers) == 6) exitWith {
        ["No Hand Warmers are active at this time", 1.5, _target] call ACEFUNC(common,displayTextStructured);
    };

    private _output = format [LSTRING(Self_Handwarmer_Output), 
        [(format ["Body: %1", (random[10, _body, 60]) toFixed 0]), "Body: None"] select (_body < 10),
        [(format ["Left Arm: %1", (random[10, _larm, 60]) toFixed 0]), "Left Arm: None"] select (_larm < 10),
        [(format ["Right Arm: %1", (random[10, _rarm, 60]) toFixed 0]), "Right Arm: None"] select (_rarm < 10),
        [(format ["Left Leg: %1", (random[10, _lleg, 60]) toFixed 0]), "Left Leg: None"] select (_lleg < 10),
        [(format ["Right Leg: %1", (random[10, _rleg, 60]) toFixed 0]), "Right Leg: None"] select (_rleg < 10)
    ];

    [_output, 5, _target] call ACEFUNC(common,displayTextStructured);
};

if (({_x == 0} count _warmers) == 6) exitWith {
        ["No Hand Warmers are active at this time", 1.5, _player] call ACEFUNC(common,displayTextStructured);
};

private _output = format [LSTRING(Other_Handwarmer_Output), 
    [(format ["Body: %1", (random[10, _body, 60]) toFixed 0]), "Body: None"] select (_body < 10),
    [(format ["Left Arm: %1", (random[10, _larm, 60]) toFixed 0]), "Left Arm: None"] select (_larm < 10),
    [(format ["Right Arm: %1", (random[10, _rarm, 60]) toFixed 0]), "Right Arm: None"] select (_rarm < 10),
    [(format ["Left Leg: %1", (random[10, _lleg, 60]) toFixed 0]), "Left Leg: None"] select (_lleg < 10),
    [(format ["Right Leg: %1", (random[10, _rleg, 60]) toFixed 0]), "Right Leg: None"] select (_rleg < 10)
];

[_output, 5, _player] call ACEFUNC(common,displayTextStructured);