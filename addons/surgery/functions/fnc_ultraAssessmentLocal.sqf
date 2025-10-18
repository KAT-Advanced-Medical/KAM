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
private _thorasicRight = LSTRING(Ultra_Airway_Normal);
private _lungStatus = LSTRING(Ultra_Airway_Normal);
private _occlusion = ((_patient getVariable [QEGVAR(airway,occlusion), [0, 0, 0]]) findIf { _x > 2 }) != -1;
private _obstruction = ((_patient getVariable [QEGVAR(airway,obstruction), [0, 0, 0]]) findIf { _x != 0 }) != -1;
private _catastrophicState = _patient getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
private _hasCatastrophicAirway = (_catastrophicState select 0) || (_catastrophicState select 1);

_patient setVariable [QGVAR(imaging), true, true];

if ((_occlusion) || (_obstruction) || (_hasCatastrophicAirway)) then {
    _airway = LSTRING(Ultra_Airway_Compromise);
};

//Reads Thorasic Condition
if (_patient getVariable [QEGVAR(breathing,pneumothorax), [0, 0]] select 0 > 0) then {
    _thorasic = LSTRING(Ultra_Thorasic_PTX);
};

if (_patient getVariable [QEGVAR(breathing,pneumothorax), [0, 0]] select 1 > 0) then {
    _thorasicRight = LSTRING(Ultra_Thorasic_Right_PTX);
};

if (_patient getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]] select 0) then {
    _thorasic = LSTRING(Ultra_Thorasic_Hemo);
};

if (_patient getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]] select 1) then {
    _thorasicRight = LSTRING(Ultra_Thorasic_Right_Hemo);
};

if (_patient getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]] select 0) then {
    _thorasic = LSTRING(Ultra_Thorasic_Tension);
};

if (_patient getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]] select 1) then {
    _thorasicRight = LSTRING(Ultra_Thorasic_Right_Tension);
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
private _lungVolume = GET_KAT_SURFACE_AREA(_patient);
switch (true) do {
    case (_lungVolume < 350): {
        _lungStatus = LSTRING(Ultra_Lung_Status_1);
    };
    case (_lungVolume < 300): {
        _lungStatus = LSTRING(Ultra_Lung_Status_2);
    };
    case (_lungVolume < 250): {
        _lungStatus = LSTRING(Ultra_Lung_Status_3);
    };
    case (_lungVolume < 200): {
        _lungStatus = LSTRING(Ultra_Lung_Status_4);
    };
    default {
        _lungStatus = LSTRING(Ultra_Lung_Status_0);
    };
};

if (_patient getVariable [QEGVAR(circulation,effusion), 0] > 0) then {
    _cardiac = LSTRING(Ultra_Cardiac_Tamponade);
};

if !(alive _patient) then {
    _cardiac = LSTRING(Ultra_Cardiac_Unshockable);
    _thorasic = LSTRING(Ultra_Thorasic_NoActivity);
    _thorasicRight = LSTRING(Ultra_Thorasic_NoActivity);
    _airway = LSTRING(Ultra_Airway_NoActivity);
};

[_patient, "quick_view", LSTRING(Ultra_Airway)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(Ultra_Cardiac)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(Ultra_Thorasic)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(Ultra_ThorasicRight)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(Ultra_LungStatus)] call EFUNC(circulation,removeLog);


[_patient, "quick_view", LSTRING(Ultra_Airway), [_airway]] call ACEFUNC(medical_treatment,addToLog);
[_patient, "quick_view", LSTRING(Ultra_Cardiac), [_cardiac]] call ACEFUNC(medical_treatment,addToLog);
[_patient, "quick_view", LSTRING(Ultra_Thorasic), [_thorasic]] call ACEFUNC(medical_treatment,addToLog);
[_patient, "quick_view", LSTRING(Ultra_ThorasicRight), [_thorasicRight]] call ACEFUNC(medical_treatment,addToLog);
[_patient, "quick_view", LSTRING(Ultra_LungStatus), [_lungStatus]] call ACEFUNC(medical_treatment,addToLog);