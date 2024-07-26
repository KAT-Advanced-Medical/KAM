#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Update the temperature of the patient
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: SpO2 Adjustments <NUMBER>
 * 2: Current SpO2 <NUMBER>
 * 3: Time since last update <NUMBER>
 * 4: Sync value? <BOOL>
 *
 * ReturnValue:
 * Current Temperature <NUMBER>
 *
 * Example:
 * [player, 0, 1, false] call ace_medical_vitals_fnc_updateHeartRate
 *
 * Public: No
 */

params ["_unit", "_spo2Adjustment", "_currentSpo2", "_deltaT", "_syncValue"];

private _output = -0.15 max _spo2Adjustment;

// Rewrite this to handle a single airway blockage variable
switch (true) do {
    case ((_unit getVariable [QEGVAR(airway,occluded), false]) || (_unit getVariable [QEGVAR(airway,obstruction), false])): {
        _output = _currentSpo2 + ((-0.15 * EGVAR(breathing,SpO2_MultiplyNegative)) * _deltaT);
    };
    case ((_unit getVariable [QEGVAR(chemical,airPoisoning), false]) || (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), false]) || (_unit getVariable [QEGVAR(breathing,hemopneumothorax), false])): {
        _output = _currentSpo2 + ((-0.15 * EGVAR(breathing,SpO2_MultiplyNegative)) * _deltaT);
    };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): {
        _output = _currentSpo2 + ((0.15 * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT);
    };
    default { _output = _currentSpo2 + ((_output * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT); };
};

_output = 100 min _output; 
_unit setVariable [VAR_SPO2, _output, _syncValues];

_output