#include "script_component.hpp"
/*
 * Author: Katalam
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

if !(GVAR(enable)) exitWith {};

if (_unit getVariable ["kat_O2Breathing_PFH", false]) exitWith {};
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
        _unit setVariable ["KAT_medical_airwayStatus", 100, true];
    };

    private _pneumothorax = _unit getVariable ["KAT_medical_pneumothorax", false];
    private _hemothorax = _unit getVariable ["KAT_medical_hemopneumothorax", false];
    private _status = _unit getVariable ["KAT_medical_airwayStatus", 100];
    private _occluded = _unit getVariable ["KAT_medical_airwayOccluded", false];
    private _obstruction = _unit getVariable [QEGVAR(airway,obstruction), false];
    private _heartRate = _unit getVariable ["ace_medical_heartRate", 0];
    private _output = 0;
    private _finalOutput = 0;
    private _multiplier = GVAR(SpO2_Multiply);
    private _multiplierPositive = GVAR(SpO2_MultiplyPositive);
    private _multiplierNegative = GVAR(SpO2_MultiplyNegative);

    //if lethal SpO2 value is activated and lower the value x, then kill _unit
    if ((_status <= GVAR(SpO2_dieValue)) && {GVAR(SpO2_dieActive)}) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        [_unit, "#setDead"] call ace_medical_status_fnc_setDead;
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    //if the _unit has SpO2 equal/over 100, then remove the PFH
    if (_status > 100) exitWith {
        _unit setVariable ["KAT_medical_airwayStatus", 100, true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    if !([_unit] call ace_common_fnc_isAwake) exitWith {
        if (_occluded == true || _obstruction == true) then {
            _output = _output - (0.75 * _multiplierNegative);
        } else {
            _output = _output + (0.5 * _multiplierPositive);
        };

        if (_pneumothorax == true || _hemothorax == true) then {
            _output = _output - (0.75 * _multiplierNegative);
        };

        if (_heartRate <= 40) then {
            _output = -0.75 * _multiplierNegative;
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
        switch (true) do {
            case (_pneumothorax == true || _hemothorax == true): {
                _output = _output - (0.75 * _multiplierNegative);
            };
            case (true): {
                _output = _output + (1 * _multiplierPositive);
            };
        };

        _finalOutput = _status + _output;

        if (_finalOutput < 1) then {
            _finalOutput = 1;
        };

        _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];
    };

}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;

