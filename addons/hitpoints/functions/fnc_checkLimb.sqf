#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks for internal bleeding on a bodypart
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_hitpoints_checkLimb
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];
TRACE_1("checkLimb1",_bodyPart);
private _wounds = GET_OPEN_WOUNDS(_patient);
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
    private _sizeLabel = switch (true) do {
        case (_internalBleedAmount < 0.1): { localize LSTRING(InternalBleeding_Minor) };
        case (_internalBleedAmount < 3): { localize LSTRING(InternalBleeding_Medium) };
        case (_internalBleedAmount < 6): { localize LSTRING(InternalBleeding_Large) };
        default {};
    };
} else {
    private _sizeLabel = localize LSTRING(InternalBleeding_None);
};


private _fixedBodyPart = format [localize ELSTRING(gui,InternalBleeding), _sizeLabel, _fixedBodyPart];
TRACE_1("checkLimb3",_sizeLabel);
    private _output = format [localize LSTRING(InternalBleeding), _sizeLabel, _fixedBodyPart];

    [_patient, "quick_view", LSTRING(InternalBleedingLog), [[_medic] call ACEFUNC(common,getName), _sizeLabel,  _fixedBodyPart]] call ACEFUNC(medical_treatment,addToLog);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);