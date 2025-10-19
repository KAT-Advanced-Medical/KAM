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

params ["_unit"];

if (
    !(GVAR(enable))
    || {_unit getVariable ["KAT_Occlusion_Exclusion", false]}
    || {(_unit getVariable ["KAT_DeteriorationPFH", false])}
) exitWith {};
if (_unit getVariable [QEGVAR(vitals,simpleMedical), false]) exitWith {};

[{
    params ["_unit"];
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _alive          = alive _unit;
        private _isUnconscious  = _unit getVariable ["ACE_isUnconscious", false];
        private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
        private _mitigation     = _unit getVariable [QGVAR(occlusionMitigation), [0.3, 0.3, 0.3]];
        private _pfhID = _unit getVariable ["KAT_DeteriorationPFH", false];
        if (!_alive || !(_pfhID)) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            _unit setVariable ["KAT_DeteriorationPFH", false, true];
        };
        if (_isUnconscious) then {
            {
                private _level = _forEachIndex;
                private _current = _x;
                if (_current <= 0) exitWith {};

                if (floor (random 100) < GVAR(deterioratingAirways_chance)) then {
                    _occlusionState set [_level, (_current + 1) min 10];
                };
            } forEach _occlusionState;
            {
                private _a = _x;
                private _b = _x + 1;

                private _occA = _occlusionState select _a;
                private _occB = _occlusionState select _b;

                private _mitA = _mitigation select _a;
                private _mitB = _mitigation select _b;
                private _downward = _occA > _occB;
                private _rate = 0.15 * (1 - ((_mitA + _mitB) / 2));
                if (!_downward) then { _rate = _rate * 0.5};
                private _delta = (_occA - _occB) * _rate;

                _occlusionState set [_a, (_occA - _delta) min 10 max 0];
                _occlusionState set [_b, (_occB + _delta) min 10 max 0];
            } forEach [0, 1];
            TRACE_1("occlusion oral-upper-lower directional diffusion", _occlusionState);
            _unit setVariable [QGVAR(occlusion), _occlusionState, true];
        } else {
            _unit call FUNC(handleAwakePuking);
            _unit setVariable ["KAT_DeteriorationPFH", false, true];
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

    }, 
    (GVAR(deterioratingAirways_interval) * random [0.8, 1, 1.3]), 
    [_unit]] call CBA_fnc_addPerFrameHandler;

    _unit setVariable ["KAT_DeteriorationPFH", true, true];

}, [_unit], GVAR(deterioratingAirways_interval)] call CBA_fnc_waitAndExecute;