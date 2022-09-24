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
    ["handleBreathing", [_unit], _unit] call CBA_fnc_targetEvent;
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

    if ((_unit getVariable ["KAT_medical_tensionpneumothorax", false]) || (_unit getVariable ["KAT_medical_hemopneumothorax", false]) || (_unit getVariable ["KAT_medical_pneumothorax", false])) then {
        _breathing = false;
    };

    if ((_unit getVariable ["KAT_medical_airwayOccluded", false]) || (_unit getVariable [QEGVAR(airway,obstruction), false])) then {
        _airway = false;
    };

    private _status = _unit getVariable ["KAT_medical_airwayStatus", 100];
    private _overstretch = _unit getVariable [QEGVAR(airway,overstretch), false];
    private _heartRate = _unit getVariable ["ace_medical_heartRate", 0];
    private _blockDeath = _unit getVariable ["ace_medical_deathblocked", false];

    private _output = 0;
    private _finalOutput = 0;
    private _multiplierPositive = GVAR(SpO2_MultiplyPositive);
    private _multiplierNegative = GVAR(SpO2_MultiplyNegative);

    //if lethal SpO2 value is activated and lower the value x, then kill _unit
    if ((_status <= GVAR(SpO2_dieValue)) && { GVAR(SpO2_dieActive) && { !_blockDeath } }) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        [_unit, "terminal_SpO2_death"] call ace_medical_status_fnc_setDead;
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    //if the _unit has SpO2 equal/over 100, then remove the PFH
    if (_status > 100) exitWith {
        _unit setVariable ["KAT_medical_airwayStatus", 100, true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    if !([_unit] call ace_common_fnc_isAwake) exitWith {
        if !(_breathing) exitWith {
            _output = -0.3 * _multiplierNegative;
            _finalOutput = _status + _output;

            if (_finalOutput > 100) then {
                _finalOutput = 100;
            };

            if (_finalOutput < 1) then {
                _finalOutput = 1;
            };

            _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];
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

            _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];
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

        _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];
    };

    if ([_unit] call ace_common_fnc_isAwake) exitWith {
        if !(_breathing) then {
            _output = -0.2 * _multiplierNegative;
        } else {
            _output = 0.5 * _multiplierPositive;
        };

        _finalOutput = _status + _output;

        if (_finalOutput < 1) then {
            _finalOutput = 1;
        };

        _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];
    if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_finalOutput <= GVAR(SpO2_unconscious)}) then {
            ["ace_medical_CriticalVitals", _unit] call CBA_fnc_localEvent;
        };
    };

}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;
