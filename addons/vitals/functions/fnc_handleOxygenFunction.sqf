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
 * Current O2 Saturation <NUMBER>
 *
 * Example:
 * [player, 80, 0.8, [40,90,0.96,24,7.4], 37, 760, 0, 1, true] call kat_vitals_fnc_handleOxygenFunction;
 *
 * Public: No
 */

params ["_unit", "_actualHeartRate", "_anerobicPressure", "_bloodGas", "_temperature", "_baroPressure", "_opioidDepression", "_deltaT", "_syncValues"];

#define MAXIMUM_RR 40
#define HEART_RATE_CO2_MULTIPLIER 60
#define MINIMUM_VENTILATION 2000
#define PACO2_MAX_CHANGE 0.05
#define PAO2_MAX_CHANGE 0.1
#define DEFAULT_FIO2 0.21

private _respiratoryRate = 0;
private _demandVentilation = 0;
private _actualVentilation = 0;
private _previousCyclePaco2 = (_bloodGas select 0);
private _previousCyclePao2 = (_bloodGas select 1);

if (IN_CRDC_ARRST(_unit)) then { 
    // When in arrest, there should be no effecive breaths but still a minimum O2 demand. Zero O2 demand would mean a dead patient. Actual ventilation is 1 to prevent issues in the gas tension functions
    _demandVentilation = MINIMUM_VENTILATION;
    _respiratoryRate = 0;
    _actualVentilation = 1;
} else {
    // Ventilatory Demand comes from Heart Rate with increase demand from PaCO2 levels 
    _demandVentilation = ((((_actualHeartRate * HEART_RATE_CO2_MULTIPLIER) / _anerobicPressure) + ((_previousCyclePaco2 - DEFAULT_PACO2) * 200)) max MINIMUM_VENTILATION);
    private _tidalVolume = GET_KAT_SURFACE_AREA(_unit);

    // Respiratory Rate is supressed by Opioids 
    _respiratoryRate = [((_demandVentilation / _tidalVolume) - (_opioidDepression * 5)) min MAXIMUM_RR, 20] select (_unit getVariable [QEGVAR(breathing,BVMInUse), false]);

    // If respiratory rate is low due to PaCO2, it starts increasing faster to compensate
    if (_previousCyclePaco2 > 50) then { _respiratoryRate = (_respiratoryRate + ((_previousCyclePaco2 - 50) * 0.2)) min MAXIMUM_RR};

    _actualVentilation = _tidalVolume * _respiratoryRate;
};

private _paco2 = 40;

if (EGVAR(breathing,paco2Active)) then {
    // The greater the imbalance between CO2 explusion and O2 intake, the higher PaCO2 gets
    _paco2 = if ((_demandVentilation / _actualVentilation) == 1) then { _previousCyclePaco2 + (PACO2_MAX_CHANGE min (-PACO2_MAX_CHANGE max ((DEFAULT_PACO2 + ((_anerobicPressure max 1) - 1) * 150) - _previousCyclePaco2))) } else { [ _previousCyclePaco2 - (PACO2_MAX_CHANGE * _deltaT), _previousCyclePaco2 + (PACO2_MAX_CHANGE * _deltaT)] select ((_demandVentilation / _actualVentilation) > 1) };                                    
};

// Generated ETCO2 quadratic. Ensures ETCO2 moves with Respiratory Rate and is constantly below PaCO2 
private _etco2 = [((_paco2 - 3) - ((-0.0416667 * (_respiratoryRate^2)) + (3.09167 * (_respiratoryRate)) - DEFAULT_ETCO2) max 10), 0] select (IN_CRDC_ARRST(_unit));

private _externalPh = 0;
private _pH = 7.4;

if (EGVAR(pharma,kidneyAction)) then {
    // Extenal pH impacts from saline is included
    _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];

    // pH is from the Henderson-Hasselbalch equation
    _pH = (6.1 + log(24 / ((0.03 - 0.001 * (_temperature - DEFAULT_TEMPERATURE)) * _paco2))) - ((_externalPh max 1) / 2000);
};

// Fractional Oxygen when breathing normal air is 0.21, 1 when breathing 100% Oxygen, and 0 when no air is being brought into the lungs
private _fio2 = switch (true) do {
    case ((_unit getVariable [QEGVAR(airway,occluded), false]) || (_unit getVariable [QEGVAR(airway,obstruction), false])): { 
        [0, DEFAULT_FIO2] select ((_unit getVariable [QEGVAR(airway,recovery), false]) || (_unit getVariable [QEGVAR(airway,overstretch), false])) 
    };
    case ((_unit getVariable [QEGVAR(chemical,airPoisoning), false]) || (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), false]) || (_unit getVariable [QEGVAR(breathing,hemopneumothorax), false])): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    default { DEFAULT_FIO2 };
};

// Alveolar Gas equation. PALVO2 is largely impacted by Barometric Pressure and FiO2
private _pALVo2 = ((_fio2 * (_baroPressure - 47)) - (_paco2 / _anerobicPressure)) max 1;

// PaO2 cannot be higher than PALVO2 and comes from ventilation shortage multipled by RBC volume
private _pao2 = (DEFAULT_PAO2 - ((DEFAULT_ECB / ((GET_BODY_FLUID(_unit) select 0) max 100)) * ((_demandVentilation - _actualVentilation) / 120))) min _pALVo2;

// PaO2 moves in controlled steps to prevent hard movements when Ventilation Demand spikes
_pao2 = if (_previousCyclePao2 != _pao2) then { ([ (_previousCyclePao2 - ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyNegative)) * _deltaT)) , (_previousCyclePao2 + ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT))] select ((_previousCyclePao2 - _pao2) < 0)) } else { _pao2 };

// Oxy-Hemo Dissociation Curve, driven by PaO2 with shaping done by pH 
private _o2Sat = ((_pao2 max 1)^2.7 / ((25 - (((_pH / DEFAULT_PH) - 1) * 150))^2.7 + _pao2^2.7)) min 0.999;

_unit setVariable [VAR_BREATHING_RATE, (_respiratoryRate max 0), _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100
