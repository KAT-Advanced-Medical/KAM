#include "script_component.hpp"
/*
 * Author: Katalam
 * docks a pulseoximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "leftarm", "Pulseoximeter"] call KAM_breathing_fnc_treatmentAdvanced_pulseoximeterLocal;
 *
 * Public: No
 */

params ["_caller", "_target", "_selectionName", "_className"];

private _index = ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"] find toLower _selectionName;

private _pulseOxi = _target getVariable [QGVAR(pulseoximeter), [0,0,0,0,0,0]];
_pulseOxi set [_index, 1];
_target setVariable [QGVAR(pulseoximeter), _pulseOxi, true];

private _hr = round (_target getVariable ["ace_medical_heartRate", 80]);
private _spo2 = round (_target getVariable [QGVAR(status), 100]);

[_target, "quick_view", LSTRING(pulseoxi_log), [_hr, _spo2]] call ace_medical_treatment_fnc_addToLog;
[_target, "activity", LSTRING(pulseoxi_log_2), [[_caller] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;

[{
    params ["_args", "_idPFH"];
    _args params ["_target", "_selectionName"];
    if !(count (_target getVariable [QGVAR(pulseoximeter), [0,0,0,0,0,0]]) > 0) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    [_target, "activity", LSTRING(pulseoxi_log)] call FUNC(removeLog);
    [_target, "quick_view", LSTRING(pulseoxi_log)] call FUNC(removeLog);

    private _hr = round (_target getVariable ["ace_medical_heartRate", 80]);
    private _spo2 = round (_target getVariable [QGVAR(status), 100]);

    if ([_target, _selectionName] call ace_medical_treatment_fnc_hasTourniquetAppliedTo) then {
        _hr = 0;
        _spo2 = 0;
    };

    [_target, "activity", LSTRING(pulseoxi_log), [_hr, _spo2]] call ace_medical_treatment_fnc_addToLog;
    [_target, "quick_view", LSTRING(pulseoxi_log), [_hr, _spo2]] call ace_medical_treatment_fnc_addToLog;
}, 1, [_target, _selectionName]] call CBA_fnc_addPerFrameHandler;

_className = str formatText ["KAM_%1", toLower _className];
private _item = if (isClass (configFile >> "CfgWeapons" >> _className)) then {
    getText (configFile >> "CfgWeapons" >> _className >> "displayName");
} else {
    "N/A";
};

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
