#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles severe eye damage
 *
 * Return Value:
 * None
 *
 * Example:
 * [patient] call kat_ophthalmology_fnc_treatmentAdvanced_severeEyeInjuryPFH
 *
 * Public: No
 */
 
params ["_patient"];

// Approximately 8 minutes to fully re-heal a damaged eye using the eyeshield
[{
    params ["_args", "_pfhID"];
    _args params ["_patient", "_activeEye", "_shieldItem"];
        
    private _active = false;
    private _activeEye = 0;

    #define IDC_LEFT_EYE_CONTROL 17103
    #define IDC_RIGHT_EYE_CONTROL 17102

    if ((hmd _patient) == "kat_eyecovers_left") then {
        _active = true;
        private _display = uiNamespace getVariable ["KAT_EyeShield", displayNull];
        private _activeEye = _display displayCtrl IDC_LEFT_EYE_CONTROL;
        
        _activeEye ctrlShow true;
        _activeEye ctrlCommit 0;
    }; 
    
    if ((hmd _patient) == "kat_eyecovers_right") then {
        _active = true;
        _activeEye = 1;
        private _display = uiNamespace getVariable ["KAT_EyeShield", displayNull];
        private _activeEye = _display displayCtrl IDC_RIGHT_EYE_CONTROL;
        
        _activeEye ctrlShow true;
        _activeEye ctrlCommit 0;
    };

    if (_active) then {
        private _eyeInjury = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
        _eyeInjury set [_activeEye, ((_eyeInjury select _activeEye) + 0.002)];
        _patient setVariable [QGVAR(eyeInjuries), _eyeInjury, true];
    } else {
        "KAT_EyeShield" cutText ["","PLAIN",0,true];
    };
}, 1, [
    _patient,
    _activeEye,
    _shieldItem
]] call CBA_fnc_addPerFrameHandler;
