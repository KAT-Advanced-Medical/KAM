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
private _noThrow = false;
private _keepProne = false;
private _holsterWeapon = false;
private _aimFracture = 0;
private _armJointArray = GET_JOINTS(_unit) select [0, 2];
private _legJointArray = GET_JOINTS(_unit) select [2, 2];
_unit setVariable [QGVAR(keepProne), _keepProne, true];
_unit setVariable [QGVAR(holsterWeapon), _holsterWeapon, true];
if (ACEGVAR(medical,fractures) > 0) then {
    private _fractures = GET_FRACTURES(_unit);
    TRACE_1("",_fractures);
    if ((_fractures select 8) == 1 || (_fractures select 9) == 1 || (_fractures select 10) == 1 || (_fractures select 11) == 1) then {
        TRACE_1("limping because of fracture",_fractures);
        diag_log format ["limping because of fracture %1",_fractures];
        _isLimping = true;
    };
    if ((_fractures select 4) == 1) then { _aimFracture = _aimFracture + 4; };
    if ((_fractures select 5) == 1) then { _aimFracture = _aimFracture + 4; };
    if ((_fractures select 6) == 1) then { _aimFracture = _aimFracture + 4; };
    if ((_fractures select 7) == 1) then { _aimFracture = _aimFracture + 4; };

    if (ACEGVAR(medical,fractures) in [2, 3]) then { // the limp with a splint will still cause effects
        // Block sprint / force walking based on fracture setting and leg splint status
        _hasLegSplint = (_fractures select 8) in [-1, -2] || (_fractures select 9) in [-1, -2] || (_fractures select 10) in [-1, -2] || (_fractures select 11) in [-1, -2];
        if (ACEGVAR(medical,fractures) == 2) then {
            _noSprint = _hasLegSplint;
        } else {
            _noJog = _hasLegSplint;
        };

        if ((_fractures select 4) in [-1, -2]) then { _aimFracture = _aimFracture + 2; };
        if ((_fractures select 5) in [-1, -2]) then { _aimFracture = _aimFracture + 2; };
        if ((_fractures select 6) in [-1, -2]) then { _aimFracture = _aimFracture + 2; };
        if ((_fractures select 7) in [-1, -2]) then { _aimFracture = _aimFracture + 2; };
    };
};
if (GVAR(CatastrophicEnable)) then {
    {
        {if (_x in [1, 4, 7]) then {_aimFracture = _aimFracture + 1;};} forEach _x;
    } forEach _armJointArray;

    {
        {if (_x in [2, 5, 8]) then {_aimFracture = _aimFracture + 3;};} forEach _x;
    } forEach _armJointArray;

    {
        {if (_x in [3, 6]) then {_aimFracture = _aimFracture + 6;};} forEach _x;
    } forEach _armJointArray;

    {
        {if (_x == 9) then {_aimFracture = _aimFracture + 3;};} forEach _x;
    } forEach _armJointArray;

};

_unit setVariable [QACEGVAR(medical_engine,aimFracture), _aimFracture, false]; // local only var, used in ace_medical's postInit to set ACE_setCustomAimCoef

