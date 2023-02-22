#include "script_component.hpp"
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
 _allDamages select 0 params ["_damage","_bodyPart"];

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Body") || !(_ammo isKindOF "BulletBase")) exitWith {};
//Other mods can utilise KAT_Pneumothorax_Exclusion variable to prevent Pneumothorax from happening
if ((_damage < GVAR(pneumothoraxDamageThreshold)) || (_unit getVariable ["KAT_Pneumothorax_Exclusion", false])) exitWith {};

private _hemo = _unit getVariable [QGVAR(hemopneumothorax), false];
private _tension = _unit getVariable [QGVAR(tensionpneumothorax), false];

if (random 100 <= GVAR(pneumothoraxChance)) then {
    // add breathing sound
    [_unit, 0.5] call ACEFUNC(medical_status,adjustPainLevel);
    [_unit] call FUNC(handleBreathing);
    _unit setVariable [QGVAR(pneumothorax), true, true];

    // Prevent the patient from getting both hemothorax and tension pneumothorax at the same time
    if (random 100 <= GVAR(advPtxChance) && !(_hemo || _tension) && GVAR(advPtxEnable)) then {
        [_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);

        if (random 100 <= GVAR(hptxChance)) then {
            _unit setVariable [QGVAR(hemopneumothorax), true, true];
            [_unit] call EFUNC(circulation,updateInternalBleeding);
        } else {
            _unit setVariable [QGVAR(tensionpneumothorax), true, true];
        };
    };
};

if ((random(100) <= GVAR(deterioratingPneumothorax_chance)) && (_unit getVariable [QGVAR(pneumothorax), false]) && GVAR(advPtxEnable)) then {
    [{
        params ["_unit"];
        if ((_hemo || _tension || !(alive _unit)) || !(_unit getVariable [QGVAR(pneumothorax), false])) exitWith {};
        [_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);
        [_unit] call FUNC(handleBreathing);
        _unit setVariable [QGVAR(tensionpneumothorax), true, true];
    }, [_unit], GVAR(deterioratingPneumothorax_countdown)] call CBA_fnc_waitAndExecute;
};
