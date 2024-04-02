#include "..\script_component.hpp"
/*
 * Author: mazinskihenry
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
 * [_ctrlInjuries, _target, 0] call kat_pharma_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

private _placed = _target getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _placed select _selectionN;

if (_IVactual > 0) then {
    if (_IVactual == 1) then {
        _entries pushBack [LLSTRING(IO_45_Display), [0.3, 0.6, 0.3, 1]];
    } else {
        _entries pushBack [LLSTRING(IV_16_Display), [0.3, 0.6, 0.3, 1]];
    };
};
