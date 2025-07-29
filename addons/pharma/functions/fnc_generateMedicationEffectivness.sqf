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
    case (0 <= _id && _id <= 2): {_defaultMedEffectivness = 0.80};
    case (3 <= _id && _id <= 5): {_defaultMedEffectivness = 0.85};
    case (6 <= _id && _id <= 8): {_defaultMedEffectivness = 0.83};
    case (9 <= _id && _id <= 10): {_defaultMedEffectivness = 0.88};
    case (11 <= _id && _id <= 13): {_defaultMedEffectivness = 0.98};
    case (14 <= _id && _id <= 15): {_defaultMedEffectivness = 1.02};
    case (16 <= _id && _id <= 18): {_defaultMedEffectivness = 0.93};
    case (19 <= _id && _id <= 20): {_defaultMedEffectivness = 0.97};
    case (21 <= _id && _id <= 23): {_defaultMedEffectivness = 0.96};
    case (24 <= _id && _id <= 25): {_defaultMedEffectivness = 1.00};
    case (26 <= _id && _id <= 28): {_defaultMedEffectivness = 0.77};
    case (29 <= _id && _id <= 30): {_defaultMedEffectivness = 0.82};
    case (31 <= _id && _id <= 33): {_defaultMedEffectivness = 0.85};
    case (34 <= _id && _id <= 35): {_defaultMedEffectivness = 0.89};
    case (36 <= _id && _id <= 38): {_defaultMedEffectivness = 0.94};
    case (39 <= _id && _id <= 40): {_defaultMedEffectivness = 0.99};
    case (41 <= _id && _id <= 43): {_defaultMedEffectivness = 0.90};
    case (44 <= _id && _id <= 45): {_defaultMedEffectivness = 0.95};
    case (46 <= _id && _id <= 48): {_defaultMedEffectivness = 0.99};
    case (49 <= _id && _id <= 50): {_defaultMedEffectivness = 1.04};
    case (51 <= _id && _id <= 53): {_defaultMedEffectivness = 0.82};
    case (54 <= _id && _id <= 55): {_defaultMedEffectivness = 0.87};
    case (56 <= _id && _id <= 58): {_defaultMedEffectivness = 0.98};
    case (59 <= _id && _id <= 60): {_defaultMedEffectivness = 1.03};
    case (61 <= _id && _id <= 63): {_defaultMedEffectivness = 0.80};
    case (64 <= _id && _id <= 65): {_defaultMedEffectivness = 0.85};
    case (66 <= _id && _id <= 68): {_defaultMedEffectivness = 0.86};
    case (69 <= _id && _id <= 70): {_defaultMedEffectivness = 0.91};
    case (71 <= _id && _id <= 73): {_defaultMedEffectivness = 0.87};
    case (74 <= _id && _id <= 75): {_defaultMedEffectivness = 0.92};
    case (76 <= _id && _id <= 78): {_defaultMedEffectivness = 0.79};
    case (79 <= _id && _id <= 80): {_defaultMedEffectivness = 0.84};
    case (81 <= _id && _id <= 83): {_defaultMedEffectivness = 0.95};
    case (84 <= _id && _id <= 85): {_defaultMedEffectivness = 1.00};
    case (86 <= _id && _id <= 88): {_defaultMedEffectivness = 0.91};
    case (89 <= _id && _id <= 90): {_defaultMedEffectivness = 0.96};
    case (91 <= _id && _id <= 93): {_defaultMedEffectivness = 0.84};
    case (94 <= _id && _id <= 95): {_defaultMedEffectivness = 0.89};
    case (96 <= _id && _id <= 97): {_defaultMedEffectivness = 1.00};
    case (98 <= _id && _id <= 99): {_defaultMedEffectivness = 1.05};
    default {_defaultMedEffectivness = 1.00};
    };
    } else {
    _defaultMedEffectivness = _playerdefaultMedEffectivness;
    };
_defaultMedEffectivness;