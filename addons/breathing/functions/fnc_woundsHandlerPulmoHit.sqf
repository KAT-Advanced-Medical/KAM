#include "..\script_component.hpp"
/*
 * Author: Katalam, LinkIsGrim
 * Called when a unit is damaged.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *    0: Engine damage <NUMBER>
 *    1: Body part <STRING>
 *    2: Real damage <NUMBER>
 * 2: Damage type (unused) <STRING>
 * 3: Ammo (unused) <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_breathing_fnc_woundsHandlerPulmoHit
 *
 * Public: No
 */

params ["_unit", "_allDamages"];
(_allDamages select 0) params ["_engineDamage", "_bodyPart"]; // selection-specific

if !(GVAR(enable) && _bodyPart == "body") exitWith {_this};

//Other mods can utilise KAT_Pneumothorax_Exclusion variable to prevent Pneumothorax from happening
if (_engineDamage < GVAR(pneumothoraxDamageThreshold) || _unit getVariable ["KAT_Pneumothorax_Exlusion", false]) exitWith {_this};

private _chanceIncrease = 0;
if (GVAR(pneumothoraxDamageThreshold_TakenDamage)) then {
    _chanceIncrease = linearConversion [GVAR(pneumothoraxDamageThreshold), 3, _engineDamage, 0, 30, true];
};

// Damage threshold passed & pneumothorax given
if (floor (random 100) < (GVAR(pneumothoraxChance) + _chanceIncrease)) exitWith {
    private _hasTensionPneumothorax = _unit getVariable [QGVAR(tensionpneumothorax), false];
    private _initialPneumothorax = (_unit getVariable [QGVAR(pneumothorax), 0]) == 0;

    switch (true) do {
        case (_hasTensionPneumothorax): { // fully deteriorate pneumothorax
            _unit setVariable [QGVAR(pneumothorax), 4, true];
            _unit setVariable [QGVAR(activeChestSeal), false, true];
        };
        case (_initialPneumothorax): {
            // Set pain to at least 0.2
            [_unit, 0.2] call ACEFUNC(medical_status,adjustPainLevel);

            // add breathing sound
            _unit setVariable [QGVAR(pneumothorax), 1, true];
            _unit setVariable [QGVAR(deepPenetratingInjury), true, true];
            _unit setVariable [QGVAR(activeChestSeal), false, true];

            // Start deteriorating after delay
            [_unit, _chanceIncrease] call FUNC(handlePneumothoraxDeterioration);
        };

        case (GVAR(advPtxEnable)): {
            // Roll chance to get advanced pneumothorax while afflicted with early stage of pneumothorax
            [_unit, _chanceIncrease] call FUNC(inflictAdvancedPneumothorax);
        };
    };

    _this // return
};

// Damage threshold was passed but no pneumothorax given, try to just give injury instead

// No injury
if (floor (random 100) >= GVAR(deepPenetratingInjuryChance)) exitWith {_this};

_unit setVariable [QGVAR(deepPenetratingInjury), true, true];
_unit setVariable [QGVAR(activeChestSeal), false, true];

// Check for tamponade

// Unit already has it or got lucky
if ((_unit getVariable [QEGVAR(circulation,effusion), 0]) != 0 || floor (random 100) > EGVAR(circulation,tamponadeChance)) exitWith {_this};

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

_this // return
