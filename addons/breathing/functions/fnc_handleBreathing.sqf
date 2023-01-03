#include "script_component.hpp"
/*
 * Author: Katalam, edited by Tomcat, Kygan, YetheSamartaka and MJSTIC
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
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    private _airway = true;
    private _breathing = true;

    if ((_unit getVariable [QGVAR(tensionpneumothorax), false]) || (_unit getVariable [QGVAR(hemopneumothorax), false]) || (_unit getVariable [QGVAR(pneumothorax), false])) then {
        _breathing = false;
    };

    if ((_unit getVariable [QEGVAR(airway,occluded), false]) || (_unit getVariable [QEGVAR(airway,obstruction), false])) then {
        _airway = false;
    };

    private _status = _unit getVariable [QGVAR(airwayStatus), 100];
    private _overstretch = _unit getVariable [QEGVAR(airway,overstretch), false];
    private _heartRate = _unit getVariable [QACEGVAR(medical,heartRate), 0];
    private _blockDeath = _unit getVariable [QACEGVAR(medical,deathblocked), false];

    private _output = 0;
    private _finalOutput = 0;
    private _multiplierPositive = GVAR(SpO2_MultiplyPositive);
    private _multiplierNegative = GVAR(SpO2_MultiplyNegative);

    //if lethal SpO2 value is activated and lower the value x, then kill _unit
    if ((_status <= GVAR(SpO2_dieValue)) && { GVAR(SpO2_dieActive) && { !_blockDeath } }) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        [_unit, "terminal_SpO2_death"] call ACEFUNC(medical,setDead);
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    //if the _unit has SpO2 equal/over 100, then remove the PFH
    if (_status > 100) exitWith {
        _unit setVariable [QGVAR(airwayStatus), 100, true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    if !([_unit] call ACEFUNC(common,isAwake)) exitWith {
        if !(_breathing) exitWith {
            _output = -0.3 * _multiplierNegative;
            _finalOutput = _status + _output;

            if (_finalOutput > 100) then {
                _finalOutput = 100;
            };

            if (_finalOutput < 1) then {
                _finalOutput = 1;
            };

            _unit setVariable [QGVAR(airwayStatus), _finalOutput, true];
        };

        if !(_airway) exitWith {
            _output = -0.3 * _multiplierNegative;

            if (_overstretch && ((_unit getVariable [QEGVAR(airway,obstruction), false]) || _breathing)) then {
                if ((_heartRate < 20) && {GVAR(SpO2_perfusion)}) then {
                    _output = -0.2 * GVAR(SpO2_PerfusionMultiplier);
                } else {
                    _output = 0.15 * _multiplierPositive;
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

        if ((_heartRate < 20) && {GVAR(SpO2_perfusion)}) then {
            _output = -0.2 * GVAR(SpO2_PerfusionMultiplier);
        };

        if (_heartRate >= 25) then {
            _output = 0.3 * _multiplierPositive;
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

    if ([_unit] call ACEFUNC(common,isAwake)) exitWith {
        if !(_breathing) then {
            _output = -0.2 * _multiplierNegative;
        } else {
            _output = 0.5 * _multiplierPositive;
        };

        _finalOutput = _status + _output;

        if (_finalOutput < 1) then {
            _finalOutput = 1;
        };

        _unit setVariable [QGVAR(airwayStatus), _finalOutput, true];
        if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_finalOutput <= GVAR(SpO2_unconscious)}) then {
            [QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
        };
        
        if (GVAR(enableSPO2Flashing)) then {
            if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_finalOutput <= 90}) then {
                ["ColorCorrections", 1500, [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]]] spawn
                {
                    params ["_name", "_priority", "_effect", "_handle"];
                    while {
                        _handle = ppEffectCreate [_name, _priority];
                        _handle < 0
                    } do {
                        _priority = _priority + 1;
                    };
                    _handle ppEffectEnable true;
                    _handle ppEffectAdjust _effect;
                    _handle ppEffectCommit 0.7;

                    [{  params["_handle"];
                        ppEffectCommitted _handle
                    }, 
                    {   params["_handle"];           
                        _handle ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.5], [1, 1, 1, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
                        _handle ppEffectCommit 0.7;

                        [{  params["_handle"];
                            ppEffectCommitted _handle
                        }, 
                        {   params["_handle"];
                            _handle ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
                            _handle ppEffectCommit 1.6;       
                            
                            [{  params["_handle"];
                                ppEffectCommitted _handle
                            }, 
                            {   params["_handle"];           
                                _handle ppEffectEnable false;
                                ppEffectDestroy _handle;
                            }, [_handle]] call CBA_fnc_waitUntilAndExecute;

                        }, [_handle]] call CBA_fnc_waitUntilAndExecute;

                    }, [_handle]] call CBA_fnc_waitUntilAndExecute;
                };
            };
        };

        if(GVAR(staminaLossAtLowSPO2)) then {
            if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_finalOutput <= 90}) then {
                if (ACEGVAR(advanced_fatigue,enabled)) then {
                    
                    ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) - 30;

                } else {
                    
                    _unit setStamina(getStamina _unit - 3);

                };
            };
        };
    };
}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;
