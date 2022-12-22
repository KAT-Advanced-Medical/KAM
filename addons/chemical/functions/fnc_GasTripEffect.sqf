#include "script_component.hpp"
/*
* Author: DiGii
*
* Arguments:
* 0: NONE
*
* Return Value:
* NONE
*
* Example:
* [] call kat_chemical_fnc_GastripEffect;
*
* Public: No
*
* Creates effects when Trip wire explodes.
*/
[FUNC(spawnSmoke), _this] call CBA_fnc_directcall;