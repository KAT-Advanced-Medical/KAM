#include "..\script_component.hpp"
/*
 * Author: Katalam, edited by Tomcat, Kygan, YetheSamartaka and Mazinski
 * Handling oxygen saturation for breathing
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_breathing_fnc_handleBreathing;
 *
 * Public: No
 */

params ["_unit"];

//Other mods can utilise KAT_SpO2Change_Exclusion variable to prevent occlusions from happening
if ((_unit getVariable ["kat_O2Breathing_PFH", false]) || !(GVAR(enable)) || (_unit getVariable ["KAT_SpO2Change_Exclusion", false])) exitWith {};
_unit setVariable ["kat_O2Breathing_PFH", true];

if (!local _unit) then {
    [QGVAR(handleBreathing), [_unit], _unit] call CBA_fnc_targetEvent;
};
private _occlusionArray = _patient getVariable [QEGVAR(airway,occlusion), [0, 0, 0]];
private _obstructionArray = _patient getVariable [QEGVAR(airway,obstruction), [0, 0, 0]];
private _catastrophicState = _unit getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
private _hasCatastrophicAirway = ((_catastrophicState select 0) || (_catastrophicState select 1));
if ((_unit getVariable [QEGVAR(airway,airway_item), ""]) isEqualTo "NPA") then {
    _occlusionArray = _occlusionArray select [1,2];
    _obstructionArray = _obstructionArray select [1,2];
    _hasCatastrophicAirway = _catastrophicState select 1;
};
private _occlusion = (_occlusionArray findIf { _x > 4 }) != -1;
private _obstruction = (_obstructionArray findIf { _x != 0 }) != -1;


