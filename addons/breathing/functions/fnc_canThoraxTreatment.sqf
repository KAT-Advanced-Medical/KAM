#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if guedel or larynx was placed before
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 * 
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * call kat_airway_fnc_checkRecovery;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _return = true;

//check if medic can perform thorax treatment
if (_patient getVariable [ARR_2(QEGVAR(airway,recovery),false)]) then {
    _return = false;
};

_return