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
 * [unit, body] call kat_circulation_fnc_generateDefaultWeight;
 *
 * Public: No
 */

params ["_unit"];

private _defaultWeight = 80;
private _playerdefaultWeight = _unit getVariable [QGVAR(currentWeight), _defaultWeight];

if (isMultiplayer) then {
    private _id = parseNumber (getPlayerUID _unit select [15, 2]);
        switch (true) do {
    case (0  <= _id && _id <= 2):   { _defaultWeight = 92 };
    case (3  <= _id && _id <= 4):   { _defaultWeight = 69 };
    case (5  <= _id && _id <= 6):   { _defaultWeight = 87 };
    case (7  <= _id && _id <= 8):   { _defaultWeight = 100 };
    case (9  <= _id && _id <= 10):  { _defaultWeight = 64 };
    case (11 <= _id && _id <= 12):  { _defaultWeight = 84 };
    case (13 <= _id && _id <= 14):  { _defaultWeight = 96 };
    case (15 <= _id && _id <= 16):  { _defaultWeight = 73 };
    case (17 <= _id && _id <= 18):  { _defaultWeight = 70 };
    case (19 <= _id && _id <= 20):  { _defaultWeight = 88 };
    case (21 <= _id && _id <= 22):  { _defaultWeight = 63 };
    case (23 <= _id && _id <= 24):  { _defaultWeight = 61 };
    case (25 <= _id && _id <= 26):  { _defaultWeight = 60 };
    case (27 <= _id && _id <= 28):  { _defaultWeight = 93 };
    case (29 <= _id && _id <= 30):  { _defaultWeight = 75 };
    case (31 <= _id && _id <= 32):  { _defaultWeight = 90 };
    case (33 <= _id && _id <= 34):  { _defaultWeight = 66 };
    case (35 <= _id && _id <= 36):  { _defaultWeight = 71 };
    case (37 <= _id && _id <= 38):  { _defaultWeight = 78 };
    case (39 <= _id && _id <= 40):  { _defaultWeight = 94 };
    case (41 <= _id && _id <= 42):  { _defaultWeight = 89 };
    case (43 <= _id && _id <= 44):  { _defaultWeight = 67 };
    case (45 <= _id && _id <= 46):  { _defaultWeight = 86 };
    case (47 <= _id && _id <= 48):  { _defaultWeight = 80 };
    case (49 <= _id && _id <= 50):  { _defaultWeight = 62 };
    case (51 <= _id && _id <= 52):  { _defaultWeight = 98 };
    case (53 <= _id && _id <= 54):  { _defaultWeight = 76 };
    case (55 <= _id && _id <= 56):  { _defaultWeight = 91 };
    case (57 <= _id && _id <= 58):  { _defaultWeight = 60 };
    case (59 <= _id && _id <= 60):  { _defaultWeight = 68 };
    case (61 <= _id && _id <= 62):  { _defaultWeight = 65 };
    case (63 <= _id && _id <= 64):  { _defaultWeight = 95 };
    case (65 <= _id && _id <= 66):  { _defaultWeight = 97 };
    case (67 <= _id && _id <= 68):  { _defaultWeight = 66 };
    case (69 <= _id && _id <= 70):  { _defaultWeight = 99 };
    case (71 <= _id && _id <= 72):  { _defaultWeight = 72 };
    case (73 <= _id && _id <= 74):  { _defaultWeight = 82 };
    case (75 <= _id && _id <= 76):  { _defaultWeight = 61 };
    case (77 <= _id && _id <= 78):  { _defaultWeight = 77 };
    case (79 <= _id && _id <= 80):  { _defaultWeight = 79 };
    case (81 <= _id && _id <= 82):  { _defaultWeight = 83 };
    case (83 <= _id && _id <= 84):  { _defaultWeight = 74 };
    case (85 <= _id && _id <= 86):  { _defaultWeight = 85 };
    case (87 <= _id && _id <= 88):  { _defaultWeight = 81 };
    case (89 <= _id && _id <= 90):  { _defaultWeight = 67 };
    case (91 <= _id && _id <= 92):  { _defaultWeight = 63 };
    case (93 <= _id && _id <= 94):  { _defaultWeight = 64 };
    case (95 <= _id && _id <= 96):  { _defaultWeight = 65 };
    case (97 <= _id && _id <= 98):  { _defaultWeight = 62 };
    case (99 <= _id && _id <= 100): { _defaultWeight = 68 };
    default { _defaultWeight = 80 };
    };
    } else {
    _defaultWeight = _playerdefaultWeight;
    };
_defaultWeight;