#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Treatment handle function to remove a bag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 'hand_r', 'SalineIV'] call kat_misc_fnc_treatmentIV;
 *
 * Public: No
 */

params ["_player", "_target", "_bodyPart", "_className", "_item"];

private _value = 0;

switch (_className) do {
    case "SalineIV": {
        _value = 1000;
    };
    case "SalineIV_500": {
        _value = 500;
    };
    case "SalineIV_250": {
        _value = 250;
    };
};

[_player, _value] call FUNC(removeIVbag);
[_player, _target, _bodyPart, _className, objNull, _item] call ACEFUNC(medical_treatment,ivBag);
