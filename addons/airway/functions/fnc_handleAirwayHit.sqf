#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Called when a unit is damaged.
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
 * [cursorTarget, [1, "Body"], objNull, "BulletBase"] call kat_airway_fnc_handleAirwayHit;
 *
 * Public: No
 */

params ["_unit", "_allDamages", "", "_ammo"];
_allDamages select 0 params ["_damage", "_bodyPart"];

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Head") || !(_ammo isKindOF "BulletBase")) exitWith {};

if (floor (random 100) < GVAR(airwayDamageChance)) then {
    private _occlusion = _unit getVariable [QGVAR(occlusion), 0];
    _occlusion = ((_occlusion + 1) min 4);

    _unit setVariable [QGVAR(occlusion), _occlusion, true];
};
