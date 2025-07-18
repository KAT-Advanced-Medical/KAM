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

private _placed = _target getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVactual = _placed select _selectionN;

if (_IVactual > 0) then {
    switch (_IVactual) do {
        case 1: { _entries pushBack [LLSTRING(IO_45_Display), [0.3, 0.6, 0.3, 1]]};
        case 2: { _entries pushBack [LLSTRING(IV_16_Display), [0.3, 0.6, 0.3, 1]]};
        case 3: { _entries pushBack [LLSTRING(IV_14_Display), [0.3, 0.6, 0.3, 1]]};
        case 4: { _entries pushBack [LLSTRING(IV_20_Display), [0.3, 0.6, 0.3, 1]]};
        case 7: { _entries pushBack [LLSTRING(IV_16_Display), [0.3, 0.6, 0.3, 1]]};
        case 8: { _entries pushBack [LLSTRING(IV_14_Display), [0.3, 0.6, 0.3, 1]]};
        case 9: { _entries pushBack [LLSTRING(IV_20_Display), [0.3, 0.6, 0.3, 1]]};
        case 10: { _entries pushBack [LLSTRING(IV_16_Display), [0.3, 0.6, 0.3, 1]]};
        case 11: { _entries pushBack [LLSTRING(IV_14_Display), [0.3, 0.6, 0.3, 1]]};
        case 12: { _entries pushBack [LLSTRING(IV_20_Display), [0.3, 0.6, 0.3, 1]]};
        case 13: { _entries pushBack [LLSTRING(EZ_IO_Display), [0.3, 0.6, 0.3, 1]]};
        case 14: { _entries pushBack [LLSTRING(EJV_InjuryDisplay), [0.3, 0.6, 0.3, 1]]};
        default {};
        };
};

private _fentPatchArray = _target getVariable [VAR_FENT_PATCH, [0,0,0,0,0,0,0,0,0,0,0,0]];
private _hasPatch = _fentPatchArray findIf { _x > 0 } != -1;
if (_hasPatch) then {
    if ((_fentPatchArray select _selectionN > 0)) then {
        switch (true) do {
        case (_fentPatchArray select _selectionN > 0.8): {
            _entries pushBack [LLSTRING(FentPatchFull_MEDDisplay), [1, 1, 1, 1]];
        };
        case (_fentPatchArray select _selectionN > 0.5): {
            _entries pushBack [LLSTRING(FentPatchPartial_MEDDisplay), [1, 1, 1, 1]];
        };
        case (_fentPatchArray select _selectionN > 0.3): {
            _entries pushBack [LLSTRING(FentPatchWeak_MEDDisplay), [1, 1, 1, 1]];
        };
        case (_fentPatchArray select _selectionN > 0.1): {
            _entries pushBack [LLSTRING(FentPatchWeak_MEDDisplay), [1, 1, 1, 1]];
        };
        };
    } else {
        _entries pushBack [LLSTRING(FentPatch_MEDDisplay), [1, 1, 1, 1]];
    };
};

