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

if (GVAR(showCyanosis) && _selectionN in [0,2,3]) then {
    private _spO2 = 0;

    if (alive _target) then {
        _spO2 = GET_SPO2(_target);
    };

    if (_spO2 <= GVAR(slightValue) || HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN)) then {
        private _cyanosisArr = switch (true) do {
            case (HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN));
            case (_spO2 <= GVAR(severeValue)): {
                [LLSTRING(CyanosisStatus_Severe), [0.16, 0.16, 1, 1]];
            };
            case (_spO2 <= GVAR(mildValue)): {
                [LLSTRING(CyanosisStatus_Mild), [0.16, 0.315, 1, 1]];
            };
            default {
                [LLSTRING(CyanosisStatus_Slight), [0.16, 0.47, 1, 1]];
            };
        };
        _entries pushBack _cyanosisArr;
    };
};

if (_target getVariable [QGVAR(pulseoximeter), false] && _selectionN in [2,3]) then {
    if((_target getVariable [QGVAR(PulseOximeter_Attached), [0,0]] select (_selectionN - 2)) > 0) then {
        _entries pushback [LLSTRING(Pulseoximeter_Desc_Short), [0.3, 0.8, 0.8, 1]];
    };
};

private _ptxEntry = [];

if (_selectionN isEqualTo 1) then {
    private _tensionhemothorax = false;
    if (!(GVAR(showPneumothorax_dupe))) then {
        if ((_target getVariable [QGVAR(hemopneumothorax), false]) || (_target getVariable [QGVAR(tensionpneumothorax), false])) then {
            _tensionhemothorax = true;
        };
    };

    if (_target getVariable [QGVAR(activeChestSeal), false]) then {
        _entries pushBack [LLSTRING(ChestSealApplied), [1,0.95,0,1]];
    };

    if (GVAR(PneumothoraxAlwaysVisible)) then {
        if ((_target getVariable [QGVAR(pneumothorax), 0] > 0) && !(_tensionhemothorax)) then {
            _ptxEntry pushback [LLSTRING(pneumothorax_mm), [1,1,1,1]];
        };
    } else {
        if (_target getVariable [QGVAR(deepPenetratingInjury), false]) then {
            _entries pushBack [LLSTRING(DeepPenetratingInjury), [1,0,0,1]];
        };
    };

    if (GVAR(TensionHemothoraxAlwaysVisible)) then {
        if (_target getVariable [QGVAR(hemopneumothorax), false]) then {
            _ptxEntry pushback [LLSTRING(hemopneumothorax_mm), [1,1,1,1]];
        };

        if (_target getVariable [QGVAR(tensionpneumothorax), false]) then {
            _ptxEntry pushback [LLSTRING(tensionpneumothorax_mm), [1,1,1,1]];
        };
    };
};

_target setVariable [QGVAR(gui_updateInjuryList_ptxEntries), _ptxEntry];
