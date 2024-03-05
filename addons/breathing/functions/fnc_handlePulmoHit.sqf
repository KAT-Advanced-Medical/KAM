#include "..\script_component.hpp"
/*
 * Author: Katalam
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
 * [cursorTarget, [1, "Body"], objNull, "BulletBase"] call kat_breathing_fnc_handlePulmoHit;
 *
 * Public: No
 */

params ["_unit", "_allDamages", "", "_ammo"];
_allDamages select 0 params ["_damage", "_bodyPart"];

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Body") || !(_ammo isKindOF "BulletBase")) exitWith {};
//Other mods can utilise KAT_Pneumothorax_Exclusion variable to prevent Pneumothorax from happening
if ((_damage < GVAR(pneumothoraxDamageThreshold)) || (_unit getVariable ["KAT_Pneumothorax_Exclusion", false])) exitWith {};

private _chanceIncrease = 0;
if (GVAR(pneumothoraxDamageThreshold_TakenDamage)) then {
    _chanceIncrease = linearConversion [GVAR(pneumothoraxDamageThreshold), 3, _damage, 0, 30, true];
};

if (floor (random 100) <= (GVAR(pneumothoraxChance) + _chanceIncrease)) then {
    if (_unit getVariable [QGVAR(pneumothorax), 0] isEqualto 0 && !(_unit getVariable [QGVAR(tensionpneumothorax), false])) then { // Initial pneumothorax
        // add breathing sound
        [_unit, 0.2] call ACEFUNC(medical_status,adjustPainLevel);
        [_unit] call FUNC(handleBreathing);
        _unit setVariable [QGVAR(pneumothorax), 1, true];
        _unit setVariable [QGVAR(deepPenetratingInjury), true, true];
        _unit setVariable [QGVAR(activeChestSeal), false, true];

        // Start deteriorating after delay
        [_unit, _chanceIncrease] call FUNC(handlePneumothoraxDeterioration);
    } else {
        if (_unit getVariable [QGVAR(tensionpneumothorax), false]) then { // If already afflicted with tensionpneumothorax -> fully deteriorate pneumothorax
            _unit setVariable [QGVAR(pneumothorax), 4, true];
            _unit setVariable [QGVAR(activeChestSeal), false, true];
        } else {
            if (GVAR(advPtxEnable)) then {
                // Roll chance to get advanced pneumothorax while afflicted with early stage of pneumothorax
                [_unit, _chanceIncrease] call FUNC(inflictAdvancedPneumothorax);
            };
        };
    };
} else { // Damage threshold was passed but no pneumothorax given, try to just give injury instead
    if (floor (random 100) < GVAR(deepPenetratingInjuryChance)) then {
        _unit setVariable [QGVAR(deepPenetratingInjury), true, true];
        _unit setVariable [QGVAR(activeChestSeal), false, true];
    };
};
