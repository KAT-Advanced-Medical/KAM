#include "script_component.hpp"

params ["_unit"];

if !(GVAR(enable)) exitWith {};

_unit addEventHandler ["Respawn", {_this call FUNC(handleDie);}];
_unit addEventHandler ["Killed", {_this call FUNC(handleDie);}];
_unit call FUNC(init);
