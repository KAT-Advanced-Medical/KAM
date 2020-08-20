#include "script_component.hpp"
/*
 * Author: Katalam
 * Called when a unit is damaged.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Selection <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "body", 1, ""] call kat_breathing_fnc_handlePulmoHit;
 *
 * Public: No
 */

params ["_unit", "_selection", "_damage", "_projectile"];

if !(GVAR(enable)) exitWith {};
if (GVAR(pneumothorax) == 0) exitWith {};
if !(_selection isEqualTo "body") exitWith {};
// if (_damage < 0.4) exitWith {};
if !(_projectile isKindOF "BulletBase") exitWith {};

if (random 100 <= GVAR(pneumothorax)) then {
    // add breathing sound
    [_unit, 0.5] call ace_medical_status_fnc_adjustPainLevel;
    [_unit] call FUNC(handleBreathing);
    _unit setVariable ["KAT_medical_airwayCollapsed", true, true];
    if (random 100 <= GVAR(hemopneumothoraxChance)) then {
        [_unit, 0.7] call ace_medical_status_fnc_adjustPainLevel;
        _unit setVariable ["KAT_medical_hemopneumothorax", true, true];
    };
};
