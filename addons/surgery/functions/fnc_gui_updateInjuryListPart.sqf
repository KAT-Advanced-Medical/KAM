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
 * [_ctrlInjuries, _target, 0] call kat_surgery_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if (GET_SURGICAL_TOURNIQUETS(_target) select _selectionN != 0) then {
    _entries pushBack [LLSTRING(Reboa_Status), [0.77, 0.20, 0.08, 1]];
};

if ((_target getVariable [QGVAR(fractures), [0,0,0,0,0,0,0,0,0,0,0,0]]) select _selectionN != 0) then {
    switch ((_target getVariable [QGVAR(fractures), [0,0,0,0,0,0,0,0,0,0,0,0]]) select _selectionN) do {
        case 2.1: {
            _entries pushBack [LLSTRING(Incision), [0.3, 0.8, 0.8, 1]];
        };
        case 3.1: {
            _entries pushBack [LLSTRING(Incision), [0.3, 0.8, 0.8, 1]];
        };
        case 2.3: {
            _entries pushBack [LLSTRING(Exposed), [0.3, 0.8, 0.8, 1]];
        };
        case 3.3: {
            _entries pushBack [LLSTRING(Exposed), [0.3, 0.8, 0.8, 1]];
        };
        case 2.5: {
            _entries pushBack [LLSTRING(Irrigated), [0.3, 0.8, 0.8, 1]];
        };
        case 3.5: {
            _entries pushBack [LLSTRING(Clamped), [0.3, 0.8, 0.8, 1]];
        };
        case 2.7: {
            _entries pushBack [LLSTRING(Plated), [0.3, 0.8, 0.8, 1]];
        };
        case 3.7: {
            _entries pushBack [LLSTRING(Plated), [0.3, 0.8, 0.8, 1]];
        };
        default {};
    }; 
};
