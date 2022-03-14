#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_CASCreateGas;
 *
 * Public: No
 *
 *
*/

private _pos = [_this select 0, _this select 1, _this select 2];
[_pos,240,15,0] spawn FUNC(createZone);
nil