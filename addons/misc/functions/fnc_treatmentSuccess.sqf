#include "..\script_component.hpp"
/*
 * Author: KoffeinFlummi, Glowbal, mharis001
 * Modified: Blue
 * Handles treatment process success.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Medic <OBJECT>
 *   1: Patient <OBJECT>
 *   2: Body Part <STRING>
 *   3: Treatment <STRING>
 *   4: Item User <OBJECT>
 *   5: Used Item <STRING>
 *   6: Extra Arguments <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_args"];
_args params ["_medic", "_patient", "_bodyPart", "_classname", "_itemUser", "_usedItem", "_bandageEffectiveness", ["_extraArgs",[]]];

// Switch medic to end animation immediately
private _endInAnim = _medic getVariable QACEGVAR(medical_treatment,endInAnim);

if (!isNil "_endInAnim") then {
    if (animationState _medic != _endInAnim) then {
        [_medic, _endInAnim, 2] call ACEFUNC(common,doAnimation);
    };

    _medic setVariable [QACEGVAR(medical_treatment,endInAnim), nil];
};

// Reset medic animation speed coefficient
[QACEGVAR(common,setAnimSpeedCoef), [_medic, 1]] call CBA_fnc_globalEvent;

if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
    ACEGVAR(advanced_fatigue,setAnimExclusions) deleteAt (ACEGVAR(advanced_fatigue,setAnimExclusions) find QUOTE(ACE_ADDON(medical_treatment)));
};

private _callbackCondition = true;

GET_FUNCTION(_callbackCondition,configFile >> QACEGVAR(medical_treatment,actions) >> _classname >> "callbackCondition");
if (_callbackCondition isEqualType {}) then {
    if ((getText (configFile >> QACEGVAR(medical_treatment,actions) >> _classname >> "callbackCondition")) isEqualTo "useCondition") then {
        GET_FUNCTION(_condition,configFile >> QACEGVAR(medical_treatment,actions) >> _classname >> "condition");
        _callbackCondition = _condition;
    };

    if (_callbackCondition isEqualTo {}) exitWith {
        _callbackCondition = true;
    };
    _callbackCondition = call _callbackCondition;
};

if !(_callbackCondition) exitWith {};

// Call treatment specific success callback
GET_FUNCTION(_callbackSuccess,configFile >> QACEGVAR(medical_treatment,actions) >> _classname >> "callbackSuccess");

_args call _callbackSuccess;

// Call litter creation handler
_args call ACEFUNC(medical_treatment,createLitter);

// Emit local event for medical API
["ace_treatmentSucceded", [_medic, _patient, _bodyPart, _classname, _itemUser, _usedItem, _bandageEffectiveness, _extraArgs]] call CBA_fnc_localEvent;
