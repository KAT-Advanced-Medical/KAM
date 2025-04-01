#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
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
 * [_ctrlInjuries, _target, 0] call kat_ophthamology_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

private _eyeInjuries = _target getVariable [QGVAR(eyeInjuries), [1,1]];

if ((({_x != 1} count _eyeInjuries) > 0) && (_selectionN == 0)) then {
    _entries pushBack [LLSTRING(eyeInjuryPresent), [0.36, 0.58, 0.23, 1]];
};