if (!_isLimping && {ACEGVAR(medical,limping) > 0}) then {
    private _openWounds = GET_OPEN_WOUNDS(_unit);

    // Want a copy of combined arrays to prevent wound mixing
    private _legWounds = (_openWounds getOrDefault ["leftleg", []])
        + (_openWounds getOrDefault ["upperleftleg", []])
        + (_openWounds getOrDefault ["rightleg", []])
        + (_openWounds getOrDefault ["upperrightleg", []]);

    if (ACEGVAR(medical,limping) == 2) then {
        private _bandagedWounds = GET_BANDAGED_WOUNDS(_unit);
        _legWounds = _legWounds
            + (_bandagedWounds getOrDefault ["leftleg", []])
            + (_bandagedWounds getOrDefault ["upperleftleg", []])
            + (_bandagedWounds getOrDefault ["rightleg", []])
            + (_bandagedWounds getOrDefault ["upperrightleg", []]);
    };

    {
        _x params ["_xClassID", "_xAmountOf", "", "_xDamage"];
        if (
            (_xAmountOf > 0)
            && {_xDamage > LIMPING_DAMAGE_THRESHOLD_DEFAULT}
            // select _causeLimping from woundDetails
            && {(ACEGVAR(medical_damage,woundDetails) get (floor (_xClassID / 10))) select 3}
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
if (_unit getVariable [QEGVAR(hitpoints,evisceration), 0] > 0) then {
    _isLimping = true;
    _noJog = true;
    _noSprint = true;
};

if ((_unit getVariable [QEGVAR(hitpoints,pelvicFracture), 0]) > 0) then {
    _isLimping = true;
    _noJog = true;
    _noSprint = true;
    _keepProne = true;
};

if ((_unit getVariable [QEGVAR(hitpoints,pelvicFracture), 0]) < 0) then {
    _isLimping = true;
    _noJog = true;
    _noSprint = true;
};



private _hasLegDislocationInjury = _legJointArray findIf {_x findIf {_x in [3, 6]} != -1} != -1;
private _hasLegSprainInjury = _legJointArray findIf {_x findIf {_x in [1, 4, 7]} != -1} != -1;
private _hasLegStrainInjury = _legJointArray findIf {_x findIf {_x in [2, 5, 8]} != -1} != -1;
private _hasArmDislocationInjury = _armJointArray findIf {_x findIf {_x in [3, 6]} != -1} != -1;
private _hasArmJointInjury = _armJointArray findIf {_x findIf {_x != 0} != -1} != -1;
TRACE_7("HasInjury",_hasLegSprainInjury,_hasLegStrainInjury,_hasLegDislocationInjury,_hasArmDislocationInjury,_hasArmJointInjury,_legJointArray,_armJointArray);
if (_hasLegStrainInjury) then {
    _noSprint = true;
};

if (_hasLegStrainInjury && (random 100 > 50)) then {
    _noSprint = true;
    _noJog = true;
};

if (_hasLegSprainInjury) then {
    _noSprint = true;
};

if (_hasLegSprainInjury && (random 100 > 50)) then {
    _noSprint = true;
    _noJog = true;
    _isLimping = true;
};


if (_hasLegDislocationInjury) then {
    _isLimping = true;
    _noJog = true;
    _noSprint = true;
    _keepProne = true;
};

if (_hasArmDislocationInjury) then {
    _noThrow = true;
};

if (_hasArmJointInjury) then {
    _noThrow = true;
};

if (_unit getVariable [QEGVAR(surgery,reboa), false]) then {
    _isLimping = true;
    _noJog = true;
    _noSprint = true;
};

[_unit, "blockSprint", QACEGVAR(medical,fracture), _noSprint] call ACEFUNC(common,statusEffect_set);
[_unit, "blockThrow", QEGVAR(hitpoints,joints), _noThrow] call ACEFUNC(common,statusEffect_set);
[_unit, "forceWalk", QACEGVAR(medical,fracture), _noJog] call ACEFUNC(common,statusEffect_set);

_unit setVariable [QACEGVAR(medical,isLimping), _isLimping, true];
_unit setVariable [QGVAR(keepProne), _keepProne, true];

[{
        _this params ["_args", "_pfhID"];
        _args params ["_unit"];
        if (!alive _unit || {!(_unit getVariable [QGVAR(keepProne), false])} || (_unit != ACE_player)) exitWith {
            _pfhID call CBA_fnc_removePerFrameHandler;
        };
        private _state = animationState _unit;
        TRACE_1("State",_state);
        if ((_state find "pne") == -1) then {
            _unit playActionNow "PlayerProne";
            TRACE_2("State2",_state,_unit);

        };
}, 0.05, [_unit]] call CBA_fnc_addPerFrameHandler;

// refresh
private _isDamaged = _unit getHitPointDamage "HitLegs" >= DAMAGED_MIN_THRESHOLD && {_unit getHitPointDamage "HitLegs" != LIMPING_MIN_DAMAGE};

[_unit, "Legs", _isDamaged] call ACEFUNC(medical_engine,damageBodyPart);
