#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Modified: Blue
 * Calculate the blood pressure of a unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * 0: BloodPressure Low <NUMBER>
 * 1: BloodPressure High <NUMBER>
 *
 * Example:
 * [player] call ace_medical_status_fnc_getBloodPressure
 *
 * Public: No
 */

// Value is taken because with cardic output and resistance at default values, it will put blood pressure High at 120.
#define MODIFIER_BP_HIGH    9.4736842

// Value is taken because with cardic output and resistance at default values, it will put blood pressure Low at 80.
#define MODIFIER_BP_LOW     6.3157894

params ["_unit"];

private _cardiacOutput = [_unit] call ACEFUNC(medical_status,getCardiacOutput);
private _resistance = _unit getVariable [VAR_PERIPH_RES, DEFAULT_PERIPH_RES];
private _bloodPressure = _cardiacOutput * _resistance;

private _BPChange = _unit getVariable [VAR_BLOODPRESSURE_CHANGE, []];

private _changeSystolic = 0;
private _changeDiastolic = 0;

if (count _BPChange > 0) then {
    {
        _changeSystolic = _changeSystolic + (_x select 0);
        _changeDiastolic = _changeDiastolic + (_x select 1);
    } forEach _BPChange;
};

private _systolic = _bloodPressure * MODIFIER_BP_LOW;
private _diastolic = _bloodPressure * MODIFIER_BP_HIGH;

[(round(_systolic + _changeSystolic * (_systolic / 80)) max 0), (round(_diastolic + _changeDiastolic * (_diastolic / 120)) max 0)]
