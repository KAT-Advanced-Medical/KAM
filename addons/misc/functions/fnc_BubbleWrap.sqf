#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Plays popping sound & removes mag
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call kat_misc_fnc_BubbleWrap;
 *
 * Public: No
 */

params ["_unit"];

[_unit, 'kat_Bubble_Wrap'] call EFUNC(pharma,setMagItem);
[QEGVAR(pharma,medicationLocal), [_unit, "Head", "BubbleWrap"], _unit] call CBA_fnc_targetEvent;
playsound3D [selectRandom [QPATHTOF_SOUND(sounds\bubble_wrap_1.ogg),QPATHTOF_SOUND(sounds\bubble_wrap_2.ogg),QPATHTOF_SOUND(sounds\bubble_wrap_3.ogg),QPATHTOF_SOUND(sounds\bubble_wrap_4.ogg),QPATHTOF_SOUND(sounds\bubble_wrap_5.ogg)], _unit, false, getPosASL _unit, 30, 1, 10];