#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Per-gas dispatcher. Validates the unit, checks protection (mask only or
 * full CBRN depending on the gas), tracks last-cloud gas-id for M8 paper
 * and the chemical detector, emits smell hints, then delegates to the
 * gas-specific effect function from the registry.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Gas level (legacy KAT_toxicLvL int) <NUMBER>
 * 2: Infected source object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_gasLevel", "_infectedObject"];

if (!local _unit) exitWith {
    TRACE_1("unit is null or not local",_unit);
};

if (getNumber (configOf _unit >> "isPlayableLogic") == 1 || {!(_unit isKindOf "CAManBase")}) exitWith {
    TRACE_1("unit is virtual or not a man",_unit);
};

if !(isDamageAllowed _unit && {_unit getVariable [QACEGVAR(medical,allowDamage), true]}) exitWith {
    TRACE_1("unit is invulnerable",_unit);
};

private _gasId = (GVAR(toxicLvLToId) getOrDefault [_gasLevel, "chlorine"]);
private _gasData = GVAR(gasRegistry) get _gasId;

// Track the gas-id and timestamp for the chemical detector and M8 paper. This
// happens BEFORE the protection check so even fully-protected units have
// detectable contamination on their gear (real M8 paper detects surface
// contamination regardless of whether the wearer is symptomatic).
_unit setVariable [QGVAR(currentCloudGasId), _gasId, true];
_unit setVariable [QGVAR(lastCloudExposure), CBA_missionTime, true];

// Protection check
private _hasMask = [_unit] call FUNC(hasGasMaskON);
private _maskOk  = _hasMask && {_unit getVariable [QGVAR(gasmask_durability), 10] > 0};

if (_gasData get "requiresCBRN" && _maskOk && {[_unit] call FUNC(hasCBRNProtection)}) exitWith {
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};

if (!(_gasData get "requiresCBRN") && _maskOk) exitWith {
    TRACE_1("unit has gas mask",_unit);
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};
// Eyes still exposed to CS gas through oxygen mask, but other choking
// agents are blocked when the airway is sealed.
if (!(_gasData get "requiresCBRN") && _gasId != "cs" && {_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]}) exitWith {
    TRACE_1("unit has oxygen mask",_unit);
};

// Smell hint (one-shot per gas per unit, local-only)
[_unit, _gasData] call FUNC(emitSmellHint);

// Dispatch
[_unit, _infectedObject, _gasData] call (_gasData get "effectFunc");
