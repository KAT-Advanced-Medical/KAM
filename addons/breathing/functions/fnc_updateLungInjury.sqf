#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Advances lung injury towards its target, then resolves it over time. Called once per
 * vitals cycle from kat_vitals_fnc_handleUnitVitals, which already runs on the unit's owner
 * with a clamped delta and a throttled sync flag - so this needs no PerFrameHandler of its
 * own and survives locality transfer, JIP and save/load for free.
 *
 * Severity is held once it peaks - damaged alveoli do not repair themselves on a mission
 * timescale - so only dexamethasone resolves it. Trivial exposure below the symptomatic
 * threshold still clears on its own.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Time since last update <NUMBER>
 * 2: Sync values? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1, false] call kat_breathing_fnc_updateLungInjury;
 *
 * Public: No
 */

params ["_unit", "_deltaT", "_syncValues"];

private _current = _unit getVariable [QGVAR(lungInjury), 0];
private _target = _unit getVariable [QGVAR(lungInjuryTarget), 0];

// Overwhelmingly the common case - keep it cheap, this runs for every unit every cycle
if (_current <= 0 && {_target <= 0}) exitWith {};

private _new = _current;

// Decay runs unconditionally so an existing injury still resolves if the feature is switched
// off mid-mission; progression does not, or a casualty already ramping would keep getting worse after it was disabled.
if (_current < _target && {GVAR(lungInjury_enable)}) then {
    _new = (_current + (_deltaT / (GVAR(lungInjury_rampTime) max 1))) min _target;
} else {
    private _rate = 0;

    if (CBA_missionTime < (_unit getVariable [QGVAR(lungInjuryDexUntil), 0])) then {
        _rate = (1 / (GVAR(lungInjury_recoveryTime) max 1)) * GVAR(lungInjury_dexRecoveryMult);
    } else {
        // Trivial exposure still clears itself. Without this, anyone who ever brushed the edge of a cloud would carry a permanent fraction of a percent of lung injury forever.
        if (_current < LUNG_INJURY_SYMPTOMATIC_MIN) then {
            _rate = 1 / (GVAR(lungInjury_recoveryTime) max 1);
        };
    };

    if (_rate > 0) then {
        _new = (_current - (_rate * _deltaT)) max 0;

        // Target follows the injury down, otherwise a later minor exposure would snap severitystraight back to the old high-water mark.
        _target = _new;
    } else {
        private _progression = _unit getVariable [QGVAR(lungInjuryProgression), 0];

        if (_progression > 0 && {GVAR(lungInjury_enable)} && {_current >= (_unit getVariable [QGVAR(lungInjuryProgressiveMin), LUNG_INJURY_PROGRESSIVE_MIN])}) then {
            // Supplemental oxygen slows the process without stopping it - a bridge, not a cure.
            if ((_unit getVariable [QGVAR(oxygenMaskActive), false]) || {_unit getVariable [QGVAR(oxygenTankConnected), false]}) then {
                _progression = _progression * 0.5;
            };

            _new = (_current + (_progression * _deltaT)) min 1;

            // Target tracks upward so the ramp branch cannot re-engage against it.
            _target = _new;
        };
    };
};

if (_new <= 0 && {_target <= 0}) exitWith {
    _unit setVariable [QGVAR(lungInjury), 0, true];
    _unit setVariable [QGVAR(lungInjuryTarget), 0, true];
    _unit setVariable [QGVAR(lungInjuryCause), "", true];
    _unit setVariable [QGVAR(lungInjuryDexUntil), 0, true];
    _unit setVariable [QGVAR(lungInjuryProgression), 0, true];
    _unit setVariable [QGVAR(lungInjuryProgressiveMin), LUNG_INJURY_PROGRESSIVE_MIN, true];
    _unit setVariable [QGVAR(lungInjuryNextCough), 0, true];

    _unit setVariable [QEGVAR(chemical,lungDose), 0, true];
    _unit setVariable [QEGVAR(chemical,lungOnsetFired), false, true];
};

private _sync = _syncValues || {GET_LUNG_INJURY_BAND(_current) != GET_LUNG_INJURY_BAND(_new)};

_unit setVariable [QGVAR(lungInjury), _new, _sync];
_unit setVariable [QGVAR(lungInjuryTarget), _target, _sync];

if (_new >= LUNG_INJURY_SYMPTOMATIC_MIN && {alive _unit} && {!(_unit getVariable [QACEGVAR(medical,inCardiacArrest), false])}) then {
    if (CBA_missionTime >= (_unit getVariable [QGVAR(lungInjuryNextCough), 0])) then {
        _unit setVariable [QGVAR(lungInjuryNextCough), CBA_missionTime + LUNG_INJURY_COUGH_INTERVAL, true];

        private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];

        if (_soundTargets isNotEqualTo []) then {
            [QGVAR(playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
        };
    };
};