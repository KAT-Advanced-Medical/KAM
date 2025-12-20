#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Calculates the blood volume change and decreases the IVs given to the unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Time since last update <NUMBER>
 * 2: Global Sync Values (bloodbags) <BOOL>
 *
 * Return Value:
 * Blood volume change (liters per second) <NUMBER>
 *
 * Example:
 * [player, 1, true] call kat_pharma_fnc_getBloodVolumeChange
 *
 * Public: No
 */

params ["_unit", "_deltaT", "_syncValues"];

private _bloodLoss = GET_BLOOD_LOSS(_unit);
private _internalBleeding = GET_INTERNAL_BLEEDING(_unit);
private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
private _map = _bloodPressureL + (0.3333333333 * (_bloodPressureH - _bloodPressureL));
private _correctedMap = linearConversion [14.3333, 174.3333, _map, 0.05, 2, true];
TRACE_3("correctedMAP",_correctedMap,_map,_bloodPressure);
private _heartRate = GET_HEART_RATE(_unit);
private _lossVolumeChange = (-_deltaT * (((_bloodLoss + _internalBleeding) * (GET_HEART_RATE(_unit) / (_unit getVariable [QEGVAR(circulation,defaultHeartRate), 80])) * _correctedMap * (((GET_BODY_FLUID_ECP(_unit)/GET_BODY_FLUID_ECB(_unit)) / (DEFAULT_ECP/DEFAULT_ECB))) min 2) / GET_VASOCONSTRICTION(_unit)));
private _enableFluidShift = EGVAR(vitals,enableFluidShift);
private _fluidVolume = GET_BODY_FLUID(_unit);
TRACE_4("gbvc",_internalBleeding,_bloodLoss,_heartRate,_lossVolumeChange);
_fluidVolume params ["_ECB","_ECP","_SRBC","_ISP","_fullVolume","_platelets"];

_ECP = (_ECP + (_lossVolumeChange * LITERS_TO_ML) / 2) max 100;
_ECB = (_ECB + (_lossVolumeChange * LITERS_TO_ML) / 2) max 100;
_platelets = (_platelets + ((_lossVolumeChange * LITERS_TO_ML) / 10)) max 0;

