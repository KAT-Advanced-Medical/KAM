#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut, PabstMirror
 * Adds a medication and it's effects
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Medication <STRING>
 * 2: Time in system for the adjustment to reach its peak <NUMBER>
 * 3: Duration the adjustment will have an effect <NUMBER>
 * 4: Heart Rate Adjust <NUMBER>
 * 5: Pain Suppress Adjust <NUMBER>
 * 6: Flow Adjust <NUMBER>
 * 7: Dose <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Morphine", 120, 60, -10, 0.8, -10, 1] call ace_medical_status_fnc_addMedicationAdjustment
 *
 * Public: No
 */
params [
    "_unit", "_medication",
    ["_timeToMaxEffect", 0],
    ["_maxTimeInSystem", 0],
    ["_hrAdjust", 0],
    ["_painAdjust", 0],
    ["_flowAdjust", 0],
    ["_dose", 0],
    ["_alphaFactor", 0],
    ["_opioidRelief", 0],
    ["_opioidEffect", 0],
    ["_opioidDepression", 0],
    ["_respiratoryRate", 0],
    ["_contractility", 0],
    ["_nauseaMult", 0],
    ["_sedation", "false"],
    ["_paralysis", "false"],
    ["_linear", "false"]
];
TRACE_8("addMedicationAdjustment",_unit,_medication,_timeToMaxEffect,_maxTimeInSystem,_hrAdjust,_painAdjust,_flowAdjust,_dose);

if (_maxTimeInSystem <= 0) exitWith { WARNING_1("bad value for _maxTimeInSystem - %1",_this); };
_timeToMaxEffect = _timeToMaxEffect max 1;


private _adjustments = _unit getVariable [VAR_MEDICATIONS, []];
_adjustments pushBack [_medication, CBA_missionTime, _timeToMaxEffect, _maxTimeInSystem, _hrAdjust, _painAdjust, _flowAdjust, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate, _contractility,_nauseaMult,_sedation,_paralysis,_linear];

_unit setVariable [VAR_MEDICATIONS, _adjustments, true];
