#include "script_component.hpp"
/*
 * Author: Blue
 * Checks if AED-X vitals monitor can be connected to the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: AED-X origin <INT>
 *    0: Medic
 *    1: Placed
 *    2: Vehicle
 *
 * Return Value:
 * Can connect monitor <BOOL>
 *
 * Example:
 * [player, cursorObject, true] call kat_circulation_fnc_AEDXMonitorCondition
 *
 * Public: No
 */

params ["_medic", "_patient", ["_AEDOrigin",0]];

private _canCPR = ["",_patient] call ACEFUNC(medical_treatment,canCPR);
private _hasMonitor = _patient getVariable [QGVAR(X), false];

private _condition = false;

switch (_AEDOrigin) do {
    case 1: {
        _condition = !(nearestObjects [position _patient, ["kat_AEDItem"], GVAR(distanceLimit_AEDX)] findIf {typeOf _x isEqualTo "kat_X_AEDItem"} isEqualTo -1);
    };
    case 2: {
        if (vehicle _patient != _patient) then {
            _condition = !((itemCargo vehicle _patient) findIf {_x isEqualTo "kat_X_AED"} isEqualTo -1);
        };
    };
    default {
        _condition = !(_medic getVariable [QGVAR(AED_X_Connected), false]);
    };
};

_condition && !_hasMonitor && {_canCPR};