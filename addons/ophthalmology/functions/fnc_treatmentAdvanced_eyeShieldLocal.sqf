#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local callback for placing the eye shield on the injured eye and slowly healing it while worn.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_treatmentAdvanced_eyeShieldLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];
TRACE_2("treatmentAdvanced_eyeShieldLocal",_medic,_patient);

#define IDC_LEFT_EYE_CONTROL 17103
#define IDC_RIGHT_EYE_CONTROL 17102

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];

// Index 0 is the left eye, index 1 the right eye
private _eyeIndex = parseNumber ((_eyeInjuries select 1) < (_eyeInjuries select 0));
private _shieldItem = ["kat_eyecovers_left", "kat_eyecovers_right"] select _eyeIndex;

// If patient has NVGs on, move them to the patient's inventory, or drop them if it is full
private _hmd = hmd _patient;
if (_hmd != "") then {
    _patient unlinkItem _hmd;
    [_patient, _hmd, true, true] call CBA_fnc_addItem;
};

_patient linkItem _shieldItem;

private _showOverlay = _patient == ACE_player;

if (_showOverlay) then {
    "KAT_EyeShield" cutRsc ["KAT_EyeShield", "PLAIN", 0, true];

    private _display = uiNamespace getVariable ["KAT_EyeShield", displayNull];
    private _activeEye = _display displayCtrl ([IDC_LEFT_EYE_CONTROL, IDC_RIGHT_EYE_CONTROL] select _eyeIndex);

    _activeEye ctrlShow true;
    _activeEye ctrlCommit 0;
};

// Approximately 8 minutes to fully re-heal a damaged eye using the eyeshield
[{
    params ["_args", "_pfhID"];
    _args params ["_patient", "_eyeIndex", "_shieldItem", "_showOverlay"];

    if (!alive _patient || {(hmd _patient) != _shieldItem}) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;

        if (_showOverlay) then {
            "KAT_EyeShield" cutText ["", "PLAIN", 0, true];
        };
    };

    private _eyeInjury = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
    _eyeInjury set [_eyeIndex, ((_eyeInjury select _eyeIndex) + 0.002) min 1];
    _patient setVariable [QGVAR(eyeInjuries), _eyeInjury, true];
}, 1, [
    _patient,
    _eyeIndex,
    _shieldItem,
    _showOverlay
]] call CBA_fnc_addPerFrameHandler;
