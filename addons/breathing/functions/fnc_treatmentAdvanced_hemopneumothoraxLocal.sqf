#include "script_component.hpp"
/*
 * Author: Kygan, modified by YetheSamartaka and Tomcat.
 * Treatment for hemopneumothorax
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
 * call kat_breathing_fnc_treatmentAdvanced_hemopneumothoraxLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(GVAR(tensionhemothorax_hardcore)) exitWith {
    if ((_patient getVariable [QGVAR(hemopneumothorax), false]) && {_patient getVariable [QGVAR(activeChestSeal), false]}) then {
        _patient setVariable [QGVAR(hemopneumothorax), false, true];
        [_patient] call EFUNC(circulation,updateInternalBleeding);
        if (!(_patient getVariable [QGVAR(pneumothorax), false]) && {!(_patient getVariable [QGVAR(hemopneumothorax), false]) && {!(_patient getVariable [QGVAR(tensionpneumothorax), false])}}) then {
            _patient setVariable [QGVAR(activeChestSeal), false, true];
        };
    };
};

if (_patient getVariable [QGVAR(activeChestSeal), false]) then {
    _patient setVariable [QGVAR(hemopneumothorax), false, true];
    [_patient] call EFUNC(circulation,updateInternalBleeding);
};

if (!(_patient getVariable [QGVAR(pneumothorax), false]) && {!(_patient getVariable [QGVAR(hemopneumothorax), false]) && {!(_patient getVariable [QGVAR(tensionpneumothorax), false])}}) then {
    _patient setVariable [QGVAR(activeChestSeal), false, true];
};
