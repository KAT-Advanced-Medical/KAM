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
 * [_ctrlInjuries, _target, 0] call kat_chemical_fnc_gui_updateInjuryListGeneral
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

private _poisontype = _target getVariable [QGVAR(poisonType),""];
if (_target getVariable [QGVAR(airPoisoning),false]) then{
    _entries pushBack [LLSTRING(Intoxication), [0.4,0,0.5,1]];
};