[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        _unit setVariable ["kat_O2Breathing_PFH", nil];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    
    private _airway = true;
    private _breathing = true;

    if ((_tension select 0) || (_tension select 1) || (_hemo select 0) || (_hemo select 1)) then {
        _breathing = false;
    };
    private _noETT = (_patient getVariable [QEGVAR(airway,airway_item), ""] isNotEqualTo "ETT");
    private _noSurgicalAirway = (_patient getVariable [QEGVAR(airway,airway_item), ""] isNotEqualTo "Surgical_Airway");
    private _noOverstretch = _patient getVariable [QEGVAR(airway,overstretch), false];
    if (((((_obstruction && !_noOverstretch) || _occlusion) && _noETT) || _hasCatastrophicAirway) && _noSurgicalAirway) then {
        _airway = false;
    };

    private _isAwake = [_unit] call ACEFUNC(common,isAwake);

    private _spo2 = GET_KAT_SPO2(_patient);
    private _overstretch = _unit getVariable [QEGVAR(airway,overstretch), false];
    private _heartRate = _unit getVariable [QACEGVAR(medical,heartRate), 0];
    private _blockDeath = _unit getVariable [QACEGVAR(medical,deathblocked), false];
    private _BVMInUse = _unit getVariable [QGVAR(BVMInUse), false];
    private _oxygenAssisted = _unit getVariable [QGVAR(oxygenTankConnected), false];

    private _pneumothorax = _unit getVariable [QGVAR(pneumothorax), 0];

    private _output = 0;
    private _finalOutput = 0;
    private _multiplierPositive = GVAR(SpO2_MultiplyPositive);
    private _multiplierNegative = GVAR(SpO2_MultiplyNegative);
    private _multiplierOxygen = GVAR(BVMOxygen_Multiplier);
    private _perfusionActive = false;

    if (GVAR(SpO2_cardiacActive)) then {
        private _ht = _unit getVariable [QEGVAR(circulation,ht), []];

        if (_spo2 <= GVAR(SpO2_cardiacValue)) then {
            if ((_ht findIf {_x isEqualTo "hypoxia"}) == -1) then {
                _ht pushBack "hypoxia";

                if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                };

                _unit setVariable [QEGVAR(circulation,ht), _ht, true];
            };
        } else {
            _ht deleteAt (_ht find "hypoxia");
            _unit setVariable [QEGVAR(circulation,ht), _ht, true];
        };
    };

    //if lethal SpO2 value is activated and lower the value x, then kill _unit
    if ((_spo2 <= GVAR(SpO2_dieValue)) && { GVAR(SpO2_dieActive) && { !_blockDeath } }) exitWith {
        [_unit, "terminal_SpO2_death"] call ACEFUNC(medical_status,setDead);
        _unit setVariable ["kat_O2Breathing_PFH", nil];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    //if the _unit has SpO2 equal/over 100, then remove the PFH
    if (_spo2 >= 100 && {_isAwake && {_breathing && {_pneumothorax == 0}}}) exitWith {
        _unit setVariable [QGVAR(airwayStatus), 100, true];
        _unit setVariable ["kat_O2Breathing_PFH", nil];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    // Unconscious
    if !(_isAwake) exitWith {
        _output = -0.2; // Not breathing/blocked airway

        if (_breathing) then { // Breathing
            if (_airway) then { // Clear airway
                // Low heart rate / cardiac arrest (0)
                if (_heartRate < 20 && {GVAR(SpO2_perfusion)}) exitWith {
                    _perfusionActive = true;
                    if(_BVMInUse) then {
                        if(_oxygenAssisted) then {
                            _output = -0.01;
                        } else {
                            _output = -0.1;
                        };
                    };
                };

                // Normal(-ish) heart rate
                if (_heartRate >= 25) exitWith {
                    if (_BVMInUse) then {
                        if(_oxygenAssisted) then {
                            _output = 0.8 * _multiplierOxygen;
                        } else {
                            _output = 0.45;
                        };
                    } else {
                        _output = 0.3;
                    };
                };

                _output = 0; // SpO2_perfusion is false
            } else {// Obstruction with hyperextended head
                if (_overstretch && _obstruction && !(_occlusion) && _heartRate >= 25) exitWith {
                    if(_BVMInUse) then {
                        if(_oxygenAssisted) then {
                            _output = 0.5 * _multiplierOxygen;
                        } else {
                            _output = 0.24;
                        };
                    } else {
                        _output = 0.12;
                    };
                };
            };
        };

        if (_pneumothorax > 0) then {
            _output = (_output - (0.81 * (_pneumothorax / 4))) max -0.2; // Decrease breathing rate based on pneumothorax severity, maximum decrease should be -0.2
        };

        if (_output > 0) then {
            _output = _output * _multiplierPositive;
        } else {
            if (_perfusionActive) then {
                _output = _output * GVAR(SpO2_PerfusionMultiplier);
            } else {
                _output = _output * _multiplierNegative;
            };
        };

        _finalOutput = _spo2 + _output;

        if (_finalOutput > 100) then {
            _finalOutput = 100;
        };

        if (_finalOutput < 1) then {
            _finalOutput = 1;
        };

        _unit setVariable [QGVAR(airwayStatus), _finalOutput, true];
    };

    // Awake
    if (_isAwake) exitWith {
        if !(_breathing) then {
            _output = -0.2 * _multiplierNegative;
        } else {
            if (_pneumothorax isEqualTo 0) then {
                _output = 0.5 * _multiplierPositive; // Normal breathing
            } else {
                _output = ((0.5 - (0.8 * _pneumothorax / 4)) max -0.2) * _multiplierNegative; // Decrease breathing rate based on pneumothorax severity, maximum decrease should be -0.2
            };
        };

        _finalOutput = _spo2 + _output;

        if (_finalOutput > 100) then {
            _finalOutput = 100;
        };

        if (_finalOutput < 1) then {
            _finalOutput = 1;
        };

        _unit setVariable [QGVAR(airwayStatus), _finalOutput, true];

        if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_finalOutput <= GVAR(SpO2_unconscious)}) then {
            [QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
        };

        if(GVAR(staminaLossAtLowSPO2)) then {
            if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_finalOutput <= GVAR(lowSPO2Level)}) then {
                if (ACEGVAR(advanced_fatigue,enabled)) then {
                    ["kat_LSDF", 1.5] call ACEFUNC(advanced_fatigue,addDutyFactor);
                } else {
                    _unit setStamina(getStamina _unit - 3);
                };
            } else {
                ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
            };
        };

        if ((_unit getVariable [QGVAR(tensionpneumothorax), [false, false]] select 0) || (_unit getVariable [QGVAR(tensionpneumothorax), [false, false]] select 1) ||(_unit getVariable [QGVAR(hemopneumothorax), [false, false]] select 0) || (_unit getVariable [QGVAR(hemopneumothorax), [false, false]] select 1)) then {
            if (!(_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) && !(_unit getVariable [QGVAR(PneumoBreathCooldownOn), false])) then {
                _unit setVariable [QGVAR(PneumoBreathCooldownOn), true, true];

                private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];

                if (_soundTargets isNotEqualTo []) then {
                    [QGVAR(playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
                };

                [{
                    params["_unit"];
                    _unit setVariable [QGVAR(PneumoBreathCooldownOn), false, true];
                },
                [_unit], 30] call CBA_fnc_waitAndExecute;
            };
        };
        if (_occlusion) then {
            if (!(_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) && !(_unit getVariable [QGVAR(CoughCooldownOn), false])) then {
                _unit setVariable [QGVAR(CoughCooldownOn), true, true];
                _occlusionArray set [0, ((_occlusionArray select 0) - 0.25) max 0];
                _occlusionArray set [1, ((_occlusionArray select 1) - 0.25) max 0];
                _occlusionArray set [2, ((_occlusionArray select 2) - 0.25) max 0];
                _unit setVariable [QGVAR(occlusion), _occlusionArray, true];
                private _sound = selectRandom [
                        QPATHTOF_SOUND(sounds\puking1.wav),
                        QPATHTOF_SOUND(sounds\puking2.wav),
                        QPATHTOF_SOUND(sounds\puking3.wav)
                ];
                playSound3D [_sound, _unit, false, getPosASL _unit, 8, 1, 15];

                [{
                    params["_unit"];
                    _unit setVariable [QGVAR(CoughCooldownOn), false, true];
                },
                [_unit], 5] call CBA_fnc_waitAndExecute;
            };
        };
    };
}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;
