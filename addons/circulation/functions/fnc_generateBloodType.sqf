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

private _b = "O";

switch(GVAR(bloodTypeSetting)) do {
    case 1: {// forced player bloodtype
        if(isNull _body) then {
            _b = GVAR(bloodTypeSettingPlayer);
        } else {
            _b = _body getVariable [QGVAR(bloodtype), GVAR(bloodTypeSettingPlayer)];
        };
    };
    case 2: {// random bloodtype
        _b = selectRandomWeighted ["A",0.3,"A_N",0.08,"B",0.08,"B_N",0.02,"AB",0.02,"AB_N",0.01,"O",0.35,"O_N",0.13];
    };
    case 3: {// random bloodtype on join (once)
        if(isNull _body) then {
            _b = selectRandomWeighted ["A",0.3,"A_N",0.08,"B",0.08,"B_N",0.02,"AB",0.02,"AB_N",0.01,"O",0.35,"O_N",0.13];
        } else {
            _b = _body getVariable [QGVAR(bloodtype), GVAR(bloodTypeSettingPlayer)];
        };
    };
    /*case 4: {// steamid bloodtype
        if(isMultiplayer) then {
            _b = parseNumber(getPlayerUID _unit);
        } else {
            _b = GVAR(bloodTypeSettingPlayer); 
        }; 
    };*/
    default { _b = GVAR(bloodTypeSettingPlayer); };
};

_b;