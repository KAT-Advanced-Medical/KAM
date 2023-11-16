#include "..\script_component.hpp"
/*
 * Author: Kygan, modified by YetheSamartaka and Tomcat.
 * Treatment for tension pneumothorax
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_tensionpneumothoraxLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (_patient getVariable [QGVAR(activeChestSeal), false]) then {
    _patient setVariable [QGVAR(tensionpneumothorax), false, true];
};

if (!(_patient getVariable [QGVAR(pneumothorax), 0] > 0) && !(_patient getVariable [QGVAR(hemopneumothorax), false]) && !(_patient getVariable [QGVAR(tensionpneumothorax), false])) then {
    [_patient, 0, 0, "ptx_tension", true] call EFUNC(circulation,updateBloodPressureChange);
    if (GVAR(clearChestSealAfterTreatment)) then {
        _patient setVariable [QGVAR(activeChestSeal), false, true];
    };
};
