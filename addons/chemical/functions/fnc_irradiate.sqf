#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Per-unit radiation exposure handler. Routes each radiation type's incident
 * dose-rate (after type-specific shielding) into whole-body absorbed dose,
 * local skin/limb dose (beta burns), inhaled internal burden, and surface
 * contamination, then re-evaluates radiation sickness.
 *
 * Runs local to the unit's owner (fired via QGVAR(irradiate) target event).
 * The geiger reading (radDoseRate) is owned by fnc_radManagerPFH, not here.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Incident dose-rates by type [alpha,beta,gamma,neutron] (Gy/h) <ARRAY>
 * 2: Source logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_ratesByType", "_radLogic"];

if (!GVAR(rad_enable)) exitWith {};

if (!local _unit) exitWith {
    TRACE_1("rad unit not local",_unit);
};

if (getNumber (configOf _unit >> "isPlayableLogic") == 1 || {!(_unit isKindOf "CAManBase")}) exitWith {
    TRACE_1("rad unit is virtual or not a man",_unit);
};

if !(isDamageAllowed _unit && {_unit getVariable [QACEGVAR(medical,allowDamage), true]}) exitWith {
    TRACE_1("rad unit is invulnerable",_unit);
};

private _hours = RAD_MANAGER_PFH_DELAY / 3600;
private _hasMask = [_unit] call FUNC(hasGasMaskON);
private _kiActive = CBA_missionTime < (_unit getVariable [QGVAR(radProtectiveWindow), 0]);
private _veryClose = (_radLogic distance _unit) < GVAR(rad_localProximity);
private _selfContamSource = (_radLogic getVariable [QGVAR(contamSourceOwner), objNull]) isEqualTo _unit;

private _wbAdd = 0;
private _internalAdd = 0;
private _contamAdd = 0;
private _skinByPart = [0, 0, 0, 0, 0, 0];

{
    private _type = _x;
    private _rate = _ratesByType select _forEachIndex;
    if (_rate <= 0) then { continue };

    (GVAR(radProfiles) get _type) params ["_wbW", "_skinW", "_inhaleW", "_qf"];
    private _ext = _rate * ([_unit, _type] call FUNC(radProtection));

    _wbAdd = _wbAdd + (_ext * _wbW * _qf);

    private _skin = _ext * _skinW;
    if (_skin > 0) then {
        if (_veryClose) then {
            _skinByPart set [2, (_skinByPart select 2) + (_skin * 0.5)];
            _skinByPart set [3, (_skinByPart select 3) + (_skin * 0.5)];
        } else {
            _skinByPart = _skinByPart apply { _x + (_skin / 6) };
        };
    };

    if (!_hasMask && {_inhaleW > 0}) then {
        private _inhale = _rate * _inhaleW * GVAR(rad_inhalationFactor);
        if (_kiActive) then { _inhale = _inhale * GVAR(rad_kiFactor); };
        _internalAdd = _internalAdd + _inhale;
    };

    if (_type != "neutron" && {!_selfContamSource}) then {
        _contamAdd = _contamAdd + _rate;
    };
} forEach RAD_TYPES;

if (_wbAdd > 0) then {
    private _add = _wbAdd * _hours;
    _unit setVariable [QGVAR(radDoseWB), (_unit getVariable [QGVAR(radDoseWB), 0]) + _add, true];
    _unit setVariable [QGVAR(radSeverity), (_unit getVariable [QGVAR(radSeverity), 0]) + _add, true];
};

private _limb = _unit getVariable [QGVAR(radDoseLimb), [0, 0, 0, 0, 0, 0]];
private _thr = GVAR(rad_skinBurnThreshold);
private _parts = RAD_BODY_PARTS;
{
    private _new = (_limb select _forEachIndex) + ((_skinByPart select _forEachIndex) * _hours);
    if (_new >= _thr) then {
        [_unit, 0.1 + random 0.3, _parts select _forEachIndex, "KAT_radiationBurn", _unit] call ACEFUNC(medical,addDamageToUnit);
        _new = _new - _thr;
    };
    _limb set [_forEachIndex, _new];
} forEach _limb;
_unit setVariable [QGVAR(radDoseLimb), _limb, true];

if (_internalAdd > 0) then {
    _unit setVariable [QGVAR(radInternalBurden), (_unit getVariable [QGVAR(radInternalBurden), 0]) + (_internalAdd * _hours), true];
    [_unit] call FUNC(startRadInternalTick);
};

if (_contamAdd > 0) then {
    private _contam = ((_unit getVariable [QGVAR(radExternalContam), 0]) + (_contamAdd * GVAR(rad_contaminationDeposition) * _hours)) min 1;
    _unit setVariable [QGVAR(radExternalContam), _contam, true];
    [_unit] call FUNC(startRadContaminationTick);
};

[_unit] call FUNC(evaluateRadDose);
