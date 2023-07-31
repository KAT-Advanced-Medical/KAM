#include "script_component.hpp"
/*
 * Author: mharis001, Blue
 * Checks if AED-X can be used on the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: AED-X is placed? <BOOL>
 *
 * Return Value:
 * Can use AED-X <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_AEDXCondition
 *
 * Public: No
 */

params ["_medic", "_patient", ["_isPlaced",false]];

private _fnc_AEDInUse = {
    params ["_patient"];

    if (isNull (_patient getVariable [QGVAR(AED_X_Provider),objNull])) then {
        false;
    } else {
        (_patient getVariable QGVAR(AED_X_Provider)) getVariable [QGVAR(AEDinUse), false];
    };
};

private _canCPR = ["",_patient] call ACEFUNC(medical_treatment,canCPR);
private _hasMonitor = _patient getVariable [QGVAR(X), false];
private _recovery = _patient getVariable [QEGVAR(airway,recovery), false];

if (_isPlaced) exitWith {
    !(nearestObjects [position _patient, ["kat_AEDItem"], GVAR(distanceLimit_AEDX)] findIf {typeOf _x isEqualTo "kat_X_AEDItem"} isEqualTo -1) && !([_patient] call _fnc_AEDInUse) && {!_recovery} && {_canCPR};
};

!(_patient getVariable [QGVAR(AEDinUse), false]) && {!_recovery} && {_canCPR};