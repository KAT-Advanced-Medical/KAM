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

["", LLSTRING(CancelCarrying), ""] call ACEFUNC(interaction,showMouseHint);
GVAR(Carrier) = _carrier;

_unit setVariable [QGVAR(GetOffActionID), [0xF1, [false, false, false], {
    [format [LLSTRING(StoppedCarrying%1), [(GVAR(Carrier) getVariable QACEGVAR(dragging,carriedObject)), true] call ACEFUNC(common,getName)], 1.5, GVAR(Carrier)] call ACEFUNC(common,displayTextStructured);
    [QGVAR(dropObject_carryLocal), [GVAR(Carrier), (GVAR(Carrier) getVariable QACEGVAR(dragging,carriedObject))], GVAR(Carrier)] call CBA_fnc_targetEvent;
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler];

[{
    params ["_carrier", "_unit"];

    dialog || _carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull
}, {
    params ["_carrier", "_unit"];

    if !(_carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull) then {
        [format [LLSTRING(StoppedCarrying%1), [(_this select 0), true] call ACEFUNC(common,getName)], 1.5, GVAR(Carrier)] call ACEFUNC(common,displayTextStructured);
        [QGVAR(dropObject_carryLocal), [GVAR(Carrier), (GVAR(Carrier) getVariable QACEGVAR(dragging,carriedObject))], GVAR(Carrier)] call CBA_fnc_targetEvent;
    };
}, [_carrier, _unit], 3600, {}] call CBA_fnc_waitUntilAndExecute;

[{
    params ["_carrier"];

    _carrier getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull
}, {
    params ["_carrier", "_unit"];

    [] call ACEFUNC(interaction,hideMouseHint);
    GVAR(Carrier) = nil;
    [_unit getVariable QGVAR(GetOffActionID), "keydown"] call CBA_fnc_removeKeyHandler;
    _unit setVariable [QGVAR(GetOffActionID), nil];
}, [_carrier, _unit], 3600, {
    params ["_carrier", "_unit"];

    [] call ACEFUNC(interaction,hideMouseHint);
    GVAR(Carrier) = nil;
    [_unit getVariable QGVAR(GetOffActionID), "keydown"] call CBA_fnc_removeKeyHandler;
    _unit setVariable [QGVAR(GetOffActionID), nil];
}] call CBA_fnc_waitUntilAndExecute;
