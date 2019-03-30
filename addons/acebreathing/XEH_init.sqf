#include "script_component.hpp"

params ["_unit"];

if !(GVAR(enable)) exitWith {};

[{(_this select 0) getVariable ["ace_medical_airwayStatus", 100] < 70}] call ace_medical_fnc_addUnconsciousCondition;
_unit call FUNC(init);

if (GVAR(pneumothorax) == 0) exitWith {};
_unit addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "", "_projectile"];
    [_unit, _selection, _damage, _projectile] call FUNC(handlePulmoHit);
}];
