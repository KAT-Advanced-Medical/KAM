#include "..\script_component.hpp"
/*
 * Author: Blue
 * Give interactions to stop being carried
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Unit Carrier <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_misc_fnc_stopCarryingPrompt
 *
 * Public: No
 */

params ["_unit", "_carrier"];

if (ACE_player != _unit) exitWith {};

["", LLSTRING(CancelCarrying), ""] call ACEFUNC(interaction,showMouseHint);
GVAR(Carrier) = _carrier;

_unit setVariable [QGVAR(GetOffActionID), [0xF1, [false, false, false], {
    [QGVAR(dropObject_carryLocal), [GVAR(Carrier), (GVAR(Carrier) getVariable QACEGVAR(dragging,carriedObject))], GVAR(Carrier)] call CBA_fnc_targetEvent;
}, "keyup", "", false, 0] call CBA_fnc_addKeyHandler];

[{
    params ["_carrier", "_unit"];

    dialog || _carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull
}, {
    params ["_carrier", "_unit"];

    if (_carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isNotEqualTo objNull) then {
        [QGVAR(dropObject_carryLocal), [GVAR(Carrier), (GVAR(Carrier) getVariable QACEGVAR(dragging,carriedObject))], GVAR(Carrier)] call CBA_fnc_targetEvent;
    };
}, [_carrier, _unit], 3600, {}] call CBA_fnc_waitUntilAndExecute;

[{
    params ["_carrier"];

    _carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull
}, {
    params ["_carrier", "_unit"];

    if (_carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isNotEqualTo objNull) then {
        [QGVAR(dropObject_carryLocal), [_carrier, (_carrier getVariable QACEGVAR(dragging,carriedObject))], _carrier] call CBA_fnc_targetEvent;
    };

    [] call ACEFUNC(interaction,hideMouseHint);
    GVAR(Carrier) = nil;
    [_unit getVariable QGVAR(GetOffActionID), "keyup"] call CBA_fnc_removeKeyHandler;
    _unit setVariable [QGVAR(GetOffActionID), nil];
}, [_carrier, _unit], 3600, {}] call CBA_fnc_waitUntilAndExecute;
