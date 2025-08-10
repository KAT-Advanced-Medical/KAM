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

private _fixedBodyPart = toLower _bodyPart;
if !(GVAR(CatastrophicEnable) && _fixedBodyPart == "body") exitWith {
    TRACE_1("NotEnable",_fixedBodyPart);
    _this};
if (_engineDamage < GVAR(EviscerationDamageThreshold)) exitWith {
    TRACE_1("NotEnoughDamage",_engineDamage);
    _this};

private _chanceIncrease = 0;
if (GVAR(EviscerationDamageThreshold_TakenDamage)) then {
    _chanceIncrease = linearConversion [GVAR(EviscerationDamageThreshold), 3, _engineDamage, 0, 30, true];
    TRACE_1("chanceIncrease",_chanceIncrease);
};
// Damage threshold passed & Evisceration given
if (floor (random 100) < (GVAR(EviscerationChance) + _chanceIncrease)) exitWith {
    private _eviscerationLevel = _unit getVariable [QGVAR(evisceration), 0];
    private _hasEvisceration = _eviscerationLevel > 0;
    private _initialEvisceration = _eviscerationLevel == 0;
    TRACE_3("chanceIncrease",_eviscerationLevel,_hasEvisceration,_initialEvisceration);
    switch (true) do {
        case (_hasEvisceration): {
            [_unit, 1] call ACEFUNC(medical_status,adjustPainLevel);
            private _newEviscerationLevel = (_eviscerationLevel + 1) min 4;
            _unit setVariable [QGVAR(evisceration), _newEviscerationLevel, true];
        };
        case (_initialEvisceration): {
            [_unit, 1] call ACEFUNC(medical_status,adjustPainLevel);
            private _newEviscerationLevel = (_eviscerationLevel + 1) min 4;
            _unit setVariable [QGVAR(evisceration), _newEviscerationLevel, true];
            _unit setVariable [QGVAR(activeWoundPack), 0, true];
        };
    };

    _this // return
};

_this // return