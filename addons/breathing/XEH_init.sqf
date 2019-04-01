#include "script_component.hpp"

params ["_unit"];

if !(GVAR(enable)) exitWith {};

_unit call FUNC(init);
