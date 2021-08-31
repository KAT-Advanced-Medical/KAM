#include "script_component.hpp"

params ["_unit"];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};

_unit call FUNC(init);