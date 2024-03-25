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

        if (GVAR(PneumothoraxArrest)) then {
            [{
                params ["_args", "_idPFH"];
                _args params ["_unit"];

                if ((_unit getVariable [QGVAR(pneumothorax), 0]) == 4) then {
                    private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
                    if ((_ht findIf {_x isEqualTo "tension"}) == -1) then {
                        _ht pushBack "tension";

                        if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                            [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                        };

                        _unit setVariable [QEGVAR(circulation,ht), _ht, true];
                    };
                };
            }, [_unit], GVAR(arrestPneumothorax_interval)] call CBA_fnc_waitAndExecute;
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

        if ((floor (random 100) <= EGVAR(circulation,tamponadeChance)) && (_unit getVariable [QEGVAR(circulation,effusion), 0] == 0)) then {
            _unit setVariable [QEGVAR(circulation,effusion), 1, true];

            [{
                params ["_unit"];

                if (_unit getVariable [QEGVAR(circulation,effusion), 0] > 0) then {
                    // Try to deteriorate at set interval
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_unit"];

                        private _effusion = _unit getVariable [QEGVAR(circulation,effusion), 0];

                        // If patient is dead, already treated or has already deteriorated into full tamponade, kill the PFH
                        if ((_effusion == 0) || !(alive _unit) || (_effusion == 4)) exitWith {
                            [_idPFH] call CBA_fnc_removePerFrameHandler;
                        };

                        if (floor (random 100) <= EGVAR(circulation,deterioratingTamponade_chance)) then {
                            private _effusionTarget = _effusion + 1;

                            // Once deteriorated far enough try to inflict tamponade
                            if (_effusionTarget == 4) exitWith {
                                private _ht = _unit getVariable [QEGVAR(circulation,ht), []];

                                if ((_ht findIf {_x isEqualTo "tamponade"}) == -1) then {
                                    _ht pushBack "tamponade";

                                    if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                                    };

                                    _unit setVariable [QEGVAR(circulation,ht), _ht, true];
                                };

                                [_idPFH] call CBA_fnc_removePerFrameHandler;
                            };

                            _unit setVariable [QEGVAR(circulation,effusion), _effusionTarget, true];
                            [_unit, 0.5 * (_effusionTarget / 4)] call ACEFUNC(medical_status,adjustPainLevel); // Adjust pain based on severity
                            [_unit, -10, -10, "cardiac_tension"] call EFUNC(circulation,updateBloodPressureChange); // Emulate low blood pressure and low heart rate caused by tamponade
                        };

                    }, EGVAR(circulation,deterioratingTamponade_interval), [_unit]] call CBA_fnc_addPerFrameHandler;
                };
            }, [_unit], EGVAR(circulation,deterioratingTamponade_interval)] call CBA_fnc_waitAndExecute;
        };
    };
};
