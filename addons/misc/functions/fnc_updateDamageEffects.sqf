#include "..\script_component.hpp"
/*
 * Author: commy2, PabstMirror
 * Modified: Blue
 * Updates damage effects for limping and fractures.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_engine_fnc_updateDamageEffects
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]]];

if (!local _unit) exitWith { ERROR_2("updateDamageEffects: Unit not local or null [%1:%2]",_unit,typeOf _unit); };

private _isLimping = false;
private _hasLegSplint = false;
private _noSprint = false;
private _noJog = false;

if (ACEGVAR(medical,fractures) > 0) then {
    private _fractures = GET_FRACTURES(_unit);
    TRACE_1("",_fractures);
    if (((_fractures select 4) == 1) || {(_fractures select 5) == 1}) then {
        TRACE_1("limping because of fracture",_fractures);
        _isLimping = true;
    };
    private _aimFracture = 0;
    if ((_fractures select 2) == 1) then { _aimFracture = _aimFracture + 4; };
    if ((_fractures select 3) == 1) then { _aimFracture = _aimFracture + 4; };

    if (ACEGVAR(medical,fractures) in [2, 3]) then { // the limp with a splint will still cause effects
        // Block sprint / force walking based on fracture setting and leg splint status
        _hasLegSplint = (_fractures select 4) == -1 || {(_fractures select 5) == -1};
        if (ACEGVAR(medical,fractures) == 2) then {
            _noSprint = _hasLegSplint;
        } else {
            _noJog = _hasLegSplint;
        };

        if ((_fractures select 2) == -1) then { _aimFracture = _aimFracture + 2; };
        if ((_fractures select 3) == -1) then { _aimFracture = _aimFracture + 2; };
    };
    _unit setVariable [QACEGVAR(medical_engine,aimFracture), _aimFracture, false]; // local only var, used in ace_medical's postInit to set ACE_setCustomAimCoef
};

if (!_isLimping && {ACEGVAR(medical,limping) > 0}) then {
    private _openWounds = GET_OPEN_WOUNDS(_unit);

    // Want a copy of combined arrays to prevent wound mixing
    private _legWounds = (_openWounds getOrDefault ["leftleg", []])
        + (_openWounds getOrDefault ["rightleg", []]);

    if (ACEGVAR(medical,limping) == 2) then {
        private _bandagedWounds = GET_BANDAGED_WOUNDS(_unit);
        _legWounds = _legWounds
            + (_bandagedWounds getOrDefault ["leftleg", []])
            + (_bandagedWounds getOrDefault ["rightleg", []]);
    };

    {
        _x params ["_xClassID", "_xAmountOf", "", "_xDamage"];
        if (
            (_xAmountOf > 0)
            && {_xDamage > LIMPING_DAMAGE_THRESHOLD_DEFAULT}
            // select _causeLimping from woundDetails
            && {(ACEGVAR(medical_damage,woundDetails) get (_xClassID / 10)) select 3}
        ) exitWith {
            TRACE_1("limping because of wound",_x);
            _isLimping = true;
        };
    } forEach _legWounds;
};

if (_unit getVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0] >= 20) then {
    _noSprint = true;
};

if (_unit getVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0] >= 60) then {
    _noJog = true;
};

if (_unit getVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0] >= 90) then {
    _isLimping = true;
};

if (_unit getVariable [QEGVAR(surgery,reboa), false]) then {
    _isLimping = true;
    _noJog = true;
    _noSprint = true;
};


[_unit, "blockSprint", QACEGVAR(medical,fracture), _noSprint] call ACEFUNC(common,statusEffect_set);
[_unit, "forceWalk", QACEGVAR(medical,fracture), _noJog] call ACEFUNC(common,statusEffect_set);

_unit setVariable [QACEGVAR(medical,isLimping), _isLimping, true];

// refresh
private _isDamaged = _unit getHitPointDamage "HitLegs" >= DAMAGED_MIN_THRESHOLD && {_unit getHitPointDamage "HitLegs" != LIMPING_MIN_DAMAGE};

[_unit, "Legs", _isDamaged] call ACEFUNC(medical_engine,damageBodyPart);
