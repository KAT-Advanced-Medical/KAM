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
 * [_ctrlInjuries, _target, 0] call kat_airway_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if (_target getVariable [QGVAR(overstretch), false] && _selectionN isEqualTo 0) then {
    _entries pushBack [LLSTRING(Hyperextended), [0.1, 1, 1, 1]];
};

if (_target getVariable [QGVAR(airway), false] && _selectionN isEqualTo 0) then {
    private _a = _target getVariable [QGVAR(airway_item), ""];
    if !(_a isEqualTo "") then {
        private _text = format [LSTRING(%1_Display), _a];
        _entries pushback [localize _text, [0.1, 1, 1, 1]];
    };
};
