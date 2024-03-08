#include "..\script_component.hpp"
/*
 * Author: Blue
 * Updates blood pressure change.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Systolic BP change <INT>
 * 2: Diastolic BP change <INT>
 * 3: Effect identifier <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, -12, -12, "ptx_tension"] call kat_circulation_fnc_updateBloodPressureChange
 *
 * Public: No
 */

params ["_unit", "_systolicChange", "_diastolicChange", "_id", ["_overwrite", false]];

private _BPChange = _unit getVariable [VAR_BLOODPRESSURE_CHANGE, []];

private _arrRow = _BPChange findif {(_x select 2) isEqualTo _id};

if (_arrRow != -1) exitWith {
    if (_systolicChange isEqualTo 0 && _diastolicChange isEqualTo 0) then {
        _BPChange deleteAt _arrRow;
    } else {
        if (_overwrite) then {
            _BPChange set [_arrRow, [_systolicChange, _diastolicChange, _id]];
        } else {
            _BPChange set [_arrRow, [((_BPChange select _arrRow) select 0) + _systolicChange, ((_BPChange select _arrRow) select 0) + _diastolicChange, _id]];
        };
    };
    _unit setVariable [VAR_BLOODPRESSURE_CHANGE, _BPChange, true];
};

if (_systolicChange isEqualTo 0 && _diastolicChange isEqualTo 0) exitWith {};

_BPChange append [[_systolicChange, _diastolicChange, _id]];
_unit setVariable [VAR_BLOODPRESSURE_CHANGE, _BPChange, true];
