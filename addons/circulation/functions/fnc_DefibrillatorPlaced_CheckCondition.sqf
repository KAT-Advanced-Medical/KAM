#include "..\script_component.hpp"
/*
 * Author: Blue
 * Checks if placed AED can be used (ace actions).
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Placed defibrillator <OBJECT>
 * 2: Condition to check <INT>
 *
 * Return Value:
 * Can use defibrillator <BOOL>
 *
 * Example:
 * [player, cursorObject, 0] call kat_circulation_fnc_DefibrillatorPlaced_CheckCondition;
 *
 * Public: No
 */

params ["_medic", "_defib", ["_check", 0]];

private _patient = _defib getVariable [QGVAR(Defibrillator_Patient), objNull];
private _patientExists = !(_patient isEqualTo objNull);
private _patientMonitor = _defib getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull];
private _patientMonitorExists = !(_patientMonitor isEqualTo objNull);
private _condition = false;

switch (_check) do {
    case 0: { // Connect pads/vitals monitor (to)
        _condition = !_patientExists && !_patientMonitorExists;
    };
    case 1: { // Connect pads
        _condition = !_patientExists && _patientMonitorExists;
    };
    case 2: { // Analyze rhythm
        _condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false])};
    };
    case 3: { // Shock
        _condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && _patient getVariable [QGVAR(Defibrillator_Charged), false]};
    };
    case 4: { // Disconnect pads
        _condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false])};
    };
    case 5: { // Connect vitals monitor
        _condition = !_patientMonitorExists && _patientExists;
    };
    case 6: { // Disconnect vitals monitor
        _condition = _patientMonitorExists && {_patientMonitor getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]};
    };
    case 7: { // Manual charge
        _condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false]) && !(_patient getVariable [QGVAR(Defibrillator_Charged), false])};
    };
    default { // Cancel charge
        _condition = _patientExists && {_patient getVariable [QGVAR(Defibrillator_Charged), false]};
    };
};

_condition && {!(_patient getVariable [QEGVAR(airway,recovery), false]) && (isNull objectParent _patient) && {["",_patient] call ACEFUNC(medical_treatment,canCPR)}};