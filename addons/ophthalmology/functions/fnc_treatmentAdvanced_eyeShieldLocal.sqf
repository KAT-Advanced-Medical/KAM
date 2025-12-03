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

#define IDC_LEFT_EYE_CONTROL 17103
#define IDC_RIGHT_EYE_CONTROL 17102

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];

// Show the overlay
private _fnc_applyEyeCover = {
    params ["_patient", "_eyeDisplay", "_shieldItem"];

    // Handle NVGs properly
    private _nvg = hmd _patient;
    if (_nvg != "") then {
        _patient unlinkItem _nvg;
        _patient addItem _nvg;
    };

    // Create a local layer for this client only
    private _layer = ["KAT_EyeShield"] call BIS_fnc_rscLayer;
    _layer cutRsc ["KAT_EyeShield", "PLAIN", 0, true];

    // Apply the eye cover item
    _patient linkItem _shieldItem;

    // Start healing PFH (runs locally)
    [{
        params ["_args", "_pfhID"];
        _args params ["_patient", "_shieldItem", "_layer"];

        private _display = uiNamespace getVariable [QGVAR(eyeShield), displayNull];
        if (isNull _display) exitWith {
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };

        private _eyeIndex = -1;
        private _eyeCtrl = controlNull;

        switch (hmd _patient) do {
            case "kat_eyecovers_left": {
                _eyeIndex = 0;
                _eyeCtrl = _display displayCtrl IDC_LEFT_EYE_CONTROL;
            };
            case "kat_eyecovers_right": {
                _eyeIndex = 1;
                _eyeCtrl = _display displayCtrl IDC_RIGHT_EYE_CONTROL;
            };
        };

        if (_eyeIndex >= 0) then {
            _eyeCtrl ctrlShow true;
            _eyeCtrl ctrlCommit 0;

            private _eyeInjury = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
            _eyeInjury set [_eyeIndex, (_eyeInjury select _eyeIndex) + 0.002];
            _patient setVariable [QGVAR(eyeInjuries), _eyeInjury, true];
        } else {
            _layer cutText ["", "PLAIN", 0, true];
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };
    }, 1, [_patient, _shieldItem, _layer]] call CBA_fnc_addPerFrameHandler;
};

if ((_eyeInjuries select 0) == 0) then {
    [_patient, IDC_LEFT_EYE_CONTROL, "kat_eyecovers_left"] call _fnc_applyEyeCover;
} else {
    [_patient, IDC_RIGHT_EYE_CONTROL, "kat_eyecovers_right"] call _fnc_applyEyeCover;
};


[_patient, LLSTRING(eyeshield_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyeshield_item)]] call ACEFUNC(medical_treatment,addToLog);