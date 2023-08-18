#include "script_component.hpp"
/*
 * Author: Blue
 * Inspect chest for injuries
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_inspectChest;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _message = LLSTRING(inspectChest_normal);
private _messageLog = LLSTRING(inspectChest_normal);

private _hasPneumothorax = (_patient getVariable [QGVAR(pneumothorax), 0] > 0 || _patient getVariable [QGVAR(tensionpneumothorax), false] || _patient getVariable [QGVAR(hemopneumothorax), false]);
private _simpleSetting = (GVAR(inspectChest_enable) == 1);
private _hintSize = 1.5;
private _hintWidth = 10;

if (_patient getVariable [QEGVAR(airway,airway), false] && !(_patient getVariable [QEGVAR(airway,occluded), false])) then {
    if (GET_HEART_RATE(_patient) isEqualTo 0) then {
        _message = LLSTRING(inspectChest_none);
        _messageLog = LLSTRING(inspectChest_none_log);

        if(_hasPneumothorax) then {
            _hintSize = 2;
            if (_simpleSetting) then {
                _hintWidth = 13;
                private _type = "";
                if (_patient getVariable [QGVAR(hemopneumothorax), false]) then {
                    _type = LLSTRING(Hemopneumothorax);
                } else {
                    _type = LLSTRING(Pneumothorax);
                };

                _message = _message + "<br />" + format [LLSTRING(inspectChest_simple), _type];
                _messageLog = _messageLog + format [" (%1)", _type];
            } else {
                _message = format ["%1<br />%2", _message, LLSTRING(inspectChest_uneven)];
                _messageLog = format ["%1%2", _messageLog, LLSTRING(inspectChest_uneven_log)];
            };
        };
    } else {
        if(_hasPneumothorax) then {
            _message = LLSTRING(inspectChest_unevenMovement);
            _messageLog = LLSTRING(inspectChest_unevenMovement);
            
            if (_simpleSetting) then {
                _hintSize = 2;
                _hintWidth = 13;
                private _type = "";
                if (_patient getVariable [QGVAR(hemopneumothorax), false]) then {
                    _type = LLSTRING(Hemopneumothorax);
                } else {
                    _type = LLSTRING(Pneumothorax);
                };

                _message = _message + "<br />" + format [LLSTRING(inspectChest_simple), _type];
                _messageLog = _messageLog + format [" (%1)", _type];
            };
        };
    };
} else {
    _message = LLSTRING(inspectChest_none);
    _messageLog = LLSTRING(inspectChest_none_log);
};

[_patient, "quick_view", LSTRING(inspectChest_log), [[_medic] call ACEFUNC(common,getName), _messageLog]] call ACEFUNC(medical_treatment,addToLog);

if (_patient getVariable [QGVAR(hemopneumothorax), false] && {!_simpleSetting}) then {
    _hintSize = 2.5;
    _hintWidth = 14;
    _message = format ["%1<br />%2", _message, LLSTRING(inspectChest_internalBleeding)];
    [_patient, "quick_view", LSTRING(inspectChest_log), [[_medic] call ACEFUNC(common,getName), LLSTRING(inspectChest_internalBleeding)]] call ACEFUNC(medical_treatment,addToLog);
};

[_message, _hintSize, _medic, _hintWidth] call ACEFUNC(common,displayTextStructured);