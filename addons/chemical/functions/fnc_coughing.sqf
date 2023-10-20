#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_coughing;
 *
 * Public: No
*/
params ["_unit"];

[
    {
        params["_unit"];
        _unit getVariable [QGVAR(airPoisoning), false]
    },
    {
        params["_unit"];
        private _lastcought = CBA_missionTime;
        [
            {
                params ["_args", "_pfhID"];
                _args params ["_unit", "_lastcought"];
                if (_unit getVariable ["ACE_isUnconscious", false] || !(alive _unit) || !(_unit getVariable [QGVAR(airPoisoning), false])) exitWith {
                    [_pfhID] call CBA_fnc_removePerFrameHandler;
                    [_unit] call FUNC(coughing);
                };
                private _nextcought = random [20,50,80];
                [
                    {
                        params["_unit","_lastcought","_nextcought"];
                        (CBA_missionTime - (_unit getVariable [QGVAR(lastCought), 0])) > _nextcought
                    },
                    {
                        params["_unit"];
                        if (_unit getVariable [QGVAR(airPoisoning),false]) then {
                            _unit say3D QGVAR(cough_1);
                            addCamShake [3, 4, 0];

                            _unit setVariable [QGVAR(lastCought), CBA_missionTime, true];

                            private _effect = ppEffectCreate ["ChromAberration",2005];
                            KAT_PAIN_EFFECT = _effect;
                            _unit setVariable [QGVAR(painEffect), KAT_PAIN_EFFECT, true];
                            KAT_PAIN_EFFECT ppEffectAdjust [0, 0, false];
                            KAT_PAIN_EFFECT ppEffectCommit 0;
                            KAT_PAIN_EFFECT ppEffectEnable true;
                            private _intensity = linearConversion [0, 1, 0.5, 0, 0.06, true];
                            private _initialAdjust = [_intensity, _intensity, true];
                            private _delayedAdjust = [_intensity * 0.15, _intensity * 0.15, true];
                            KAT_PAIN_EFFECT ppEffectAdjust _initialAdjust;
                            KAT_PAIN_EFFECT ppEffectCommit 0.3;

                            [{
                                params ["_adjust"];
                                KAT_PAIN_EFFECT ppEffectAdjust _adjust;
                                KAT_PAIN_EFFECT ppEffectCommit 0.7;
                            }, [_delayedAdjust], 3] call CBA_fnc_waitAndExecute;
                        };
                    },
                [_unit,_lastcought,_nextcought]] call CBA_fnc_waitUntilAndExecute;
            }, 1, [_unit, _lastcought]] call CBA_fnc_addPerFrameHandler;
    }, [_unit]] call CBA_fnc_waitUntilAndExecute;
