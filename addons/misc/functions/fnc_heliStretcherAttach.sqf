#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - attaching it and using it.
 *
 *
 * Example:
 * [_unit,_item] call kat_misc_fnc_heliStretcherAttach;
 *
 * Public: No
 */

 if !(_h isKindOf "Helicopter") exitWith {
   [LLSTRING(helistretcher_attention1), 2, ace_player, 10] call ACEFUNC(common,displayTextStructured);
   player addItem "Attachable_Helistretcher"
 };

 if !(player distance2D _h <= 15) exitWith {
   [LLSTRING(helistretcher_attention2), 2, ace_player, 10] call ACEFUNC(common,displayTextStructured);
   player addItem "Attachable_Helistretcher"
 };

_h = cursorObject;
_s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-5])];
_s attachTo [_h,[0,0,-.1],"slingload0"];

[_s,_h] call kat_misc_fnc_heliAddActionDeploy;
