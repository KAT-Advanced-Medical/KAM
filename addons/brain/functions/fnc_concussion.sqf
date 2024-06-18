#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Called when a unit is hit. Handles receiving TBIs and setting up dedicated PFHs to increase ICP.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *  0: Damage <NUMBER>
 *  1: Bodypart <STRING>
 * 2: Shooter <OBJECT>
 * 3: Ammo classname or damage type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Head"], objNull, "BulletBase"] call kat_brain_fnc_concussion
 *
 * Public: No
 */

 params ["_unit", "_allDamages", "", "_ammo"];
_allDamages select 0 params ["_damage", "_bodyPart"];

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Head")) exitWith {};
if (_damage < GVAR(concussionDamage)) exitWith {};
if (!(_ammo in ["vehiclehit","explosive","shell","vehiclecrash"])) exitWith {};

// Increase the chance of concussions depending on the damage type
private _chanceIncrease = linearConversion [0,3,(["vehiclehit","explosive","shell","vehiclecrash"] find _ammo),1,1.5,true];
private _concussionChance = GVAR(concussionChance) * _chanceIncrease