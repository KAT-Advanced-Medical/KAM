#include "script_component.hpp"
/*
 * Author: Katalam
 * Called when a unit is damaged.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Selection <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "body", 1, ""] call kat_breathing_fnc_handlePulmoHit;
 *
 * Public: No
 */

 params ["_unit", "_allDamages", "", "_ammo"];
 _allDamages select 0 params ["_damage","_bodyPart"];

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Body") || !(_ammo isKindOF "BulletBase")) exitWith {};
//Other mods can utilise KAT_Pneumothorax_Exclusion variable to prevent Pneumothorax from happening
if ((_damage < GVAR(pneumothoraxDamageThreshold)) || (GVAR(pneumothorax) isEqualTo 0) || (_unit getVariable ["KAT_Pneumothorax_Exclusion", false])) exitWith {};

private _hemo = _unit getVariable [QGVAR(hemopneumothorax), false];
private _tension = _unit getVariable [QGVAR(tensionpneumothorax), false];

if (random 100 <= GVAR(pneumothoraxChance)) then {
    // add breathing sound
    [_unit, 0.5] call ace_medical_status_fnc_adjustPainLevel;
    [_unit] call FUNC(handleBreathing);
    _unit setVariable [QGVAR(pneumothorax), true, true];

    // Prevent the patient from getting both hemothorax and tension pneumothorax at the same time
    if (random 100 <= GVAR(hemopneumothoraxChance) && !(_hemo || _tension)) then {
        [_unit, 0.7] call ace_medical_status_fnc_adjustPainLevel;

        if (random 100 < 50) then {
            _unit setVariable [QGVAR(hemopneumothorax), true, true];
        } else {
            _unit setVariable [QGVAR(tensionpneumothorax), true, true];
        };
    };
};

if ((random(100) <= GVAR(deterioratingPneumothorax_chance)) && (_unit getVariable [QGVAR(pneumothorax), false])) then {
    [{
        params ["_unit"];
        if ((_hemo || _tension || !(alive _unit)) || !(_unit getVariable [QGVAR(pneumothorax), false])) exitWith {};
        [_unit, 0.7] call ace_medical_status_fnc_adjustPainLevel;
        [_unit] call FUNC(handleBreathing);
        _unit setVariable [QGVAR(tensionpneumothorax), true, true];
    }, [_unit], GVAR(deterioratingPneumothorax_countdown)] call CBA_fnc_waitAndExecute;
};
