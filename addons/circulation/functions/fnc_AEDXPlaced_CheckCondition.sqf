#include "script_component.hpp"
/*
 * Author: Blue
 * Checks if placed AED-X can be used.
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
 * [player, cursorObject] call kat_circulation_fnc_AEDXPlaced_CheckCondition
 *
 * Public: No
 */

params ["_medic", "_defib", ["_check", 0]];

private _patient = _defib getVariable [QGVAR(Defibrillator_Patient), objNull];
private _patientExists = !(_patient isEqualTo objNull);
private _condition = false;

switch (_check) do {
	case 0: { // Connect pads
		_condition = !_patientExists;
	};
	case 1: { // Analyze rhythm
		_condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false])};
	};
	case 2: { // Shock
		_condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && _patient getVariable [QGVAR(Defibrillator_Charged), false]};
	};
	case 3: { // Disconnect pads
		_condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false])};
	};
	case 4: { // Connect vitals monitor
		_condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && (isNull (_defib getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull])) && !(_patient getVariable [QGVAR(DefibrillatorInUse), false])};
	};
	case 5: { // Manual charge
		_condition = _patientExists && {_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false]) && !(_patient getVariable [QGVAR(Defibrillator_Charged), false])};
	};
	default { // Disconnect vitals monitor
		_condition = !(isNull (_defib getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull])) && {!((_defib getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull]) getVariable [QGVAR(DefibrillatorInUse), false])};
	};
};

_condition && [_medic, GVAR(medLvl_AED_X)] call ACEFUNC(medical_treatment,isMedic) && {!(_patient getVariable [QEGVAR(airway,recovery), false]) && {["",_patient] call ACEFUNC(medical_treatment,canCPR)}};