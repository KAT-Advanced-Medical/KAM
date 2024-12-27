#include "..\script_component.hpp"
/*
 * Author: AtrixZockt
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
 * [_ctrlInjuries, _target, 0] call kat_airway_fnc_gui_updateInjuryListGeneral
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if (_target getVariable [QGVAR(recovery), false]) then {
    _entries pushback [LLSTRING(RecoveryPosition), [0.1, 1, 1, 1]];
};