if (!isNil {_unit getVariable [QACEGVAR(medical,ivBags),[]]}) then {
    private _bloodBags = _unit getVariable [QACEGVAR(medical,ivBags), []];
    private _IVarray = _unit getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
    private _flowCalculation = (ACEGVAR(medical,ivFlowRate) * _deltaT * 3.16);
    private _hypothermia = EGVAR(hypothermia,hypothermiaActive);
    private _vasoconstriction = GET_VASOCONSTRICTION(_unit);
    private _incomingFlowAmount = [0,0,0,0,0,0,0,0,0,0,0,0];
    private _incomingVolumeChange = [0,0,0,0,0,0,0,0,0,0,0,0];
    private _fluidWarmer = _unit getVariable [QEGVAR(hypothermia,fluidWarmer), [0,0,0,0,0,0,0,0,0,0,0,0]];
    private _fluidHeat = 0;

    _bloodBags = _bloodBags apply {
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart", "_treatment", "_rateCoef", "_item", "_plateletAmount", "_phChange"];

        private _tourniquets = GET_TOURNIQUETS(_unit);
        private _occlusionMap = [
            [4, [4, 5]],
            [5, [5]],
            [6, [6, 7]],
            [7, [7]],
            [8, [8, 9, 3]],
            [9, [9, 3]],
            [10, [10, 11, 3]],
            [11, [11, 3]]
        ];

        private _idx = _occlusionMap findIf { _x#0 == _bodyPart };
        private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
        private _isOccluded = ({ _tourniquets select _x != 0 } count _result > 0) && (_IVarray select _bodyPart isNotEqualTo 13);
        if ((!_isOccluded) && ([7,8,9,15] find (_IVarray select _bodyPart) == -1)) then {
            if (_type in ["Blood", "Saline", "Plasma", "Ringers Lactate", "PackedRBC"]) then {
            private _IVflow = _unit getVariable [QGVAR(IVflow), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _IVrate = _unit getVariable [QGVAR(IVrate), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _pressureBag = _unit getVariable [QGVAR(pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]];
            if ((GET_HEART_RATE(_unit) < 20) && ((_IVarray select _bodyPart) != 14) && ((_pressureBag select _bodyPart) == 0)) then {
                _flowCalculation = _flowCalculation * 0.2;
            };
            if ((_unit getVariable [QACEGVAR(medical,CPR_provider), objNull]) != objNull) then {
                _flowCalculation = _flowCalculation * 0.6;
            };
            private _bagChange = (_flowCalculation * (_IVflow select _bodyPart) * (_IVrate select _bodyPart) * (1 + (_pressureBag select _bodyPart)) * _rateCoef) min _bagVolumeRemaining; // absolute value of the change in miliLiters
            if ((_IVarray select _bodyPart) in [2,3,4,10,11,12]) then {
                _bagChange = _bagChange * ((2 - _vasoconstriction) max 0.2);
            };
            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;
            _incomingFlowAmount set [_bodyPart, ((_incomingFlowAmount select _bodyPart) + _bagChange)];
            _unit setVariable [QGVAR(IVincomingFlowAmount), _incomingFlowAmount, true];
            _totalFlow = 0;
            {
                _totalFlow = _totalFlow + _x;
            } forEach _incomingFlowAmount;
            TRACE_8("IV",_bagChange,_IVrate,_IVflow,_IVarray,_isOccluded,_rateCoef,_flowCalculation,_bodyPart);
            TRACE_2("IV2",_bagVolumeRemaining,_incomingFlowAmount);
            if ((GVAR(LimbIVComplications)) && ((((_incomingFlowAmount select _bodyPart) max 0.01) / ((_IVrate select _bodyPart) max 0.01)) > (5 * ((2 - _vasoconstriction) max 0.2))) && ((random 100) < 20)) then {
                private _incomingFlowDifference = (_incomingFlowAmount select _bodyPart) - (5 * ((2 - _vasoconstriction) max 0.2));
                [_unit, _bodyPart, _incomingFlowDifference] call FUNC(handleLimbIVComplications)};
            if (GVAR(IVComplications)) then {
                private _hr = GET_HEART_RATE(_unit);
                private _bp = GET_BLOOD_PRESSURE(_unit) select 0;
                private _lungCondition = (_unit getVariable [QEGVAR(breathing,lungSurfaceArea), 400]);
                private _riskCoef = 1;
                if (_hr < 50) then {_riskCoef = _riskCoef * (linearConversion [50, 30, _hr, 1, 1.5, true])};
                if (_bp < 90) then {_riskCoef = _riskCoef * (linearConversion [90, 50, _bp, 1, 1.5, true])};
                if (_lungCondition < 350) then {_riskCoef = _riskCoef * (linearConversion [350, 150, _lungCondition, 1, 1.5, true])};
                private _maxSafeFlow = (20 * ((2 - _vasoconstriction) max 0.2)) / _riskCoef;
                if (_totalFlow > _maxSafeFlow) then {
                    [_unit, (_totalFlow - _maxSafeFlow)] call FUNC(handleIVComplications)
                    };
                };
            if (_hypothermia) then {
                // If fluid warmers are on the line, fluids are "warmed" and added to the warmer. If there is no fluid warmer on the line, the fluids stayed cooled
                if (_fluidWarmer select _bodyPart == 1) then {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) + _bagChange)];
                } else {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) - _bagChange)];
                };
            };
            if ((_type == "Blood") && (_bagChange > 1)) then {
                if !([_unit, _treatment] call EFUNC(circulation,compatible)) then {
                    private _medCount = [_unit, "BloodPoisoning"] call ACEFUNC(medical_status,getMedicationCount) select 1;
                    if (_medCount < 0.05) then {
                        [_unit, "BloodPoisoning", 0, 30, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.3, 0, 0, "false", "false", "true"] call EFUNC(vitals,addMedicationAdjustment);
                    };
                    private _hasPFH = _unit getVariable [QGVAR(hemolysisPFH), -1] isNotEqualTo -1;
                    if !(_hasPFH) then {
                        private _hemolysisPFH = [{
                            params ["_args", "_idPFH"];
                            _args params ["_unit"];
                            private _medCount = [_unit, "BloodPoisoning"] call ACEFUNC(medical_status,getMedicationCount) select 1;
                            if ((_medCount == 0) || !(alive _unit)) exitWith {
                                _unit setVariable [QGVAR(hemolysisPFH), -1, true];
                                [_idPFH] call CBA_fnc_removePerFrameHandler;
                            };
                            private _bloodlevels = GET_BODY_FLUID(_unit);
                            _bloodlevels set [0, ((_bloodlevels select 0) - 8) max 0];
                            _bloodlevels set [1, ((_bloodlevels select 1) + 8) max 0];
                            _bloodlevels set [5, ((_bloodlevels select 5) - 3) max 0];
                            _unit setVariable [QEGVAR(circulation,bodyFluid), _bloodlevels, true];
                        }, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
                        _unit setVariable [QGVAR(hemolysisPFH), _hemolysisPFH, true];
                    };
                };
            };
            // Plasma adds to ECP. Saline splits between the ECP and ISP. Blood adds to ECB/ECP
            private _ph = _unit getVariable [QGVAR(externalPh), 0];
            private _ph = (_ph + (_phChange * _bagChange));
            _unit setVariable [QGVAR(externalPh), _ph];
            switch (true) do {
                case(_type == "Plasma"): {
                    _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); 
                    _platelets = (_platelets + (_plateletAmount * _bagChange)) max 0;};
                    
                case(_type == "Saline"): { 
                    if (_enableFluidShift) then {
                        _ECP = _ECP + _bagChange / 2; 
                        _ISP = _ISP + _bagChange / 2; 
                        _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                    } else {
                        { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                    };
                    _unit setVariable [QEGVAR(brain,salineFlow), _bagChange];
                    _platelets = (_platelets + (_plateletAmount * _bagChange)) max 0;
                };
                case(_type == "Ringers Lactate"): {
                    if (_enableFluidShift) then {
                        _ECP = _ECP + _bagChange * 0.75; 
                        _ISP = _ISP + _bagChange * 0.25; 
                        _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                    } else {
                        { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                    };
                    _platelets = (_platelets + (_plateletAmount * _bagChange)) max 0;
                };
                case(_type == "Blood"): { 
                    _ECB = _ECB + _bagChange / 2; 
                    _ECP = _ECP + _bagChange / 2; 
                    _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                    _platelets = (_platelets + (_plateletAmount * _bagChange)) max 0; 
                };
                case(_type == "PackedRBC"): {
                    private _plasma = (_fluidVolume select 1);
                    private _ph = GET_PH(_unit);
                    if ((_plasma >= 2000) && (_ph > 6.8) && (_ph < 8)) then {
                        _platelets = (_platelets + (_plateletAmount * _bagChange)) max 0;
                    };
                    if (_plasma >= 2000) then {
                        _ECB = _ECB + (_bagChange * 1.5); 
                        _lossVolumeChange = _lossVolumeChange + ((_bagChange * 1.5) / ML_TO_LITERS); 
                    } else {
                        _ECP = _ECP + _bagChange; 
                        _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS);
                    };
                };
            };
            
            private _damageAmount = [_unit,_idx] call EFUNC(hitpoints,damageAmount);
            if ((_damageAmount > GVAR(ivLeakageThreshold)) && GVAR(ivCheckLimbDamage)) then {
                _lostFluids = linearConversion [GVAR(ivLeakageThreshold), 50, _damageAmount, 1, 0, true];
                _ECP = _ECB * _lostFluids;
                _ECP = _ECP * _lostFluids;
                _platelets = _platelets * _lostFluids;
                _ISP = _ISP * _lostFluids;
            };
        } else {
            private _IVflow = _unit getVariable [QGVAR(IVflow), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _IVrate = _unit getVariable [QGVAR(IVrate), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _bagChange = (_flowCalculation * (_IVflow select _bodyPart) * (_IVrate select _bodyPart) * _rateCoef) min _bagVolumeRemaining;
            private _medicationMult = ((_flowCalculation * (_IVflow select _bodyPart) * (_IVrate select _bodyPart) * _rateCoef)) ;
            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;
            _incomingFlowAmount set [_bodyPart, ((_incomingFlowAmount select _bodyPart) + _bagChange)];
            _unit setVariable [QGVAR(IVincomingFlowAmount), _incomingFlowAmount, true];
            private _defaultHeartRate = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
            private _heartRateRatio = GET_HEART_RATE(_unit) / _defaultHeartRate;
            private _hemocrit = 1;
            private _hemocrit = (GET_BODY_FLUID_ECP(_unit)/GET_BODY_FLUID_ECB(_unit)) / (DEFAULT_ECP/DEFAULT_ECB);
            private _drugMult = (((((GET_BLOOD_VOLUME_LITERS(_unit))/ DEFAULT_BLOOD_VOLUME) * (_heartRateRatio) * _hemocrit) max 0.2) min 2.5);
            private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "IV";
            private _ivConfig = _defaultConfig >> _treatment;
            private _painReduce             = (GET_NUMBER(_ivConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce")) * _medicationMult) * _drugMult;
            private _timeInSystem           = (GET_NUMBER(_ivConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem")) * _medicationMult) * _drugMult;
            private _timeTillMaxEffect      = (GET_NUMBER(_ivConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect")) * _medicationMult) * _drugMult;
            private _viscosityChange        = (GET_NUMBER(_ivConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange")) * _medicationMult) * _drugMult;
            private _hrIncreaseLow          = GET_ARRAY(_ivConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow"));
            private _hrIncreaseNormal       = GET_ARRAY(_ivConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal"));
            private _hrIncreaseHigh         = GET_ARRAY(_ivConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh"));
            private _alphaFactor            = (GET_NUMBER(_ivConfig >> "alphaFactor",getNumber (_defaultConfig >> "alphaFactor")) * _medicationMult) * _drugMult;
            private _maxRelief              = (GET_NUMBER(_ivConfig >> "maxRelief",getNumber (_defaultConfig >> "maxRelief")) * _medicationMult) * _drugMult;
            private _opioidRelief           = (GET_NUMBER(_ivConfig >> "opioidRelief",getNumber (_defaultConfig >> "opioidRelief")) * _medicationMult) * _drugMult;
            private _opioidEffect           = (GET_NUMBER(_ivConfig >> "opioidEffect",getNumber (_defaultConfig >> "opioidEffect")) * _medicationMult) * _drugMult;
            private _dose                   = (GET_NUMBER(_ivConfig >> "dose",getNumber (_defaultConfig >> "dose")) * _medicationMult) * _drugMult;
            private _respiratoryRate        = (GET_NUMBER(_ivConfig >> "respiratoryRate",getNumber (_defaultConfig >> "respiratoryRate")) * _medicationMult) * _drugMult;
            private _opioidDepression       = (GET_NUMBER(_ivConfig >> "opioidDepression",getNumber (_defaultConfig >> "opioidDepression")) * _medicationMult) * _drugMult;
            private _contractility          = (GET_NUMBER(_ivConfig >> "contractility",getNumber (_defaultConfig >> "contractility"))* _medicationMult) * _drugMult;
            private _nauseaMult             = (GET_NUMBER(_ivConfig >> "nauseaMult",getNumber (_defaultConfig >> "nauseaMult")) * _medicationMult) * _drugMult;
            private _heartRate = GET_HEART_RATE(_unit);
            private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
            _hrIncrease params ["_minIncrease", "_maxIncrease"];
            private _heartRateChange = ((_minIncrease + random (_maxIncrease - _minIncrease)) * _medicationMult) * _drugMult;

            private _presentPain = GET_PAIN(_unit);
            private _presentReduce = 0;
            if (_maxRelief > 0) then {
                if (_presentPain > _maxRelief) then {
                    _painReduce = _painReduce / 4;
                };
            };
            private _medicationName = (_type splitString "_") select 0;
            TRACE_6("adjustments1",_unit,_medicationName,_timeTillMaxEffect,_timeInSystem,_heartRateChange,_painReduce);
            TRACE_7("adjustments2",_viscosityChange,_dose,_alphaFactor,_opioidRelief,_opioidEffect,_opioidDepression,_respiratoryRate);

            [_unit, _medicationName, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate, _contractility, _nauseaMult] call EFUNC(vitals,addMedicationAdjustment);
            [_unit, _medicationName] call ACEFUNC(medical_treatment,onMedicationUsage);

            if (_hypothermia) then {
                // If fluid warmers are on the line, fluids are "warmed" and added to the warmer. If there is no fluid warmer on the line, the fluids stayed cooled
                if (_fluidWarmer select _bodyPart == 1) then {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) + _bagChange)];
                } else {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) - _bagChange)];
                };
            };
            private _ph = _unit getVariable [QGVAR(externalPh), 0];
            private _ph = (_ph + (_phChange * _bagChange)) max 0;
            _unit setVariable [QGVAR(externalPh), _ph];
            if (_enableFluidShift) then {
                _ECP = _ECP + _bagChange / 2; 
                _ISP = _ISP + _bagChange / 2; 
                _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                    } else {
                { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
            };
            private _damageAmount = [_unit,_idx] call EFUNC(hitpoints,damageAmount);
            if ((_damageAmount > GVAR(ivLeakageThreshold)) && GVAR(ivCheckLimbDamage)) then {
                _lostFluids = linearConversion [GVAR(ivLeakageThreshold), 50, _damageAmount, 1, 0, true];
                _ECP = _ECP * _lostFluids;
                _ISP = _ISP * _lostFluids;
            };
        };
    };
    if (_bagVolumeRemaining < 0.01) then {
            []
        } else {
            [_bagVolumeRemaining, _type, _bodyPart, _treatment, _rateCoef, _item, _plateletAmount, _phChange]
    };
    };
    _bloodBags = _bloodBags - [[]]; // remove empty bags
    if (_bloodBags isEqualTo []) then {
        _unit setVariable [QACEGVAR(medical,ivBags), nil, true]; // no bags left - clear variable (always globaly sync this)
    } else {
        _unit setVariable [QACEGVAR(medical,ivBags), _bloodBags, _syncValues];
    };

    // Incoming fluids impacting internal temperature
    if (_hypothermia) then {
        { _fluidHeat = _fluidHeat + _x; } forEach _incomingVolumeChange;

        if (_fluidHeat > 0) then {
            private _totalHeat = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0];
            _unit setVariable [QEGVAR(hypothermia,warmingImpact), _totalHeat + _fluidHeat, _syncValues];
        } else {
            private _totalCooling = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0];
            _unit setVariable [QEGVAR(hypothermia,warmingImpact), _totalCooling + _fluidHeat, _syncValues];
        };
    };
};
private _SRBCChange = 0;

if (_enableFluidShift) then {
    private _shiftValue = 0;
    private _defaultShift = false;

    _SRBCChange = [0, 0.5] select ((_SRBC > 0) && (_ECB < DEFAULT_ECB));
    _ECB = _ECB + (_SRBCChange * _deltaT);
    _SRBC = _SRBC - (_SRBCChange * _deltaT);

    switch (true) do {
        case (((_ECB + _ECP) > (_ISP * 0.6)) && ((_ECB + _ECP) > 4500)): {
            // Negative shifts only happen above 4500ml of blood volume, to prevent patients from falling back into arrest/unconsciousness
            _shiftValue = (1 min ((_ECP + _ECB) - (_ISP * 0.6))) * _deltaT;

            _ECP = _ECP - _shiftValue;
            _ISP = _ISP + _shiftValue;
        };
        case ((_ECB + _ECP) < (_ISP * 0.6)): {
            _shiftValue = (1 min ((_ISP * 0.6) - (_ECP + _ECB))) *_deltaT;

            if (_shiftValue < 0.1) exitWith { _defaultShift = true; };

            _ECP = _ECP + _shiftValue;
            _ISP = _ISP - _shiftValue;
        };
        default {
            _defaultShift = true;
        };
    };

    if (_defaultShift) then {
        _ISP = _ISP + ((((DEFAULT_ISP - _ISP) max -2) min 2) *_deltaT);
        _SRBC = _SRBC + ((((DEFAULT_SRBC - _SRBC) max -1) min 1) * _deltaT);
    };
};

_unit setVariable [QEGVAR(circulation,bodyFluid), [_ECB, _ECP, _SRBC, _ISP, (_ECP + _ECB), _platelets], _syncValues];
TRACE_3("bloodLoss",_ECB,_ECP,(_ECP + _ECB));
((_lossVolumeChange + GET_BLOOD_VOLUME_LITERS(_unit)) max 0.01)
