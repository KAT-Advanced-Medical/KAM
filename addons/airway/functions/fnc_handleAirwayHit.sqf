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
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_hitpoints_fnc_handleAirwayHit
 *
 * Public: No
 */

params ["_unit", "_allDamages"];
(_allDamages select 0) params ["_engineDamage", "_bodyPart"]; // selection-specific

if !(GVAR(AirwayEnable)) exitWith {
    TRACE_1("NotEnable",_bodyPart);
    _this
};
if !(_bodyPart in ["Head", "Neck"]) exitWith {
    TRACE_1("NotEnable",_bodyPart);
    _this
};

private _occlusionChanceIncrease = 0;
if (GVAR(airwayOcclusionDamageThreshold_TakenDamage)) then {
    _occlusionChanceIncrease = linearConversion [GVAR(airwayOcclusionDamageThreshold), 3, _engineDamage, 0, 30, true];
};
private _obstructionChanceIncrease = 0;
if (GVAR(airwayObstructionDamageThreshold_TakenDamage)) then {
    _obstructionChanceIncrease = linearConversion [GVAR(airwayObstructionDamageThreshold), 3, _engineDamage, 0, 30, true];
};
private _catastrophicAirwayChanceIncrease = 0;
if (GVAR(catastrophicAirwayDamageThreshold_TakenDamage)) then {
    _catastrophicAirwayChanceIncrease = linearConversion [GVAR(catastrophicAirwayDamageThreshold), 3, _engineDamage, 0, 30, true];
};
switch (true) do {
        case (_bodyPart == "Head"): {
            if ((floor (random 100) < GVAR(airwayOcclusionChance)) && (_engineDamage > (GVAR(airwayOcclusionDamageThreshold) + _occlusionChanceIncrease))) then {
                private _level = selectRandom [0, 1];
                private _occlusion = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
                _occlusion set [_level, (((_occlusion select _level) + 1) min 6)];
                _unit setVariable [QGVAR(occlusion), _occlusion, true];
                [_unit, _level] call FUNC(airwayPFH);
                };
            if ((floor (random 100) < GVAR(airwayObstructionChance)) && (_engineDamage > (GVAR(airwayObstructionDamageThreshold + _obstructionChanceIncrease)))) then {
                private _level = selectRandom [0, 1];
                private _obstruction = _unit getVariable [QGVAR(obstruction), [0, 0, 0]];
                _obstruction set [_level, (((_obstruction select _level) + 1) min 2)];
                _unit setVariable [QGVAR(obstruction), _obstruction, true];
                [_unit, true] call ACEFUNC(medical,setUnconscious);
                };
            if ((floor (random 100) < GVAR(catastrophicAirwayChance)) && (_engineDamage > (GVAR(catastrophicAirwayDamageThreshold + _catastrophicAirwayChanceIncrease)))) then {
                private _level = selectRandom [0, 1];
                private _catastrophic =  _unit getVariable [QGVAR(catastrophicAirway), [false, false]];
                _catastrophic set [_level, true];
                _unit setVariable [QGVAR(catastrophicAirway), _catastrophic, true];
                [_unit, true] call ACEFUNC(medical,setUnconscious);
                };
            };
        case (_bodyPart == "Neck"): {
            if ((floor (random 100) < GVAR(airwayOcclusionChance)) && (_engineDamage > (GVAR(airwayOcclusionDamageThreshold + _occlusionChanceIncrease)))) then {
                private _level = selectRandom [1, 2];
                private _occlusion = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
                _occlusion set [_level, (((_occlusion select _level) + 1) min 2)];
                _unit setVariable [QGVAR(occlusion), _occlusion, true];
                [_unit, _level] call FUNC(airwayPFH);
                };
            if ((floor (random 100) < GVAR(airwayObstructionChance)) && (_engineDamage > (GVAR(airwayObstructionDamageThreshold + _obstructionChanceIncrease)))) then {
                private _level = selectRandom [1, 2];
                private _obstruction = _unit getVariable [QGVAR(obstruction), [0, 0, 0]];
                _obstruction set [_level, (((_obstruction select _level) + 1) min 2)];
                _unit setVariable [QGVAR(obstruction), _obstruction, true];
                [_unit, true] call ACEFUNC(medical,setUnconscious);
                };
            };
        default {};
    };


// Damage threshold passed & Airway Injury Given
_this // return