#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * handels airway degredation
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *    0: Engine damage <NUMBER>
 *    1: Body part <STRING>
 *    2: Real damage <NUMBER>
 * 2: Damage type (unused) <STRING>
 * 3: Ammo (unused) <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_hitpoints_fnc_woundsHandlerPelvicHit
 *
 * Public: No
 */

params ["_unit", "_level"];

// Early exit if disabled or excluded
if (!(GVAR(enable)) || {_unit getVariable ["KAT_Occlusion_Exclusion", false]}) exitWith {};

[{
    params ["_unit", "_level"];

    private _occlusionState = (_unit getVariable [QGVAR(occlusion), [0, 0, 0]]) select _level;
    if (_occlusionState <= 0) exitWith {};

    // Try to deteriorate at set interval
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit", "_level"];

        private _isUnconscious   = _unit getVariable ["ACE_isUnconscious", false];
        private _alive           = alive _unit;
        private _occlusionState  = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];

        // Exit PFH if dead or occlusion already cleared
        if (!_alive || {(_occlusionState select _level) == 0}) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            _unit setVariable ["kat_occlusion_PFH", nil];
        };

        if (_isUnconscious) then {
            if (floor (random 100) < GVAR(deterioratingAirways_chance)) then {
                private _occlusionTarget = (_occlusionState select _level) + selectRandom [1, 2, 3];

                if (_occlusionTarget > 10) then {
                    // Spread to neighbors if maxed out
                    private _mitigation = _unit getVariable [QGVAR(occlusionMitigation), [0, 0, 0]];
                    private _spreadTargets = switch (_level) do {
                        case 0: {[1, 2]};
                        case 2: {[0, 1]};
                        default {[0, 2]};
                    };
                    {
                        private _idx = _x;
                        _occlusionState set [_idx, (((_occlusionState select _idx) + selectRandom [1, 2, 3]) * (_mitigation select _idx))];
                    } forEach _spreadTargets;
                };
                _occlusionState set [_level, (_occlusionTarget min 15)];
                TRACE_1("occlusion unconscious", _occlusionState);
                _unit setVariable [QGVAR(occlusion), _occlusionState, true];
            };
        } else {
            _unit call FUNC(handleAwakePuking);
        };
    }, 
    (GVAR(deterioratingAirways_interval) * random [0.8, 1, 1.3]), 
    [_unit, _level]] call CBA_fnc_addPerFrameHandler;

}, [_unit, _level], GVAR(deterioratingAirways_interval)] call CBA_fnc_waitAndExecute;