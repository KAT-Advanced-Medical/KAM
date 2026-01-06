#include "..\script_component.hpp"
/*
 * Author: Blue
 * Generates blood type for player according to settings
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Dead body <OBJECT>
 *
 * Return Value:
 * Blood type <STRING>
 *
 * Example:
 * [unit, body] call kat_circulation_fnc_generateBloodType;
 *
 * Public: No
 */
params ["_unit"];

private _defaultMedEffectivness = 1;
private _playerdefaultMedEffectivness = _unit getVariable [QGVAR(medicationEffectivness), _defaultMedEffectivness];

if (isMultiplayer) then {
    private _id = parseNumber (getPlayerUID _unit select [15, 2]);

    switch (true) do {
    case (0 <= _id && _id <= 5): {_defaultMedEffectivness = 0.9};
    case (6 <= _id && _id <= 10): {_defaultMedEffectivness = 0.91};
    case (11 <= _id && _id <= 15): {_defaultMedEffectivness = 0.92};
    case (16 <= _id && _id <= 20): {_defaultMedEffectivness = 0.93};
    case (21 <= _id && _id <= 25): {_defaultMedEffectivness = 0.94};
    case (26 <= _id && _id <= 30): {_defaultMedEffectivness = 0.95};
    case (31 <= _id && _id <= 35): {_defaultMedEffectivness = 0.96};
    case (36 <= _id && _id <= 40): {_defaultMedEffectivness = 0.97};
    case (41 <= _id && _id <= 45): {_defaultMedEffectivness = 0.98};
    case (46 <= _id && _id <= 50): {_defaultMedEffectivness = 0.99};
    case (51 <= _id && _id <= 55): {_defaultMedEffectivness = 1};
    case (56 <= _id && _id <= 60): {_defaultMedEffectivness = 1.02};
    case (61 <= _id && _id <= 65): {_defaultMedEffectivness = 1.04};
    case (66 <= _id && _id <= 70): {_defaultMedEffectivness = 1.06};
    case (71 <= _id && _id <= 75): {_defaultMedEffectivness = 1.08};
    case (76 <= _id && _id <= 80): {_defaultMedEffectivness = 1.1};
    case (81 <= _id && _id <= 85): {_defaultMedEffectivness = 1.12};
    case (86 <= _id && _id <= 90): {_defaultMedEffectivness = 1.14};
    case (91 <= _id && _id <= 95): {_defaultMedEffectivness = 1.16};
    case (96 <= _id && _id <= 99): {_defaultMedEffectivness = 1.18};
    default {_defaultMedEffectivness = 1.00};
    };
    } else {
    _defaultMedEffectivness = _playerdefaultMedEffectivness;
    };
_defaultMedEffectivness;