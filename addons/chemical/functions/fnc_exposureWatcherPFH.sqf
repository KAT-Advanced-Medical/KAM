#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Server-side per-frame handler that checks deadline variables on tracked
 * units and fires the corresponding delayed effects via target events.
 *
 * Locality-safe: target events go to the unit's current owner. Survives
 * locality transfer and JIP.
 *
 * Arguments:
 * 0: PFH args (unused) <ARRAY>
 * 1: PFH handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["", "_pfhHandle"];

private _now = CBA_missionTime;
private _toRemove = [];

{
    private _netId = _x;
    private _unit = _y;

    if (isNull _unit || {!alive _unit}) then {
        _toRemove pushBack _netId;
        continue;
    };

    private _hasPending = false;

    // Phosgene delayed pulmonary
    private _phosgeneDeadline = _unit getVariable [QGVAR(phosgeneDeadline_onset), 0];
    if (_phosgeneDeadline > 0) then {
        if (_now >= _phosgeneDeadline) then {
            [QGVAR(applyDelayedEffect), [_unit, "phosgenePulmonary"], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(phosgeneDeadline_onset), 0, true];
        } else {
            _hasPending = true;
        };
    };

    // Mustard eye injury
    private _mustardEyeDeadline = _unit getVariable [QGVAR(mustardDeadline_eye), 0];
    if (_mustardEyeDeadline > 0) then {
        if (_now >= _mustardEyeDeadline) then {
            [QGVAR(applyDelayedEffect), [_unit, "mustardEye"], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(mustardDeadline_eye), 0, true];
        } else {
            _hasPending = true;
        };
    };

    // Mustard burn
    private _mustardBurnDeadline = _unit getVariable [QGVAR(mustardDeadline_burn), 0];
    if (_mustardBurnDeadline > 0) then {
        if (_now >= _mustardBurnDeadline) then {
            [QGVAR(applyDelayedEffect), [_unit, "mustardBurn"], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(mustardDeadline_burn), 0, true];
        } else {
            _hasPending = true;
        };
    };

    // Nerve agent symptom chain (gated on nerveAgentExposure still set so ATNAA aborts)
    private _nerveExposed = (_unit getVariable [QGVAR(nerveAgentExposure), ""]) != "";

    private _vomitDeadline = _unit getVariable [QGVAR(nerveDeadline_vomit), 0];
    if (_vomitDeadline > 0) then {
        if (_now >= _vomitDeadline) then {
            if (_nerveExposed) then {
                [QGVAR(applyDelayedEffect), [_unit, "vomit"], _unit] call CBA_fnc_targetEvent;
            };
            _unit setVariable [QGVAR(nerveDeadline_vomit), 0, true];
        } else {
            _hasPending = true;
        };
    };

    private _unconsciousDeadline = _unit getVariable [QGVAR(nerveDeadline_unconscious), 0];
    if (_unconsciousDeadline > 0) then {
        if (_now >= _unconsciousDeadline) then {
            if (_nerveExposed) then {
                [QGVAR(applyDelayedEffect), [_unit, "unconscious"], _unit] call CBA_fnc_targetEvent;
            };
            _unit setVariable [QGVAR(nerveDeadline_unconscious), 0, true];
        } else {
            _hasPending = true;
        };
    };

    private _cardiacDeadline = _unit getVariable [QGVAR(nerveDeadline_cardiac), 0];
    if (_cardiacDeadline > 0) then {
        if (_now >= _cardiacDeadline) then {
            if (_nerveExposed) then {
                [QGVAR(applyDelayedEffect), [_unit, "cardiac"], _unit] call CBA_fnc_targetEvent;
            };
            _unit setVariable [QGVAR(nerveDeadline_cardiac), 0, true];
        } else {
            _hasPending = true;
        };
    };

    private _radTier = _unit getVariable [QGVAR(radSicknessTier), 0];

    {
        _x params ["_var", "_effect", "_minTier"];
        private _deadline = _unit getVariable [_var, 0];
        if (_deadline > 0) then {
            if (_now >= _deadline) then {
                if (_radTier >= _minTier) then {
                    [QGVAR(applyDelayedEffect), [_unit, _effect], _unit] call CBA_fnc_targetEvent;
                };
                _unit setVariable [_var, -1, true];
            } else {
                _hasPending = true;
            };
        };
    } forEach [
        [QGVAR(radDeadline_prodromal), "radProdromal", 1],
        [QGVAR(radDeadline_hema),      "radHema",      2],
        [QGVAR(radDeadline_gi),        "radGI",        3],
        [QGVAR(radDeadline_cns),       "radCNS",       4],
        [QGVAR(radDeadline_cardiac),   "radCardiac",   4]
    ];

    if (!_hasPending) then {
        _toRemove pushBack _netId;
    };
} forEach GVAR(exposureWatcherUnits);

{
    GVAR(exposureWatcherUnits) deleteAt _x;
} forEach _toRemove;

if (count GVAR(exposureWatcherUnits) == 0) then {
    missionNamespace setVariable [QGVAR(exposureWatcherActive), false];
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};
