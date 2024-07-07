#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Attaches a armband to the according limb.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 * 2: Number
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_Armband_Red_Cross_Goggles", 0] call kat_misc_fnc_slingArmband;
 *
 * Public: No
 */

params ["_unit", "_armbandItem", "_limbNumber"];

private _limbXYZ = [];
private _limbYPR = [];
private _limbBone = "";

switch (_limbNumber) do {
    case 0: { 
        _limbXYZ = missionNamespace getVariable [QGVAR(armbandSlingLeftArm), []];
        _limbYPR = missionNamespace getVariable [QGVAR(armbandSlingLeftArmRotation), []];
        _limbBone = "leftforearm";
    };

    case 1: { 
        _limbXYZ = missionNamespace getVariable [QGVAR(armbandSlingRightArm), []];
        _limbYPR = missionNamespace getVariable [QGVAR(armbandSlingRightArmRotation), []];
        _limbBone = "rightforearm";
    };

    case 2: { 
        _limbXYZ = missionNamespace getVariable [QGVAR(armbandSlingLeftLeg), []];
        _limbYPR = missionNamespace getVariable [QGVAR(armbandSlingLeftLegRotation), []];
        _limbBone = "LeftUpLeg";
    };

    case 3: { 
        _limbXYZ = missionNamespace getVariable [QGVAR(armbandSlingRightLeg), []];
        _limbYPR = missionNamespace getVariable [QGVAR(armbandSlingRightLegRotation), []];
        _limbBone = "RightUpLeg";
    };
};

private _isNVG = _armbandItem find "V";
private _armbandVersion = _armbandItem;
_unit removeItem _armbandItem;

if (_isNVG == -1) then {
    _armbandItem = _armbandItem trim ["Goggles", 2];
} else {
    _armbandItem = _armbandItem trim ["NVG", 2];
};
_armbandItem = _armbandItem + "Object";

private _armbandObject = _armbandItem createVehicle position _unit;
_armbandObject attachTo [_unit, _limbXYZ, _limbBone, true];
[_armbandObject, _limbYPR] call BIS_fnc_setObjectRotation;

switch (_limbNumber) do {
    case 0: {
        _unit setVariable [QGVAR(whichArmabndisSlingedLA), _armbandObject, true]; 
        _unit setVariable [QGVAR(armbandVersionLA), _armbandVersion, true];
        _unit setVariable [QGVAR(isLeftArmFree), false, true];
    };

    case 1: {
        _unit setVariable [QGVAR(whichArmabndisSlingedRA), _armbandObject, true]; 
        _unit setVariable [QGVAR(armbandVersionRA), _armbandVersion, true];
        _unit setVariable [QGVAR(isRightArmFree), false, true];
    };

    case 2: {
        _unit setVariable [QGVAR(whichArmabndisSlingedLL), _armbandObject, true]; 
        _unit setVariable [QGVAR(armbandVersionLL), _armbandVersion, true];
        _unit setVariable [QGVAR(isLeftLegFree), false, true];
    };

    case 3: {
        _unit setVariable [QGVAR(whichArmabndisSlingedRL), _armbandObject, true]; 
        _unit setVariable [QGVAR(armbandVersionRL), _armbandVersion, true];
        _unit setVariable [QGVAR(isRightLegFree), false, true];
    };
};
