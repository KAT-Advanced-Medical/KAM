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

private _wounds = GET_OPEN_WOUNDS(_target);
private _bodyPart = ALL_BODY_PARTS select _selectionN;
private _partWounds = _wounds getOrDefault [_bodyPart, []];
private _internalBleedAmount = 0;

{
    _x params ["_woundClassID", "_amountOf"];
    private _classIndex = _woundClassID / 10;
    private _category   = _woundClassID % 10;
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
    TRACE_1("checkLimb4",_className);
    if (_className isEqualTo "InternalBleeding") then {
        _internalBleedAmount = _internalBleedAmount + _category;
    };
} forEach _partWounds;
private _sizeLabel = "";
TRACE_1("checkLimb2",_internalBleedAmount);
if (_internalBleedAmount > 0) then {
    _sizeLabel = switch (true) do {
        case (_internalBleedAmount < 1): { localize LSTRING(InternalBleeding_Minor) };
        case (_internalBleedAmount < 5): { localize LSTRING(InternalBleeding_Medium) };
        case (_internalBleedAmount < 10): { localize LSTRING(InternalBleeding_Large) };
        default {};
    };
    _entries pushBack [_sizeLabel, [0.8, 0.76, 0.9, 1]];
};
