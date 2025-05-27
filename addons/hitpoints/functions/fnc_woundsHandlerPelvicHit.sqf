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
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_breathing_fnc_woundsHandlerPelvicHit
 *
 * Public: No
 */

params ["_unit", "_allDamages"];
(_allDamages select 0) params ["_engineDamage", "_bodyPart"]; // selection-specific

private _fixedBodyPart = toLower _bodyPart;
if !(GVAR(CatastrophicEnable) && _fixedBodyPart == "body") exitWith {
    TRACE_1("NotEnable",_fixedBodyPart);
    _this};
if (_engineDamage < GVAR(PelvicDamageThreshold)) exitWith {
    TRACE_1("NotEnoughDamage",_engineDamage);
    _this};

private _chanceIncrease = 0;
if (GVAR(PelvicDamageThreshold_TakenDamage)) then {
    _chanceIncrease = linearConversion [GVAR(PelvicDamageThreshold), 3, _engineDamage, 0, 30, true];
    TRACE_1("chanceIncrease",_chanceIncrease);
};

// Damage threshold passed & Evisceration given
if (floor (random 100) < (GVAR(PelvicFractureChance) + _chanceIncrease)) exitWith {
    private _pelvicFracture = _unit getVariable [QGVAR(pelvicFracture), 0];
    if (_pelvicFracture == 0) then {
        _unit setVariable [QGVAR(pelvicFracture), 1, true];
        [_unit, 0.9] call ACEFUNC(medical_status,adjustPainLevel);
        _unit setVariable [QGVAR(activePelvicBinder), false, true];
    };
    _this
};

_this // return