#define DEBUG_MODE_FULL
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

private _jointArray = GET_JOINTS(_target);
private _hasInjury = false;
switch (_selectionN) do {
    case 4: {
        private _arr = _jointArray select 0;
        _hasInjury = ((_arr select 0) > 0) || ((_arr select 1) > 0);
    };
    case 5: {
        private _arr = _jointArray select 0;
        _hasInjury = ((_arr select 1) > 0) || ((_arr select 2) > 0);
    };
    case 6: {
        private _arr = _jointArray select 1;
        _hasInjury = ((_arr select 0) > 0) || ((_arr select 1) > 0);
    };
    case 7: {
        private _arr = _jointArray select 1;
        _hasInjury = ((_arr select 1) > 0) || ((_arr select 2) > 0);
    };
    case 8: {
        private _arr = _jointArray select 2;
        _hasInjury = ((_arr select 0) > 0) || ((_arr select 1) > 0);
    };
    case 9: {
        private _arr = _jointArray select 2;
        _hasInjury = ((_arr select 1) > 0) || ((_arr select 2) > 0);
    };
    case 10: {
        private _arr = _jointArray select 3;
        _hasInjury = ((_arr select 0) > 0) || ((_arr select 1) > 0);
    };
    case 11: {
        private _arr = _jointArray select 3;
        _hasInjury = ((_arr select 1) > 0) || ((_arr select 2) > 0);
    };
    default {};
};
private _pressureArray = GET_APPLIEDPRESSURE(_target);
if ((_pressureArray select _selectionN) > 0) then {
    _entries pushBack [LLSTRING(pressure_GUI), [0.1, 1, 1, 1]];
};

if (_hasInjury) then {
    _entries pushBack [LLSTRING(jointInjuryGUI), [1, 0, 0, 1]];
};
