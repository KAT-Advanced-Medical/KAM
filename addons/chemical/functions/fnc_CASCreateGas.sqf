#include "..\script_component.hpp"
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
* [getPos player] call kat_chemical_fnc_CASCreateGas;
*
* Public: No
*
* Gets position of droped bombs and creates a Gas zone there
*/

params ["_posX", "_posY", "_posZ"];

private _jipID = [QGVAR(createZoneGlobal), [[_posX, _posY, _posZ], 240, 15, 0]] call CBA_fnc_globalEventJIP;
[_jipID] call CBA_fnc_removeGlobalEventJIP;