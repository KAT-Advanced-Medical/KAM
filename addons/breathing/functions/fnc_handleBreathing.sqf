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
    private _status = _unit getVariable ["KAT_medical_airwayStatus", 50];
    private _occluded = _unit getVariable ["KAT_medical_airwayOccluded", false];
    private _obstruction = _unit getVariable [QEGVAR(airway,obstruction), false];
    private _output = 0;
    private _finalOutput;

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
        if (_occluded == true) then {
            _output = _output - 0.5;
        } else {
            _output = _output + 0.25;
        };

        if (_obstruction == true) then {
            _output = _output - 0.5;
        } else {
            _output = _output + 0.25;
        };

        if (_pneumothorax == true || _hemothorax == true) then {
            _output = -0.5;
        };

        _finalOutput = _status + _output;
        _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];

        if (_finalOutput > 100) then {
            _finalOutput = 100;
        };

        if (_finalOutput < 5) then {
            _finalOutput = 5;
        };

        _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];
    };

    if ([_unit] call ace_common_fnc_isAwake) exitWith {
        switch (true) do {
            case (true): {
                _output = output + 0.5;
            };
            case (_pneumothorax == true || _hemothorax == true): {
                _output = _output - 1;
            };
        };

        _finalOutput = _status + _output;
        _unit setVariable ["KAT_medical_airwayStatus", _finalOutput, true];

        if (_finalOutput < 5) then {
            _finalOutput = 5;
        };
    };

}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;

