#include "..\script_component.hpp"
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

params ["_target"];

[_target, "AinvPknlMstpSlayWlnrDnon_medicOther"] call ACEFUNC(common,doAnimation);
_target removeItem "kat_gasmaskFilter";

_target setVariable [QGVAR(gasmask_durability),10,true];

_target setVariable [QGVAR(gasmask_durability_reset), true, true];
