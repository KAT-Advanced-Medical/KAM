#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Maps a unit's accumulated whole-body dose to an Acute Radiation Syndrome
 * (ARS) severity tier, sets the marrow/immune suppression factors for that
 * tier, and (when the tier rises) schedules the staged sickness chain.
 *
 * Tiers: 0 none, 1 mild, 2 moderate (hematopoietic), 3 severe (GI),
 *        4 lethal (neurovascular/CNS).
 *
 * Idempotent per tier: a chain is only (re)scheduled when the tier increases,
 * so this is safe to call every exposure tick.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

private _severity = _unit getVariable [QGVAR(radSeverity), 0];

private _tier = switch (true) do {
    case (_severity >= GVAR(rad_doseThreshold_lethal)):   {4};
    case (_severity >= GVAR(rad_doseThreshold_severe)):   {3};
    case (_severity >= GVAR(rad_doseThreshold_moderate)): {2};
    case (_severity >= GVAR(rad_doseThreshold_mild)):     {1};
    default {0};
};

private _currentTier = _unit getVariable [QGVAR(radSicknessTier), 0];

private _suppression = [1, 0.85, 0.6, 0.35, 0.1] select _tier;
_unit setVariable [QGVAR(radMarrowFactor), _suppression, true];
_unit setVariable [QGVAR(radImmuneFactor), _suppression, true];

_unit setVariable [QGVAR(radSicknessTier), _tier, true];

if (_tier >= 1) then {
    [_unit] call FUNC(startRadPhysiologyTick);
};

if (_tier <= _currentTier) exitWith {};

private _scale = [1, 1, 0.7, 0.45, 0.2] select _tier;

[_unit, _tier, _scale] call FUNC(scheduleRadSicknessChain);
