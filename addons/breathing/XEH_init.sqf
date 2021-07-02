#include "script_component.hpp"

params ["_unit"];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};
_unit call FUNC(init);

if (GVAR(pneumothorax) == 0) exitWith {};
_unit addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "", "_projectile"];
    [_unit, _selection, _damage, _projectile] call FUNC(handlePulmoHit);
}];
