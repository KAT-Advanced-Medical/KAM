#include "script_component.hpp"
///////////////////////////////

///////////////////////////////

params ["_player"];
//Remove item

[_player, "AinvPknlMstpSlayWlnrDnon_medicOther"] call ace_common_fnc_doAnimation;
_player removeItem "kat_gasmaskFilter";

_player setVariable ["kat_gasmask_durability",10,true];

_player setVariable ["kat_gasmask_durability_reset", true, true];
