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

private _defaultHeartRate = 80;
private _playerdefaultHeartRate = _unit getVariable [QGVAR(defaultHeartRate), _defaultHeartRate];

if (isMultiplayer) then {
    private _id = parseNumber (getPlayerUID _unit select [15, 2]);
    TRACE_1("userID", _id)
    switch(true) do {
        case (0 <= _id && _id <= 5): {_defaultHeartRate = 71};
        case (6 <= _id && _id <= 10): {_defaultHeartRate = 76};
        case (11 <= _id && _id <= 15): {_defaultHeartRate = 87};
        case (16 <= _id && _id <= 20): {_defaultHeartRate = 83};
        case (21 <= _id && _id <= 25): {_defaultHeartRate = 86};
        case (26 <= _id && _id <= 30): {_defaultHeartRate = 72};
        case (31 <= _id && _id <= 35): {_defaultHeartRate = 78};
        case (36 <= _id && _id <= 40): {_defaultHeartRate = 84};
        case (41 <= _id && _id <= 45): {_defaultHeartRate = 80};
        case (46 <= _id && _id <= 50): {_defaultHeartRate = 88};
        case (51 <= _id && _id <= 55): {_defaultHeartRate = 75};
        case (56 <= _id && _id <= 60): {_defaultHeartRate = 87};
        case (61 <= _id && _id <= 65): {_defaultHeartRate = 74};
        case (66 <= _id && _id <= 70): {_defaultHeartRate = 79};
        case (71 <= _id && _id <= 75): {_defaultHeartRate = 81};
        case (76 <= _id && _id <= 80): {_defaultHeartRate = 73};
        case (81 <= _id && _id <= 85): {_defaultHeartRate = 85};
        case (86 <= _id && _id <= 90): {_defaultHeartRate = 82};
        case (91 <= _id && _id <= 95): {_defaultHeartRate = 77};
        case (96 <= _id && _id <= 99): {_defaultHeartRate = 89};
        default {_defaultHeartRate = 80};
    };
    } else {
    _defaultHeartRate = _playerdefaultHeartRate;
    };
_defaultHeartRate;