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
if (!(GVAR(enable)) || (_unit getVariable ["KAT_Occlusion_Exclusion", false])) exitWith {};

[{
    params ["_unit", "_level"];

    private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]] select _level; // Default: [0, 0] for both sides
    if (_occlusionState > 0) then {
        // Try to deteriorate at set interval
        [{
            params ["_args", "_idPFH"];
            _args params ["_unit", "_level"];
            private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
                if ((_occlusionState select _level) > 0) then {
                    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
                    private _alive = alive _unit;
                    if !(_alive || ((_occlusionState select _level) == 0)) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                        _unit setVariable ["kat_occlusion_PFH", nil];
                    };
                    if (_isUnconscious) then {
                        if (floor (random 100) < GVAR(deterioratingAirways_chance)) then {
                        _occlusionTarget = ((_occlusionState select _level) + 1);
                        if (_occlusionTarget > 6) then {
                            _occlusionState set [_level - 1 max 0, ((_occlusionState select (_level- 1 max 0)) + 1)];
                            _occlusionState set [_level + 1 min 2, ((_occlusionState select (_level + 1 min 2)) + 1)];
                        };
                        if (floor (random 100) < 25) then {
                            _occlusionState set [selectRandom [((_level + 1) min 2), ((_level - 1) max 0)], (_occlusionTarget min 6)];
                        };
                        _occlusionState set [_level, _occlusionTarget];
                        _unit setVariable [QGVAR(occlusion), _occlusionState, true]; };
                    } else {
                        _occlusionTarget = ((_occlusionState select _level) - 0.5);
                        _occlusionState set [0, (_occlusionTarget min 6)];
                        _occlusionState set [1, (_occlusionTarget min 6)];
                        _occlusionState set [2, (_occlusionTarget min 6)];
                        _unit setVariable [QGVAR(occlusion), _occlusionState, true];

                    };
                };
        }, (GVAR(deterioratingAirways_interval) * random [0.8, 1, 1.3]), [_unit, _level]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _level], GVAR(deterioratingAirways_interval)] call CBA_fnc_waitAndExecute;