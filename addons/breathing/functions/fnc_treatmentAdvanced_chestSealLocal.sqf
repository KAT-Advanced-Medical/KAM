#include "..\script_component.hpp"
/*
 * Author: Katalam, modified by Kygan, YetheSamartaka and Tomcat.
 * handles chest seal treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_treatmentAdvanced_chestSealLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (GVAR(clearChestSealAfterTreatment)) then {
    if (_patient getVariable [QGVAR(hemopneumothorax), false] || _patient getVariable [QGVAR(tensionpneumothorax), false]) then {
        _patient setVariable [QGVAR(activeChestSeal), true, true];
    };
} else {
    _patient setVariable [QGVAR(activeChestSeal), true, true];
};
_patient setVariable [QGVAR(deepPenetratingInjury), false, true];
_patient setVariable [QGVAR(pneumothorax), 0, true];

if (!(_patient getVariable [QGVAR(hemopneumothorax), false]) && !(_patient getVariable [QGVAR(tensionpneumothorax), false])) then {
    [_patient, 0, 0, "ptx_tension", true] call EFUNC(circulation,updateBloodPressureChange);
};
