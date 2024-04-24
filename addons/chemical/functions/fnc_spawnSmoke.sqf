#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: PosX <NUMBER>
 * 1: PosY <NUMBER>
 * 2: PosZ <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [0,0,0] call kat_chemical_fnc_spawnSmoke;
 *
 * Public: No
 *
 *
*/
params ["_posX","_posY","_posZ"];

private _smoke = "KAT_GASTrip_SmokeEffect" createVehicle [_posX,_posY,_posZ];
hideObjectGlobal _smoke;
[_smoke, 0, ["ACE_MainActions", "ACTION"]] call ACEFUNC(interact_menu,removeActionFromObject);

private _pos = [_posX,_posY,_posZ];

[_pos,240,5,0] call FUNC(createZone);

["KAT_tripGasTriggered", [_smoke, [_posX,_posY,_posZ]]] call CBA_fnc_globalEvent;
