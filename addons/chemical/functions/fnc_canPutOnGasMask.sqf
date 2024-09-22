#include "..\script_component.hpp"

params ["_player"];

(((_player call ACEFUNC(common,uniqueItems)) findAny GVAR(availGasmaskList)) != -1) &&
(!((goggles _player) in GVAR(availGasmaskList)))
