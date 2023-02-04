#include "script_component.hpp"
/*
 * Author: Blue
 * Generates bloodtype for player according to settings
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Dead body <OBJECT>
 *
 * Return Value:
 * Bloodtype <STRING>
 *
 * Example:
 * [unit, body] call kat_circulation_fnc_generateBloodType;
 *
 * Public: No
 */

params ["_unit","_body"];

if (_unit != player) exitWith {};

private _pb = _unit getVariable [QGVAR(bloodTypePlayer), "O"];
private _b = "O";

switch(GVAR(bloodTypeSetting)) do {
    case 1: {// forced player bloodtype
        if(isNull _body) then {
            _b = _pb;
        } else {
            _b = _body getVariable [QGVAR(bloodtype), _pb];
        };
    };
    case 2: {// random bloodtype
        if(GVAR(bloodTypeRandomWeighted)) then {
            _b = selectRandomWeighted ["A", 0.3, "A_N", 0.08, "B", 0.09, "B_N", 0.02, "AB", 0.02, "AB_N", 0.01, "O", 0.35, "O_N", 0.13];
        } else {
            _b = selectRandom ["A", "A_N", "B", "B_N", "AB", "AB_N", "O", "O_N"];
        };
    };
    case 3: {// random bloodtype on join (once)
        if(isNull _body) then {
            if(GVAR(bloodTypeRandomWeighted)) then {
                _b = selectRandomWeighted ["A", 0.3, "A_N", 0.08, "B", 0.09, "B_N", 0.02, "AB", 0.02, "AB_N", 0.01, "O", 0.35, "O_N", 0.13];
            } else {
                _b = selectRandom ["A", "A_N", "B", "B_N", "AB", "AB_N", "O", "O_N"];
            };
        } else {
            _b = _body getVariable [QGVAR(bloodtype), _pb];
        };
    };
    case 4: {// steamid bloodtype
        if(isMultiplayer) then {
            private _id = parseNumber (getPlayerUID _unit select [15, 2]);

            switch(true) do {
                case (0 <= _id && _id <= 34): {_b = "O"};
                case (35 <= _id && _id <= 64): {_b = "A"};
                case (65 <= _id && _id <= 77): {_b = "O_N"};
                case (78 <= _id && _id <= 86): {_b = "B"};
                case (87 <= _id && _id <= 94): {_b = "A_N"};
                case (95 <= _id && _id <= 96): {_b = "AB"};
                case (97 <= _id && _id <= 98): {_b = "B_N"};
                default {_b = "AB_N"};
            };

        } else {
            _b = _pb; 
        }; 
    };
    case 5: {// steamid custom list bloodtype
        if(isMultiplayer) then {
            private _id = parseNumber (getPlayerUID _unit select [16,1]);
            private _bl = GVAR(bloodTypeCustomList) splitString ",";
            _b = _bl select _id;
        } else {
            _b = _pb; 
        }; 
    };
    default { _b = _pb; };
};

_b;