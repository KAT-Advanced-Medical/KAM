#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for running the Ultrasound Assessment.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_ultraAssessmentLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _airway = LSTRING(Ultra_Airway_Normal);
private _cardiac = LSTRING(Ultra_Airway_Normal);
private _thorasic = LSTRING(Ultra_Airway_Normal);

_patient setVariable [QGVAR(imaging), true, true];

//Reads Thorasic Condition
if ((_patient getVariable [QEGVAR(breathing,pneumothorax), 0]) != 0) then {
    _thorasic = LSTRING(Ultra_Thorasic_PTX);
};

if (_patient getVariable [QEGVAR(breathing,hemopneumothorax), false]) then {
    _thorasic = LSTRING(Ultra_Thorasic_Hemo);
};

if (_patient getVariable [QEGVAR(breathing,tensionpneumothorax), false]) then {
    _thorasic = LSTRING(Ultra_Thorasic_Tension);
};


//Reads Cardiac Arrest Type, 4 and 3 are VT/VF and are output as "Shockable", 2 and 1 are PEA/Asystole and output as "Not Shockable", 0 is No Arrest
switch (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0]) do {
    case 4: {
         _cardiac = LSTRING(Ultra_Cardiac_Shockable);
    };
    case 3: {
        _cardiac = LSTRING(Ultra_Cardiac_Shockable);
    };
    case 2: {
        _cardiac = LSTRING(Ultra_Cardiac_Unshockable);
    };
    case 1: {
        _cardiac = LSTRING(Ultra_Cardiac_Unshockable);
    };
    default {
        _cardiac = LSTRING(Ultra_Airway_Normal);
    };
};

if (_patient getVariable [QEGVAR(circulation,effusion), 0] > 0) then {
    _cardiac = LSTRING(Ultra_Cardiac_Tamponade);
};

[_patient, "quick_view", LSTRING(Ultra_Airway), [_airway]] call ACEFUNC(medical_treatment,addToLog);
[_patient, "quick_view", LSTRING(Ultra_Cardiac), [_cardiac]] call ACEFUNC(medical_treatment,addToLog);
[_patient, "quick_view", LSTRING(Ultra_Thorasic), [_thorasic]] call ACEFUNC(medical_treatment,addToLog);

