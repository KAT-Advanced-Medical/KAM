#include "..\script_component.hpp"
/*
 * Author: Mazinski, Cplhardcore
 * Ends the treatment cycle for a chest tube
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, 1] call ka__breathing_treatmentAdvanced_chestTube
 
 * Public: No
 */

params ["_medic", "_patient"];

[_medic, "kat_scalpel"] call ACEFUNC(common,addToInventory);
[_medic, "kat_clamp"] call ACEFUNC(common,addToInventory);
[_medic, "kat_retractor"] call ACEFUNC(common,addToInventory);
[_medic, "kat_plate"] call ACEFUNC(common,addToInventory);
[_medic, "kat_stitchKit"] call ACEFUNC(common,addToInventory);
