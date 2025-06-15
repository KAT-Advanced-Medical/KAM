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
if ((_unit getVariable ["kat_pukeActive_PFH", false]) || !(GVAR(enable)) || (_unit getVariable ["KAT_Occlusion_Exclusion", false])) exitWith {};
_unit setVariable ["kat_occlusion_PFH", true];

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
                    if !(alive _unit) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                        _unit setVariable ["kat_occlusion_PFH", nil];
                    };
                    private _occlusionMitigation = _unit getVariable [QGVAR(occlusionMitigation), [false, false, false]] select _level;
                    if ((floor (random 100) < GVAR(deterioratingAirway_chance)) && !(_occlusionMitigation)) then {
                        _occlusionTarget = ((_occlusionState select _level) + 1) min 6;
                        if (_occlusionTarget > 6) then {
                            _occlusionState set [_level - 1 max 0, _occlusionTarget];
                            _occlusionState set [_level + 1 min 2, _occlusionTarget];
                        };
                        if (floor (random 100) < 25) then {
                            _occlusionState set [selectRandom [((_level + 1) min 2), ((_level - 1) max 0)], _occlusionTarget];
                        };
                        _occlusionState set [_level, _occlusionTarget];
                        _unit setVariable [QGVAR(occlusion), _occlusionState, true];
                    };
                };
        }, (GVAR(deterioratingOcclusion_interval) * random [0.6, 1, 1.7]), [_unit, _level]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _level], GVAR(deterioratingOcclusion_interval)] call CBA_fnc_waitAndExecute;