#include "script_component.hpp"

params ["_unit"];

if !(GVAR(enable)) exitWith {};

_unit addEventHandler ["Respawn", FUNC(handleDie)];
_unit addEventHandler ["Killed", FUNC(handleDie)];
_unit call FUNC(init);
