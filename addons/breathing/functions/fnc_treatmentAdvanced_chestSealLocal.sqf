#include "script_component.hpp"
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

_patient setVariable [QGVAR(activeChestSeal), true, true];

_fnc_random = {
    if (random 100 <= GVAR(hemopneumothoraxChance)) then {
        _patient setVariable [QGVAR(hemopneumothorax), true, true];
    };
};

if !(GVAR(pneumothorax_hardcore)) exitWith {
    if (_patient getVariable [QGVAR(pneumothorax), false]) then {
        _patient setVariable [QGVAR(pneumothorax), false, true];
        call _fnc_random;
        if (!(_patient getVariable [QGVAR(pneumothorax), false]) && {!(_patient getVariable [QGVAR(hemopneumothorax), false]) && {!(_patient getVariable [QGVAR(tensionpneumothorax), false])}}) then {
            _patient setVariable [QGVAR(activeChestSeal), false, true];
        };
    };
};

_patient setVariable [QGVAR(pneumothorax), false, true];

if (!(_patient getVariable [QGVAR(pneumothorax), false]) && {!(_patient getVariable [QGVAR(hemopneumothorax), false]) && {!(_patient getVariable [QGVAR(tensionpneumothorax), false])}}) then {
    _patient setVariable [QGVAR(activeChestSeal), false, true];
};
