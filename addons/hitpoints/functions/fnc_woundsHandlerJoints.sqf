#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Called when a unit is damaged.
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
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_breathing_fnc_woundsHandlerJoints
 *
 * Public: No
 */

params ["_unit", "_allDamages", "_damageType"];

{
    _x params ["_damage", "_bodyPart"];

    private _fixedBodyPart = toLower _bodyPart;

    if !(GVAR(CatastrophicEnable) && !(_fixedBodyPart in ["head", "neck", "chest", "body"])) then {
        TRACE_1("NotEnable",_fixedBodyPart);
    } else {
        private _chanceIncrease = 0;
        if (GVAR(JointDamageThreshold_TakenDamage)) then {
            _chanceIncrease = linearConversion [GVAR(JointDamageThreshold), 3, _damage, 0, 30, true];
            TRACE_1("chanceIncrease",_chanceIncrease);
        };
        TRACE_3("WHJoints1",_unit,_chance,_chanceIncrease);

        if (floor (random 100) < (GVAR(JointChance) + _chanceIncrease)) then {
            private _partIndex = ALL_BODY_PARTS find _fixedBodyPart;
            private _jointArray = GET_JOINTS(_unit);
            private _jointGroupIndex = switch (true) do {
                case (_partIndex in [4, 5]): { 0 };
                case (_partIndex in [6, 7]): { 1 };
                case (_partIndex in [8, 9]): { 2 };
                case (_partIndex in [10, 11]): { 3 };
                default { -1 };
            };
            TRACE_2("WHJoints3",_partIndex,_jointGroupIndex);

            if (_jointGroupIndex >= 0) then {
                private _limbJointStatus = _jointArray select _jointGroupIndex;
                private _jointNumber = selectRandom [0,1,2];
                private _jointInjury = _limbJointStatus select _jointNumber;
                if (_jointInjury == 0) then {
                    [_unit, 0.8] call ACEFUNC(medical_status,adjustPainLevel);

                    private _damageNormalized = linearConversion [0, 3, _damage, 0, 1, true];
                    private _minChance3 = 0.05;
                    private _minChance2 = 0.35;
                    private _remaining = 1 - (_minChance3 + _minChance2);
                    private _dynamicW1 = (1 - _damageNormalized);
                    private _dynamicW2 = 0.5;
                    private _dynamicW3 = _damageNormalized;
                    private _totalDynamicW = _dynamicW1 + _dynamicW2 + _dynamicW3;
                    private _finalW1 = _remaining * (_dynamicW1 / _totalDynamicW);
                    private _finalW2 = _remaining * (_dynamicW2 / _totalDynamicW);
                    private _finalW3 = _remaining * (_dynamicW3 / _totalDynamicW);
                    _finalW2 = _finalW2 + _minChance2;
                    _finalW3 = _finalW3 + _minChance3;
                    private _jointInjury = selectRandomWeighted [1, _finalW1, 2, _finalW2, 3, _finalW3];

                    _limbJointStatus set [_jointNumber, _jointInjury];
                    _jointArray set [_jointGroupIndex, _limbJointStatus];
                    _unit setVariable [VAR_JOINTS, _jointArray, true];
                    [_unit] call EFUNC(misc,updateDamageEffects);
                    TRACE_3("WHJoints4",_limbJointStatus,_jointInjury,_jointNumber);
                    if ((random 100) > 20) exitWith {_this};
                };
            };
        };
    };
} forEach _allDamages;

_this // Final return