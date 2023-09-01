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
_allDamages select 0 params ["_damage", "_bodyPart"];

private _fnc_inflictAdvancedPneumothorax = {
    params ["_unit", "_chanceIncrease", ["_deteriorated", false]];

    // Prevent the patient from getting both hemothorax and tension pneumothorax at the same time
    private _hemo = _unit getVariable [QGVAR(hemopneumothorax), false];
    private _tension = _unit getVariable [QGVAR(tensionpneumothorax), false];
    
    // Roll chance to get advanced pneumothorax or skip chance if deteriorated
    if ((floor (random 100) <= (GVAR(advPtxChance) + _chanceIncrease) || _deteriorated) && !(_hemo || _tension)) then {
        [_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);

        if (floor (random 100) <= GVAR(hptxChance)) then {
            _unit setVariable [QGVAR(hemopneumothorax), true, true];
            _unit setVariable [QGVAR(pneumothorax), 4, true];
            [_unit] call EFUNC(circulation,updateInternalBleeding);
        } else {
            _unit setVariable [QGVAR(tensionpneumothorax), true, true];
            _unit setVariable [QGVAR(pneumothorax), 4, true];
        };
    };
};

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Body") || !(_ammo isKindOF "BulletBase")) exitWith {};
//Other mods can utilise KAT_Pneumothorax_Exclusion variable to prevent Pneumothorax from happening
if ((_damage < GVAR(pneumothoraxDamageThreshold)) || (_unit getVariable ["KAT_Pneumothorax_Exclusion", false])) exitWith {};

private _chanceIncrease = 0;
if (GVAR(pneumothoraxDamageThreshold_TakenDamage)) then {
    _chanceIncrease = linearConversion [GVAR(pneumothoraxDamageThreshold), 3, _damage, 0, 30, true];
};

if (floor (random 100) <= (GVAR(pneumothoraxChance) + _chanceIncrease)) then {
    if(_unit getVariable [QGVAR(pneumothorax), 0] isEqualto 0 && !(_unit getVariable [QGVAR(tensionpneumothorax), false])) then { // Initial pneumothorax
        // add breathing sound
        [_unit, 0.2] call ACEFUNC(medical_status,adjustPainLevel);
        [_unit] call FUNC(handleBreathing);
        _unit setVariable [QGVAR(pneumothorax), 1, true];
        _unit setVariable [QGVAR(deepPenetratingInjury), true, true];

        // Start deteriorating after delay
        [{
            params ["_unit", "_chanceIncrease", "_fnc_inflictAdvancedPneumothorax"];

            if(_unit getVariable [QGVAR(pneumothorax), 0] > 0) then {
                // Try to deteriorate at set interval
                [{
                    params ["_args", "_idPFH"];
                    _args params ["_unit", "_chanceIncrease", "_fnc_inflictAdvancedPneumothorax"];
                    
                    // If patient is dead, already treated or has already deteriorated into advanced pneumothorax, kill the PFH
                    if(_unit getVariable [QGVAR(hemopneumothorax), false] || _unit getVariable [QGVAR(tensionpneumothorax), false] || !(alive _unit) || _unit getVariable [QGVAR(pneumothorax), 0] isEqualTo 0) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                    };

                    if (floor (random 100) <= GVAR(deterioratingPneumothorax_chance)) then {
                        private _ptxTarget = (_unit getVariable [QGVAR(pneumothorax), 0]) + 1;
                        
                        // Once deteriorated far enough try to inflict advanced pneumothorax or if disabled kill the PFH
                        if (_ptxTarget > 4) exitWith {
                            if(GVAR(advPtxEnable)) then {
                                
                                [_unit, _chanceIncrease, true] call _fnc_inflictAdvancedPneumothorax;
                            };
                            [_idPFH] call CBA_fnc_removePerFrameHandler;
                        };

                        _unit setVariable [QGVAR(pneumothorax), _ptxTarget, true];
                        [_unit, 0.5 * (_ptxTarget / 4)] call ACEFUNC(medical_status,adjustPainLevel); // Adjust pain based on severity
                        [_unit, -15, -15, "ptx_tension"] call EFUNC(circulation,updateBloodPressureChange); // Emulate low blood pressure and high heart rate caused by pneumothorax
                    };

                }, GVAR(deterioratingPneumothorax_interval), [_unit, _chanceIncrease, _fnc_inflictAdvancedPneumothorax]] call CBA_fnc_addPerFrameHandler;
            };
        }, [_unit, _chanceIncrease, _fnc_inflictAdvancedPneumothorax], GVAR(deterioratingPneumothorax_interval)] call CBA_fnc_waitAndExecute;
    } else {
        if (_unit getVariable [QGVAR(tensionpneumothorax), false]) then { // If already afflicted with tensionpneumothorax -> fully deteriorate pneumothorax
            _unit setVariable [QGVAR(pneumothorax), 4, true];
            _unit setVariable [QGVAR(activeChestSeal), false, true];
        } else {
            if (GVAR(advPtxEnable)) then {
                // Roll chance to get advanced pneumothorax while afflicted with early stage of pneumothorax
                [_unit, _chanceIncrease] call _fnc_inflictAdvancedPneumothorax;
            };
        };
    };
} else { // Damage threshold was passed but no pneumothorax given, try to just give injury instead
    if (floor (random 100) <= GVAR(deepPenetratingInjuryChance)) then {
        _unit setVariable [QGVAR(deepPenetratingInjury), true, true];
    };
};