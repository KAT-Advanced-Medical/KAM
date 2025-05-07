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
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_breathing_fnc_woundsHandlerEviscerationHit
 *
 * Public: No
 */

params ["_unit", "_allDamages"];
(_allDamages select 0) params ["_engineDamage", "_bodyPart"]; // selection-specific

if !(GVAR(CatastrophicEnable) && _bodyPart == "body") exitWith {
    TRACE_1("NotEnable",_bodyPart);
    _this};
if (_engineDamage < GVAR(EviscerationDamageThreshold)) exitWith {
    TRACE_1("NotEnoughDamage",_engineDamage);
    _this};

private _chanceIncrease = 0;
if (GVAR(EviscerationDamageThreshold_TakenDamage)) then {
    _chanceIncrease = linearConversion [GVAR(EviscerationDamageThreshold), 3, _engineDamage, 0, 30, true];
    TRACE_1("chanceIncrease",_chanceIncrease);
};
private _openWounds = GET_OPEN_WOUNDS(_unit);

private _fnc_create_Evisceration = {
        private _existingWounds = _openWounds getOrDefault [_bodyPart, [], true];
        private _bodyPartDamage = GET_BODYPART_DAMAGE(_unit);
        private _woundTypeToAdd = "Evisceration";
        TRACE_5("create_Evisceration1",_bodyPart,_openWounds,_existingWounds,_bodyPartDamage,_woundTypeToAdd);
        private _woundClassIDToAdd = ACEGVAR(medical_damage,woundClassNames) find _woundTypeToAdd;
        _bodyPartDamage set [3, (_bodyPartDamage select 3) + _woundDamage];
         _unit setVariable [VAR_BODYPART_DAMAGE, _bodyPartDamage, true];
        private _woundDamage = 1;
        private _injuryBleedingRate = random [0.02, 0.04, 0.07];
        private _bleedMultiplier = random [0.8, 1, 1.2];
        private _woundSize = 3;
        private _bleeding = _woundSize * _bleedMultiplier * _injuryBleedingRate;
        private _classComplex = 10 * _woundClassIDToAdd + _woundSize;
        [_unit] call EFUNC(misc,updateDamageEffects);

        _bodyPartDamage set [3, (_bodyPartDamage select 3) + _woundDamage];
         _unit setVariable [VAR_BODYPART_DAMAGE, _bodyPartDamage, true];
        // Create a new injury. Format [0:classComplex, 1:amountOf, 2:bleedingRate, 3:woundDamage]
        private _injury = [_classComplex, 1, _bleeding, _woundDamage];
        TRACE_1("adding new wound",_injury);
        _existingWounds pushBack _injury;
        _unit setVariable [VAR_OPEN_WOUNDS, _openWounds, true];
        _unit setVariable [VAR_BODYPART_DAMAGE, _bodyPartDamage, true];
    };
// Damage threshold passed & Evisceration given
if (floor (random 100) < (GVAR(EviscerationChance) + _chanceIncrease)) exitWith {
    private _eviscerationLevel = _unit getVariable [QGVAR(evisceration), 0];
    private _hasEvisceration = _eviscerationLevel > 0;
    private _initialEvisceration = _eviscerationLevel == 0;
    TRACE_3("chanceIncrease",_eviscerationLevel,_hasEvisceration,_initialEvisceration);
    switch (true) do {
        case (_hasEvisceration): {
            private _newEviscerationLevel = (_eviscerationLevel + 1) min 4;
            _unit setVariable [QGVAR(evisceration), _newEviscerationLevel, true];
            if (_newEviscerationLevel < 5) then {
                [_unit] call _fnc_create_Evisceration;
            };
        };
        case (_initialEvisceration): {
            [_unit, 0.9] call ACEFUNC(medical_status,adjustPainLevel);
            private _newEviscerationLevel = (_eviscerationLevel + 1) min 4;
            _unit setVariable [QGVAR(evisceration), _newEviscerationLevel, true];
            _unit setVariable [QGVAR(activeWoundPack), 0, true];
            [_unit] call _fnc_create_Evisceration;
            [_unit, _chanceIncrease] call FUNC(handleEviscerationDeterioration);
        };
    };

    _this // return
};

_this // return