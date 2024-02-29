#include "..\script_component.hpp"
/*
 * Author: KoffeinFlummi, Glowbal, mharis001
 * Modified: Blue
 * Handles treatment process failure.
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
_args params ["_medic", "_patient", "_bodyPart", "_classname", "_itemUser", "_usedItem", ["_extraArgs",[]]];
_extraArgs params [["_magazineCount", -1]];

// Return used item to user (if used)
if (!isNull _itemUser) then {
    if !(((_usedItem call BIS_fnc_itemType) select 0) isEqualTo "Magazine") then {
        [_itemUser, _usedItem] call ACEFUNC(common,addToInventory);
    } else {
        [_itemUser, _usedItem, false] call EFUNC(pharma,setMagItem);
    };
};

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

// Call treatment specific failure callback
GET_FUNCTION(_callbackFailure,configFile >> QACEGVAR(medical_treatment,actions) >> _classname >> "callbackFailure");

_args call _callbackFailure;

["ace_treatmentFailed", [_medic, _patient, _bodyPart, _classname, _itemUser, _usedItem]] call CBA_fnc_localEvent;
