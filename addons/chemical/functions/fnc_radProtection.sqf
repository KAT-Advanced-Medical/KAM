#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Returns a unit's external shielding multiplier (0..1, 1 = unshielded) for a
 * given radiation type. Each type's per-gear coefficients come from its profile
 * in GVAR(radProfiles); the rad_protectionFactor* settings are per-gear
 * effectiveness knobs (0 = gear does nothing, 1 = full profile protection).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radiation type id <STRING>
 *
 * Return Value:
 * Absorbed-dose multiplier <NUMBER>
 *
 * Example:
 * [player, "gamma"] call kat_chemical_fnc_radProtection;
 *
 * Public: No
 */

params ["_unit", "_type"];

private _profile = GVAR(radProfiles) getOrDefault [_type, [0, 0, 0, 1, [1, 1, 1, 1]]];
(_profile param [4, [1, 1, 1, 1]]) params ["_maskF", "_cbrnF", "_radF", "_vehF"];

private _factor = 1;

private _fnc_apply = {
    params ["_gearFactor", "_eff"];
    _factor = _factor * (1 - ((1 - _gearFactor) * _eff));
};

if ([_unit] call FUNC(hasGasMaskON)) then {
    [_maskF, GVAR(rad_protectionFactorMask)] call _fnc_apply;
};

if ([_unit] call FUNC(hasCBRNProtection)) then {
    [_cbrnF, GVAR(rad_protectionFactorCBRN)] call _fnc_apply;
};

private _radList = missionNamespace getVariable [QGVAR(availRadProtectionList), []];
if ((_radList isNotEqualTo []) && {uniform _unit != ""} && {(uniform _unit) in _radList}) then {
    [_radF, GVAR(rad_protectionFactorRadGear)] call _fnc_apply;
};

if (!isNull objectParent _unit) then {
    [_vehF, GVAR(rad_protectionFactorVehicle)] call _fnc_apply;
};

_factor
