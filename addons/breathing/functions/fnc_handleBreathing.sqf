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

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        _unit setVariable ["kat_O2Breathing_PFH", nil];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (!(_unit getVariable [QGVAR(lowSpO2ppActive), false]) && hasInterface && ACE_Player == _unit) then {
        [QGVAR(lowSpO2pp), [_unit], _unit] call CBA_fnc_targetEvent;
    };

    private _airway = true;
    private _breathing = true;

    if ((_unit getVariable [QEGVAR(chemical,airPoisoning), false]) || (_unit getVariable [QGVAR(tensionpneumothorax), false]) || (_unit getVariable [QGVAR(hemopneumothorax), false])) then {
        _breathing = false;
    };

    if ((_unit getVariable [QEGVAR(airway,occluded), false]) || (_unit getVariable [QEGVAR(airway,obstruction), false])) then {
        _airway = false;
    };

    private _status = _unit getVariable [QGVAR(airwayStatus), 100];
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

        if (_status <= GVAR(SpO2_cardiacValue)) then {
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
    if ((_status <= GVAR(SpO2_dieValue)) && { GVAR(SpO2_dieActive) && { !_blockDeath } }) exitWith {
        [_unit, "terminal_SpO2_death"] call ACEFUNC(medical_status,setDead);
        _unit setVariable ["kat_O2Breathing_PFH", nil];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    //if the _unit has SpO2 equal/over 100, then remove the PFH
    if (_status >= 100 && _pneumothorax == 0) exitWith {
        _unit setVariable [QGVAR(airwayStatus), 100, true];
        _unit setVariable ["kat_O2Breathing_PFH", nil];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    // Unconscious
    if !([_unit] call ACEFUNC(common,isAwake)) exitWith {
        _output = -0.2; // Not breathing/blocked airway

        if (_breathing) then { // Breathing
            if (_airway) then { // Clear airway
                // Low heart rate / cardiac arrest (0)
                if (_heartRate < 20 && {GVAR(SpO2_perfusion)}) exitWith {
                    _perfusionActive = true;
                    if(_BVMInUse) then {
                        if(_oxygenAssisted) then {
                            _output = 0.3;
                        } else {
                            _output = 0.1;
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
                if (_overstretch && _unit getVariable [QEGVAR(airway,obstruction), false] && !(_unit getVariable [QEGVAR(airway,occlusion), false]) && _heartRate >= 25) exitWith {
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

        _finalOutput = _status + _output;

        if (_finalOutput > 100) then {
            _finalOutput = 100;
        };

        if (_finalOutput < 1) then {
            _finalOutput = 1;
        };

        _unit setVariable [QGVAR(airwayStatus), _finalOutput, true];
    };

    // Awake
    if ([_unit] call ACEFUNC(common,isAwake)) exitWith {
        if !(_breathing) then {
            _output = -0.2 * _multiplierNegative;
        } else {
            if (_pneumothorax isEqualTo 0) then {
                _output = 0.5 * _multiplierPositive; // Normal breathing
            } else {
                _output = ((0.5 - (0.8 * _pneumothorax / 4)) max -0.2) * _multiplierNegative; // Decrease breathing rate based on pneumothorax severity, maximum decrease should be -0.2
            };
        };

        _finalOutput = _status + _output;

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

        if ((_unit getVariable [QGVAR(pneumothorax), 0] > 0) || _unit getVariable [QGVAR(hemopneumothorax), false] || _unit getVariable [QGVAR(tensionpneumothorax), false]) then {
            if (!(_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) && !(_unit getVariable [QGVAR(PneumoBreathCooldownOn), false])) then {
                _unit setVariable [QGVAR(PneumoBreathCooldownOn), true, true];

                private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];

                if !(_soundTargets isEqualTo []) then {
                    [QGVAR(playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
                };
                
                [{
                    params["_unit"];
                    _unit setVariable [QGVAR(PneumoBreathCooldownOn), false, true];
                },
                [_unit], 30] call CBA_fnc_waitAndExecute;
            };
        };
    };
}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;
