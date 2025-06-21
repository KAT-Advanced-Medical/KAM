#include "..\script_component.hpp"
/*
 * Author: Blue
 * Updates injury list for given body part for the target.
 *
 * Arguments:
 * 0: Injury list <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part, -1 to only show overall health info <NUMBER>
 * 3: Entries <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlInjuries, _target, 0] call kat_circulation_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];


if ((_target getVariable [QGVAR(attachedLucasState), false] == true) && (_target getVariable [QGVAR(attachedLucas), false]) && (_selectionN isEqualTo 2)) then {
    _entries pushBack [LLSTRING(LucasActive), [0.3, 0.8, 0.8, 1]];
};

if ((_target getVariable [QGVAR(attachedLucasState), false] == false) && (_target getVariable [QGVAR(attachedLucas), false]) && (_selectionN isEqualTo 2)) then {
    _entries pushBack [LLSTRING(LucasInactive), [0.3, 0.8, 0.8, 1]];
};