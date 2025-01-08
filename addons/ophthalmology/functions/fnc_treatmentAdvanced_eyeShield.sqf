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

private _eyeInjuries = _patient getVariable ["kat_ophthalmology_eyeInjuries", [1, 1]];

"KAT_EyeShield" cutRsc ["KAT_EyeShield", "PLAIN", 0, true];

private _display = uiNamespace getVariable ["KAT_EyeShield", displayNull];
private _activeEye = _display displayCtrl 17102;

if ((_eyeInjuries find 0) == 0) then {
    _patient linkItem "kat_eyecovers_left";
    _activeEye = _display displayCtrl 17103;

    _activeEye ctrlShow true;
    _activeEye ctrlCommit 0;

    [{
        _this params ["_args", "_pfhID"];
        _args params ["_unit", "_activeEye"];
    
        if ((hmd _unit) != "kat_eyecovers_left") exitWith {
            _pfhID call CBA_fnc_removePerFrameHandler;
            "KAT_EyeShield" cutText ["","PLAIN",0,true];
        };
    
        private _eyeInjury = _unit getVariable ["kat_ophthalmology_eyeInjuries", [1, 1]];
        _unit setVariable ["kat_ophthalmology_eyeInjuries", [(((_eyeInjury select 0) + 0.001) min 1), (_eyeInjury select 1)], true];
    }, 30, [
        _patient,
        _activeEye
    ]] call CBA_fnc_addPerFrameHandler;

} else {
    _patient linkItem "kat_eyecovers_right";
    _activeEye = _display displayCtrl 17102;

    _activeEye ctrlShow true;
    _activeEye ctrlCommit 0;

    [{
        _this params ["_args", "_pfhID"];
        _args params ["_unit", "_activeEye"];
    
        if ((hmd _unit) != "kat_eyecovers_right") exitWith {
            _pfhID call CBA_fnc_removePerFrameHandler;
            "KAT_EyeShield" cutText ["","PLAIN",0,true];
        };
    
        private _eyeInjury = _unit getVariable ["kat_ophthalmology_eyeInjuries", [1, 1]];
        _unit setVariable ["kat_ophthalmology_eyeInjuries", [(_eyeInjury select 0), (((_eyeInjury select 1) + 0.001) min 1)], true];
    }, 1, [
        _patient,
        _activeEye
    ]] call CBA_fnc_addPerFrameHandler;
};

[_patient, LLSTRING(eyeshield_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyeshield_item)]] call ACEFUNC(medical_treatment,addToLog);