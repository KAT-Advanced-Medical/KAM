#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Detaches a armband from a previously attached limb.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Number
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0] call kat_misc_fnc_unSlingArmband;
 *
 * Public: No
 */

params ["_unit", "_limbNumber"];

private _armbandObject = ObjNull;
private _originalArmband = "";

switch (_limbNumber) do {
    case 0: {
        _armbandObject = _unit getVariable [QGVAR(whichArmabndisSlingedLA), ObjNull]; 
        _originalArmband = _unit getVariable [QGVAR(armbandVersionLA), _armbandVersion];
        _unit setVariable [QGVAR(isLeftArmFree), true, true];
    };

    case 1: {
        _armbandObject = _unit getVariable [QGVAR(whichArmabndisSlingedRA), ObjNull]; 
        _originalArmband = _unit getVariable [QGVAR(armbandVersionRA), _armbandVersion];
        _unit setVariable [QGVAR(isRightArmFree), true, true];
    };

    case 2: {
        _armbandObject = _unit getVariable [QGVAR(whichArmabndisSlingedLL), ObjNull]; 
        _originalArmband = _unit getVariable [QGVAR(armbandVersionLL), _armbandVersion];
        _unit setVariable [QGVAR(isLeftLegFree), true, true];
    };

    case 3: {
        _armbandObject = _unit getVariable [QGVAR(whichArmabndisSlingedRL), ObjNull]; 
        _originalArmband = _unit getVariable [QGVAR(armbandVersionRL), _armbandVersion];
        _unit setVariable [QGVAR(isRightLegFree), true, true];
    };
};

deleteVehicle _armbandObject;
[_unit, _originalArmband] call ACEFUNC(common,addToInventory);
