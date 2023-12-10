#include "..\script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Local call for fully healing a fracture.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Entry <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "_entry"] call kat_surgery_fnc_closedFractureLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _airway = LSTRING(Ultra_Airway_Normal);
private _cardiac = LSTRING(Ultra_Airway_Normal);
private _thorasic = LSTRING(Ultra_Airway_Normal);

_patient setVariable [QGVAR(imaging), true, true];

if (_patient getVariable [QEGVAR(breathing,hemopneumothorax), false]) then {
    _airway = LSTRING(Ultra_Thorasic_Hemo);
};

/*if (_patient getVariable [QEGVAR(breathing,pneumothorax, false]) then {
    _airway = LSTRING(Ultra_Airway_PTX);
};*/

if (_patient getVariable [QEGVAR(breathing,tensionpneumothorax), false]) then {
    _airway = LSTRING(Ultra_Thorasic_Tension);
};

switch (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0]) do {
    case 4: {
         _cardiac = LSTRING(Ultra_Cardiac_VT);
    };
    case 3: {
        _cardiac = LSTRING(Ultra_Cardiac_VF);
    };
    case 2: {
        _cardiac = LSTRING(Ultra_Cardiac_PEA);
    };
    case 1: {
        _cardiac = LSTRING(Ultra_Cardiac_Asystole);
    };
    default {
        _cardiac = LSTRING(Ultra_Airway_Normal);
    };
};

[_patient, "quick_view", LSTRING(Ultra_Airway), [_airway]] call ace_medical_treatment_fnc_addToLog;
[_patient, "quick_view", LSTRING(Ultra_Cardiac), [_cardiac]] call ace_medical_treatment_fnc_addToLog;
[_patient, "quick_view", LSTRING(Ultra_Thorasic), [_thorasic]] call ace_medical_treatment_fnc_addToLog;

