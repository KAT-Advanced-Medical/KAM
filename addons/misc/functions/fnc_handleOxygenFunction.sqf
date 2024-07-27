#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Updates the respiratory variables 
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Heart Rate <NUMBER>
 * 2: Anerobic Pressure <NUMBER>
 * 3: Blood Gas Array <ARRAY>
 * 4: Temperature <NUMBER>
 * 5: Barometric Pressure <NUMBER>
 * 6: Opioid Depression <NUMBER>
 * 7: Time since last update <NUMBER>
 * 8: Sync value? <BOOL> 
 *
 * ReturnValue:
 * Current Temperature <NUMBER>
 *
 * Example:
 * [player, 80, 0.8, [40,90,0.96,24,7.4], 37, 760, 0, 1, false] call kat_misc_fnc_handleOxygenFunction;
 *
 * Public: No
 */

params ["_unit", "_actualHeartRate", "_anerobicPressure", "_bloodGas", "_temperature", "_baroPressure", "_opioidDepression", "_deltaT", "_syncValues"];

private _respiratoryRate = 0;
private _demandVentilation = 0;
private _actualVentilation = 0;
private _previousCyclePaco2 = (_bloodGas select 0);

if (IN_CRDC_ARRST(_unit)) then { 
    _demandVentilation = 2000;
    _respiratoryRate = 0;
    _actualVentilation = 1;
} else {
    // Ventilatory Demand comes from Heart Rate with increase demand from PaCO2 levels 
    _demandVentilation = ((((_actualHeartRate * 60) / _anerobicPressure) + ((_previousCyclePaco2 - 40) * 200)) max 2000);
    _tidalVolume = GET_KAT_SURFACEAREA(_unit);

    // Respiratory Rate is supressed by Opioids 
    _respiratoryRate = [((_demandVentilation / _tidalVolume) - (_opioidDepression * 10)) min 40, 20] select (_unit getVariable [QEGVAR(breathing,BVMInUse), false]);
    _actualVentilation = (_tidalVolume * _respiratoryRate) max 1;
};

// The greater the imbalance between CO2 explusion and O2 intake, the higher PaCO2 gets
private _paco2 = if ((_demandVentilation / _actualVentilation) == 1) then { _previousCyclePaco2 + (0.25 min (-0.25 max ((40 + ((_anerobicPressure max 1) - 1) * 150) - _previousCyclePaco2))) } else { [ _previousCyclePaco2 - (0.05 * _deltaT), _previousCyclePaco2 + (0.05 * _deltaT)] select ((_demandVentilation / _actualVentilation) > 0) };                                    
private _etco2 = [((_paco2 - 3) - ((-0.0416667 * (_respiratoryRate^2)) + (3.09167 * (_respiratoryRate)) - 37) max 0), 0] select (IN_CRDC_ARRST(_unit));

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
private _previousCyclePao2 = (_bloodGas select 1);

private _pao2 = ((90 - (((GET_BODY_FLUID(_unit) select 0) max 100) / 2700)) - ((_demandVentilation - _actualVentilation) / 120)) min _pALVo2;

_pao2 = if (_previousCyclePao2 != _pao2) then { ([ _previousCyclePao2 - (0.1 * _deltaT) , _previousCyclePao2 + (0.1 * _deltaT)] select ((_previousCyclePao2 - _pao2) < 0)) } else { _pao2 };

// Oxy-Haemo Dissociation Curve, driven primarily by pH
private _o2Sat = ((_pao2 max 1)^2.7 / ((25 - (((_pH / 7.4) - 1) * 150))^2.7 + _pao2^2.7)) min 0.999;

_unit setVariable [VAR_BREATHING_RATE, _respiratoryRate, _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100