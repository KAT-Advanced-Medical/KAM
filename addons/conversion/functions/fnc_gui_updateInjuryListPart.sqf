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
 * [_ctrlInjuries, _target, 0] call kat_conversion_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if (_target getVariable [QGVAR(currentConverted), false] && GVAR(enableConversionMessage)) then {
    _entries pushBack [LLSTRING(ConversionText), [0.35, 0.72, 0.82, 1]];
};