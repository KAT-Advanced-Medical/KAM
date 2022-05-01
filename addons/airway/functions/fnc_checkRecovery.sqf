#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if guedel or larynx was placed before or any fractures are present
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
 * call kat_circulation_fnc_checkRecovery;
 *
 * Public: No
 */

params ["_medic", "_patient", "_className"];

private _return = true;
private _fractures = GET_FRACTURES(_patient);

//check if patient has inserted larynx
if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "larynx") then {
    _return = false;
};

//check if patient has inserted guedeltube
if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "guedel" && (_className isEqualTo "Guedeltubus")) then {
    _return = false;
};

//check if patient has fractures
{
    if( _x > 0 ) then {
        _return = false;
    };
} forEach _fractures;

_return