#include "..\script_component.hpp"
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
private _tension = _patient getVariable [QGVAR(tensionpneumothorax), [false, false]];
private _hemo = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
private _occlusion = ((_patient getVariable [QEGVAR(airway,occlusion), [0, 0, 0]]) findIf { _x > 4 }) != -1;
private _obstruction = ((_patient getVariable [QEGVAR(airway,obstruction), [0, 0, 0]]) findIf { _x != 0 }) != -1;
private _hasPneumothorax = (_patient getVariable [QGVAR(pneumothorax), [0, 0]] select 0 > 0 || _patient getVariable [QGVAR(pneumothorax), [0, 0]] select 1 > 0 || (_tension select 0) || (_tension select 1) || (_hemo select 0) || (_hemo select 1));
private _airwaySecure = (_patient getVariable [QEGVAR(airway,airway), false] && !(_occlusion));
private _airwayClear = (!(_obstruction) || (_obstruction && _patient getVariable [QEGVAR(airway,overstretch), false])) && !(_occlusion);
private _simpleSetting = (GVAR(inspectChest_enable) == 1);
private _hintSize = 1.5;
private _hintWidth = 10;


if (GET_HEART_RATE(_patient) isEqualTo 0) then {
    _message = LLSTRING(inspectChest_none);
    _messageLog = LLSTRING(inspectChest_none_log);

    if (_hasPneumothorax && _airwaySecure) then {
        _hintSize = 2;
        if (_simpleSetting) then {
            _hintWidth = 13;
            private _type = LLSTRING(Pneumothorax);
            private _type_log = LLSTRING(Pneumothorax_short);

            if ((_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select 0) || (_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select 1)) then {
                _type = LLSTRING(Hemopneumothorax);
                _type_log = LLSTRING(Hemopneumothorax_short);
            };

            _message = _message + "<br />" + format [LLSTRING(inspectChest_simple), _type];
            _messageLog = _messageLog + format [" (%1)", _type_log];
        } else {
            _message = format ["%1<br />%2", _message, LLSTRING(inspectChest_uneven)];
            _messageLog = format ["%1%2", _messageLog, LLSTRING(inspectChest_uneven_log)];
        };
    };
} else {
    if (_hasPneumothorax && (_airwaySecure || _airwayClear)) then {
        private _tension = _patient getVariable [QGVAR(tensionpneumothorax), [false, false]];
        private _hemo = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
        if ((_tension select 0) || (_tension select 1) || (_hemo select 0) || (_hemo select 1)) then {
            _message = LLSTRING(inspectChest_none);
            _messageLog = LLSTRING(inspectChest_none_log);
        } else {
            _message = LLSTRING(inspectChest_unevenMovement);
            _messageLog = LLSTRING(inspectChest_unevenMovement);
        };
        if (_simpleSetting) then {
            _hintSize = 2;
            _hintWidth = 13;
            private _type = LLSTRING(Pneumothorax);
            private _type_log = LLSTRING(Pneumothorax_short);

            if ((_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select 0) || (_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select 1)) then {
                _hintSize = 2.5;
                _type = LLSTRING(Hemopneumothorax);
                _type_log = LLSTRING(Hemopneumothorax_short);
            };

            _message = _message + "<br />" + format [LLSTRING(inspectChest_simple), _type];
            _messageLog = _messageLog + format [" (%1)", _type_log];
        } else {
            _message = format ["%1<br />%2", _message, LLSTRING(inspectChest_uneven)];
            _messageLog = format ["%1%2", _messageLog, LLSTRING(inspectChest_uneven_log)];
        };
    } else {
        if !(_airwayClear) then {
            _message = LLSTRING(inspectChest_none);
            _messageLog = LLSTRING(inspectChest_none_log);
        };
    };
};

[_patient, "quick_view", LSTRING(inspectChest_log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(inspectChest_log), [[_medic] call ACEFUNC(common,getName), _messageLog]] call ACEFUNC(medical_treatment,addToLog);

if (((_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select 0) || (_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select 1)) && {!_simpleSetting}) then {
    _message = format ["%1<br />%2", _message, LLSTRING(inspectChest_internalBleeding)];
    [_patient, "quick_view", LSTRING(inspectChest_log), [[_medic] call ACEFUNC(common,getName), LLSTRING(inspectChest_internalBleeding)]] call ACEFUNC(medical_treatment,addToLog);
};

[_message, _hintSize, _medic, _hintWidth] call ACEFUNC(common,displayTextStructured);
