#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles the placement of the eye shield
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

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];

#define IDC_LEFT_EYE_CONTROL 17103
#define IDC_RIGHT_EYE_CONTROL 17102

"KAT_EyeShield" cutRsc ["KAT_EyeShield", "PLAIN", 0, true];


private _fnc_applyEyeCover = {
    params ["_patient", "_shieldItem", "_eyeDisplay"];

    // If patient has NVGs on, move them to the patient's inventory
    if (hmd _patient != "") then {
        _patient addItem (hmd _patient);
    };

    private _display = uiNamespace getVariable ["KAT_EyeShield", displayNull];
    private _activeEye = _display displayCtrl _eyeDisplay;

    _patient linkItem _shieldItem;
    
    _activeEye ctrlShow true;
    _activeEye ctrlCommit 0;

    // Approximately 8 minutes to fully re-heal a damaged eye using the eyeshield
    [{
        params ["_args", "_pfhID"];
        _args params ["_patient", "_activeEye", "_shieldItem"];
    
        if ((hmd _patient) != _shieldItem) exitWith {
            _pfhID call CBA_fnc_removePerFrameHandler;
            "KAT_EyeShield" cutText ["","PLAIN",0,true];
        };
    
        private _eyeInjury = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
        _patient setVariable [QGVAR(eyeInjuries), [(((_eyeInjury select 0) + 0.002) min 1), (_eyeInjury select 1)], true];
    }, 1, [
        _patient,
        _activeEye,
        _shieldItem
    ]] call CBA_fnc_addPerFrameHandler;
};

if ((_eyeInjuries select 0) == 0) then {
    [_patient, "kat_eyecovers_left", IDC_LEFT_EYE_CONTROL] call _fnc_applyEyeCover;
} else {
    [_patient, "kat_eyecovers_right", IDC_RIGHT_EYE_CONTROL] call _fnc_applyEyeCover;
};

[_patient, LLSTRING(eyeshield_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyeshield_item)]] call ACEFUNC(medical_treatment,addToLog);
