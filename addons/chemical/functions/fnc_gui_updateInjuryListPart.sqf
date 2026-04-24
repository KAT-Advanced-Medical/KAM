#include "..\script_component.hpp"
/*
 * Author: kolmipilot
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
 * [_ctrlInjuries, _target, 0] call kat_airway_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if (_target getVariable [QGVAR(contaminatedBody), false] && _selectionN in [1,2,3,4,5]) then {
    _entries pushBack [LLSTRING(Contamination), [0.4,0,0.5,1]];
};

if (_target getVariable [QGVAR(contaminatedHead), false] && _selectionN isEqualTo 0) then {
    _entries pushBack [LLSTRING(Contamination), [0.4,0,0.5,1]];
};
