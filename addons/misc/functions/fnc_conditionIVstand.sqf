#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Condition check for the medicine IV stands to add a bag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Cann add IV bag <BOOLEAN>
 *
 * Example:
 * [player] call kat_misc_fnc_conditionIVstand;
 *
 * Public: No
 */

 params [
     ["_player", objNull, [objNull]],
     ["_classname", "ACE_salineIV", [""]]
 ];

if !(GVAR(enable)) exitWith {false};

if ([_player] call ACEFUNC(medical_treatment,isMedic) && _classname in items _player) exitWith {true};
false;
