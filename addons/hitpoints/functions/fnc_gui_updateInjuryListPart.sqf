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
 * [_ctrlInjuries, _target, 0] call kat_breathing_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

private _eviscEntry = [];
if (_selectionN isEqualTo 3) then {
    if ((_target getVariable [QGVAR(evisceration), 0]) > 0) then {
        _eviscEntry pushBack [LLSTRING(Evisceration), [1,0.95,0,1]];
    };

    if (_target getVariable [QGVAR(activeWoundPack), 0] == 1) then {
        _eviscEntry pushBack [LLSTRING(WoundPackApplied), [1,0.95,0,1]];
    };

    if (_target getVariable [QGVAR(activeWoundPack), 0] == 2) then {
        _eviscEntry pushBack [LLSTRING(WoundVacApplied), [1,0.95,0,1]];
    };
};

_target setVariable [QGVAR(gui_updateInjuryList_eviscEntries), _eviscEntry];

