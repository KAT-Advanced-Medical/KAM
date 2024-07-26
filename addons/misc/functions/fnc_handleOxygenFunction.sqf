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

params ["_unit", "_actualHeartRate", "_anerobicPressure", "_bloodGas", "_temperature", "_baroPressure", "_opioidDepression", "_deltaT", "_syncValues"];

// Ventilatory Demand comes from Heart Rate with increase demand from PaCO2 levels 
private _demandVentilation = (((_actualHeartRate * 60) max 1000) / _anerobicPressure) + (((_bloodGas select 0) - 40) * 200);
private _tidalVolume = GET_KAT_SURFACEAREA(_unit);

// Respiratory Rate is supressed by Opioids 
private _respiratoryRate = [((_demandVentilation / _tidalVolume) - (_opioidDepression * 10)) min 40, 20] select (_unit getVariable [QEGVAR(breathing,BVMInUse), false]);
private _actualVentilation = _tidalVolume * _respiratoryRate;

private _paco2 = (_bloodGas select 0);
// The greater the imbalance between CO2 explusion and O2 intake, the higher PaCO2 gets
_paco2 = if (((_demandVentilation max 1) / _actualVentilation) == 1) then { _paco2 + (0.25 min (-0.25 max ((40 + ((_anerobicPressure max 1) - 1) * 150) - _paco2))) } else { [ _paco2 - (0.05 * _deltaT), _paco2 + (0.05 * _deltaT)] select (((_demandVentilation max 1) / _actualVentilation) > 0) };                                    

// pH is from the Henderson-Hasselbalch equation. Extenal pH impacts from saline is included
private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh),0];
private _pH = (6.1 + log(24 / ((0.03 - 0.001 * (_temperature - 37)) * _paco2))) - ((_externalPh max 1) / 2000);

private _fio2 = switch (true) do {
    case ((_unit getVariable [QEGVAR(airway,occluded), false]) || (_unit getVariable [QEGVAR(airway,obstruction), false])): { 0 };
    case ((_unit getVariable [QEGVAR(chemical,airPoisoning), false]) || (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), false]) || (_unit getVariable [QEGVAR(breathing,hemopneumothorax), false])): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    default { 0.21 };
};

// PAO2 is largely impacted by Barometric Pressure and FiO2
private _pALVo2 = ((_fio2 * (_baroPressure - 47)) - (_paco2 / _anerobicPressure)) max 1;

// PaO2 cannot be higher than PAO2 for simplicity. PaO2 moves in controlled steps to prevent hard tanks when Ventilation Demand spikes
private _pao2 = (90 - ((_demandVentilation - _actualVentilation + 0.01) / 120)) min _pALVo2;
_pao2 = if ((_bloodGas select 2) != _pao2) then { _pao2 + ([(-0.05 * _deltaT) , (0.05 * _deltaT)] select (((_bloodGas select 2) - _pao2) < 0)) } else { _pao2 };

// Oxy-Haemo Dissociation Curve, driven primarily by pH
private _o2Sat = ((_pao2 max 1)^2.7 / ((25 - (((_pH / 7.4) - 1) * 150))^2.7 + _pao2^2.7)) min 0.999;

_unit setVariable [QEGVAR(circulation,bloodGas), [_paco2, _pao2, _o2Sat, 24, _pH], _syncValues];

[_bloodGas]