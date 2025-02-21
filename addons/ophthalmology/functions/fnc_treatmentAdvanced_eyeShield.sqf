#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles the placement of the eye shield
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_treatmentAdvanced_eyeShield
 *
 * Public: No
 */
 
params ["_medic", "_patient"];

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];

#define leftEyeDisplay 17103
#define rightEyeDisplay 17102

"KAT_EyeShield" cutRsc ["KAT_EyeShield", "PLAIN", 0, true];

private _display = uiNamespace getVariable ["KAT_EyeShield", displayNull];
private _activeEye = _display displayCtrl rightEyeDisplay;

private _fnc_applyEyeCover = {
    params ["_patient", "_shieldItem", "_eyeDisplay"];

    if (hmd _patient != "") then {
        _patient addItem (hmd _patient);
    };

    _patient linkItem _shieldItem;
    _activeEye = _display displayCtrl _eyeDisplay;

    _activeEye ctrlShow true;
    _activeEye ctrlCommit 0;

    [{
        _this params ["_args", "_pfhID"];
        _args params ["_unit", "_activeEye"];
    
        if ((hmd _unit) != _shieldItem) exitWith {
            _pfhID call CBA_fnc_removePerFrameHandler;
            "KAT_EyeShield" cutText ["","PLAIN",0,true];
        };
    
        private _eyeInjury = _unit getVariable [QGVAR(eyeInjuries), [1, 1]];
        _unit setVariable [QGVAR(eyeInjuries), [(((_eyeInjury select 0) + 0.001) min 1), (_eyeInjury select 1)], true];
    }, 30, [
        _patient,
        _activeEye
    ]] call CBA_fnc_addPerFrameHandler;
};

if ((_eyeInjuries find 0) == 0) then {
    [_patient, "kat_eyecovers_left", leftEyeDisplay] call _fnc_applyEyeCover;
} else {
    [_patient, "kat_eyecovers_right", rightEyeDisplay] call _fnc_applyEyeCover;
};

[_patient, LLSTRING(eyeshield_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyeshield_item)]] call ACEFUNC(medical_treatment,addToLog);