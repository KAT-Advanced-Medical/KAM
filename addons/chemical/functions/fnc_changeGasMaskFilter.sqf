#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_changeGasMaskFilter;
 *
 * Public: No
*/

params ["_player"];

[_player, "AinvPknlMstpSlayWlnrDnon_medicOther"] call ace_common_fnc_doAnimation;
_player removeItem "kat_gasmaskFilter";

_player setVariable ["kat_gasmask_durability",10,true];

_player setVariable ["kat_gasmask_durability_reset", true, true];
