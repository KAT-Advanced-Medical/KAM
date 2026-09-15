#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Whether a unit is sheltered by a closed vehicle. Only a sheltered unit gets
 * vehicle shielding and is kept from inhaling particulates or picking up
 * surface contamination; open vehicles, static weapons, FFV seats, open turrets
 * and turned-out crew count as being on foot.
 *
 * A vehicle class counts as closed when its kat_chemical_radSealed config
 * value is 1, or (without that override) when it is not a static weapon and
 * its attenuationEffectType is set and not an "Open"/"SemiOpen" variant.
 * Per-class and per-turret results are cached in GVAR(radSealedCache).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Sheltered <BOOL>
 *
 * Example:
 * [player] call kat_chemical_fnc_isRadSheltered;
 *
 * Public: No
 */

params ["_unit"];

private _vehicle = objectParent _unit;

if (isNull _vehicle || {isTurnedOut _unit}) exitWith {false};

private _seat = (fullCrew _vehicle) select {(_x select 0) isEqualTo _unit};
if ((_seat param [0, []]) param [4, false]) exitWith {false};

private _type = typeOf _vehicle;

private _sealed = GVAR(radSealedCache) get _type;
if (isNil "_sealed") then {
    private _config = configOf _vehicle;
    _sealed = if (isNumber (_config >> QGVAR(radSealed))) then {
        getNumber (_config >> QGVAR(radSealed)) > 0
    } else {
        private _attenuation = toLowerANSI getText (_config >> "attenuationEffectType");
        !(_vehicle isKindOf "StaticWeapon") && {_attenuation != ""} && {!("open" in _attenuation)}
    };
    GVAR(radSealedCache) set [_type, _sealed];
};

if (!_sealed) exitWith {false};

private _turretPath = _vehicle unitTurret _unit;
if (_turretPath isEqualTo [] || {_turretPath isEqualTo [-1]}) exitWith {true};

private _turretKey = format ["%1|%2", _type, _turretPath];
private _turretClosed = GVAR(radSealedCache) get _turretKey;
if (isNil "_turretClosed") then {
    private _turretConfig = [_vehicle, _turretPath] call BIS_fnc_turretConfig;
    _turretClosed = getNumber (_turretConfig >> "disableSoundAttenuation") != 1;
    GVAR(radSealedCache) set [_turretKey, _turretClosed];
};

_turretClosed
