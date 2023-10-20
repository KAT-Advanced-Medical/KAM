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

params ["_unit", "_body", ["_respawned",false]];

private _bloodType = "O_N";
[QGVAR(setPreferredBloodType), [_unit], _unit] call CBA_fnc_targetEvent;
private _playerBloodType = _unit getVariable [QGVAR(bloodTypePlayer), _bloodType];

switch(GVAR(bloodTypeSetting)) do {
    case 1: {// forced player bloodtype
        if (!_respawned || isNil {_body getVariable QGVAR(bloodtype)}) then {
            _bloodType = _playerBloodType;
        } else {
            _bloodType = _body getVariable QGVAR(bloodtype);
        };
    };
    case 2: {// random bloodtype
        if (GVAR(bloodTypeRandomWeighted)) then {
            _bloodType = selectRandomWeighted ["A", 0.3, "A_N", 0.08, "B", 0.09, "B_N", 0.02, "AB", 0.02, "AB_N", 0.01, "O", 0.35, "O_N", 0.13];
        } else {
            _bloodType = selectRandom ["A", "A_N", "B", "B_N", "AB", "AB_N", "O", "O_N"];
        };
    };
    case 3: {// random bloodtype on join (once)
        if (!_respawned || isNil {_body getVariable QGVAR(bloodtype)}) then {
            if (GVAR(bloodTypeRandomWeighted)) then {
                _bloodType = selectRandomWeighted ["A", 0.3, "A_N", 0.08, "B", 0.09, "B_N", 0.02, "AB", 0.02, "AB_N", 0.01, "O", 0.35, "O_N", 0.13];
            } else {
                _bloodType = selectRandom ["A", "A_N", "B", "B_N", "AB", "AB_N", "O", "O_N"];
            };
        } else {
            _bloodType = _body getVariable QGVAR(bloodtype);
        };
    };
    case 4: {// steamid bloodtype
        if (isMultiplayer) then {
            private _id = parseNumber (getPlayerUID _unit select [15, 2]);

            switch(true) do {
                case (0 <= _id && _id <= 34): {_bloodType = "O"};
                case (35 <= _id && _id <= 64): {_bloodType = "A"};
                case (65 <= _id && _id <= 77): {_bloodType = "O_N"};
                case (78 <= _id && _id <= 86): {_bloodType = "B"};
                case (87 <= _id && _id <= 94): {_bloodType = "A_N"};
                case (95 <= _id && _id <= 96): {_bloodType = "AB"};
                case (97 <= _id && _id <= 98): {_bloodType = "B_N"};
                default {_bloodType = "AB_N"};
            };

        } else {
            _bloodType = _playerBloodType;
        };
    };
    case 5: {// steamid custom list bloodtype
        if (isMultiplayer) then {
            private _id = parseNumber (getPlayerUID _unit select [16,1]);
            private _bloodTypeList = GVAR(bloodTypeCustomList) splitString ", ";
            _bloodType = _bloodTypeList select _id;
        } else {
            _bloodType = _playerBloodType;
        };
    };
    default { _bloodType = _playerBloodType; };
};

_bloodType;
