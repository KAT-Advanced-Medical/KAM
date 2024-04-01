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
 * [_ctrlInjuries, _target, 0] call kat_breathing_fnc_gui_updateInjuryListWounds
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_woundEntries"];

// Collected in gui_updateInjuryListPart
private _ptxEntries = _target getVariable [QGVAR(gui_updateInjuryList_ptxEntries), []];

if (_ptxEntries isEqualTo _woundEntries) exitWith {};

_woundEntires append _ptxEntries;
