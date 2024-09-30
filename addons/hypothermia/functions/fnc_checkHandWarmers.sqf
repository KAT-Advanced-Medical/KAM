#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks handwarmer status
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [patient] call kat_hypothermia_fnc_checkHandWarmers;
 *
 * Public: No
 */

params ["_target"];

private _warmers = _target getVariable [QGVAR(handWarmers), [0,0,0,0,0,0]];
_warmers params ["_head", "_body", "_larm", "_rarm", "_lleg", "_rleg"];

if (_player == _target) exitWith {
    if (({_x == 0} count _warmers) == 6) exitWith {
        [LLSTRING(HandWarmer_None), 1.5, _target] call ACEFUNC(common,displayTextStructured);
    };

    private _output = format [LLSTRING(Self_Handwarmer_Output), 
        [(format [LLSTRING(HandWarmer_Body), (random [10, _body, 60]) toFixed 0]), LLSTRING(HandWarmer_Body_None)] select (_body < 10),
        [(format [LLSTRING(HandWarmer_LArm), (random [10, _larm, 60]) toFixed 0]), LLSTRING(HandWarmer_LArm_None)] select (_larm < 10),
        [(format [LLSTRING(HandWarmer_RArm), (random [10, _rarm, 60]) toFixed 0]), LLSTRING(HandWarmer_RArm_None)] select (_rarm < 10),
        [(format [LLSTRING(HandWarmer_LLeg), (random [10, _lleg, 60]) toFixed 0]), LLSTRING(HandWarmer_LLeg_None)] select (_lleg < 10),
        [(format [LLSTRING(HandWarmer_RLeg), (random [10, _rleg, 60]) toFixed 0]), LLSTRING(HandWarmer_RLeg_None)] select (_rleg < 10)
    ];

    [_output, 5, _target] call ACEFUNC(common,displayTextStructured);
};

if (({_x == 0} count _warmers) == 6) exitWith {
        [LLSTRING(HandWarmer_None), 1.5, _target] call ACEFUNC(common,displayTextStructured);
};

private _output = format [LLSTRING(Other_Handwarmer_Output), 
    [(format [LLSTRING(HandWarmer_Body), (random [10, _body, 60]) toFixed 0]), LLSTRING(HandWarmer_Body_None)] select (_body < 10),
    [(format [LLSTRING(HandWarmer_LArm), (random [10, _larm, 60]) toFixed 0]), LLSTRING(HandWarmer_LArm_None)] select (_larm < 10),
    [(format [LLSTRING(HandWarmer_RArm), (random [10, _rarm, 60]) toFixed 0]), LLSTRING(HandWarmer_RArm_None)] select (_rarm < 10),
    [(format [LLSTRING(HandWarmer_LLeg), (random [10, _lleg, 60]) toFixed 0]), LLSTRING(HandWarmer_LLeg_None)] select (_lleg < 10),
    [(format [LLSTRING(HandWarmer_RLeg), (random [10, _rleg, 60]) toFixed 0]), LLSTRING(HandWarmer_RLeg_None)] select (_rleg < 10)
];

[_output, 5, _player] call ACEFUNC(common,displayTextStructured);