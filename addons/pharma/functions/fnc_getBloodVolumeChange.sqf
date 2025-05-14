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

private _bloodLoss = [_unit] call ACEFUNC(medical_status,getBloodLoss);
private _internalBleeding = GET_INTERNAL_BLEEDING(_unit);
private _lossVolumeChange = (-_deltaT * ((_bloodLoss + _internalBleeding * (GET_HEART_RATE(_unit) / DEFAULT_HEART_RATE)) / GET_VASOCONSTRICTION(_unit)));
private _enableFluidShift = EGVAR(vitals,enableFluidShift);
private _fluidVolume = GET_BODY_FLUID(_unit);
_fluidVolume params ["_ECB","_ECP","_SRBC","_ISP","_fullVolume"];

_ECP = (_ECP + (_lossVolumeChange * LITERS_TO_ML) / 2) max 100;
_ECB = (_ECB + (_lossVolumeChange * LITERS_TO_ML) / 2) max 100;

if (!isNil {_unit getVariable [QACEGVAR(medical,ivBags),[]]}) then {
    private _bloodBags = _unit getVariable [QACEGVAR(medical,ivBags), []];
    private _IVarray = _unit getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
    private _flowCalculation = (ACEGVAR(medical,ivFlowRate) * _deltaT * 4.16);
    private _hypothermia = EGVAR(hypothermia,hypothermiaActive);
    private _vasoconstriction = GET_VASOCONSTRICTION(_unit);

    if (GET_HEART_RATE(_unit) < 20) then {
        _flowCalculation = _flowCalculation / 1.5;
    };
    private _incomingFlowAmount = [0,0,0,0,0,0,0,0,0,0,0,0];;
    private _incomingVolumeChange = [0,0,0,0,0,0,0,0,0,0,0,0];;
    private _fluidWarmer = _unit getVariable [QEGVAR(hypothermia,fluidWarmer), [0,0,0,0,0,0,0,0,0,0,0,0]];
    private _fluidHeat = 0;

    _bloodBags = _bloodBags apply {
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart", "_treatment", "_rateCoef", "_item"];

        params ["_unit", "_bodyPart"];

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

        private _partIndex = ALL_BODY_PARTS find _bodyPart;
        private _idx = _occlusionMap findIf { _x#0 == _partIndex };
        private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
        private _isNotOccluded = { _tourniquets select _x != 0 } count _result > 0;

        if ((!_isNotOccluded) && ([7,8,9] find (_IVarray select _bodyPart) == -1)) then {
            private _IVflow = _unit getVariable [QGVAR(IVflow), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _IVrate = _unit getVariable [QGVAR(IVrate), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _bagChange = (_flowCalculation * (_IVflow select _bodyPart) * (_IVrate select _bodyPart) * _rateCoef) min _bagVolumeRemaining; // absolute value of the change in miliLiters
            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;
            _incomingFlowAmount set [_bodyPart, ((_incomingFlowAmount select _bodyPart) + _bagChange)];
            private _incomingFlowDifference = (_incomingFlowAmount select _bodyPart) - (10 * _vasoconstriction);
            _totalFlow = 0;
            {
                _totalFlow = _totalFlow + _x;
            } forEach _incomingFlowAmount;
            if (GVAR(IVComplications)) && (_totalFlow > (10 * _vasoconstriction)) then {[_unit,  _incomingFlowDifference] call FUNC(handleIVComplications)};
            if (GVAR(IVComplications)) && (((_incomingFlowAmount select _bodyPart) / (_IVrate select _bodyPart)) > (10 * _vasoconstriction)) then {[_unit, _bodyPart, _incomingFlowDifference] call FUNC(handleLimbIVComplications)};

            if (_hypothermia) then {
                // If fluid warmers are on the line, fluids are "warmed" and added to the warmer. If there is no fluid warmer on the line, the fluids stayed cooled
                if (_fluidWarmer select _bodyPart == 1) then {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) + _bagChange)];
                } else {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) - _bagChange)];
                };
            };

            // Plasma adds to ECP. Saline splits between the ECP and ISP. Blood adds to ECB
            switch (true) do {
                case(_type == "Plasma"): { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                case(_type == "Saline"): { 
                    if (_enableFluidShift) then {
                        _ECP = _ECP + _bagChange / 2; 
                        _ISP = _ISP + _bagChange / 2; 
                        _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                    } else {
                        { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                    };
                };
                case(_type == "Ringers Lactate"): {
                    if (_enableFluidShift) then {
                        _ECP = _ECP + _bagChange * 0.75; 
                        _ISP = _ISP + _bagChange * 0.25; 
                        _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                    } else {
                        { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                    };
                };
                case(_type == "Blood"): { 
                    _ECB = _ECB + _bagChange / 2; 
                    _ECP = _ECP + _bagChange / 2; 
                    _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); 
                };
                case(_type == "PackedRBC"): {
                    private _plasma = (_fluidVolume select 1);
                    if (_plasma <= 2000) then {
                        _ECB = _ECB + _bagChange; 
                        _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); 
                    } else {
                        _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS);
                    };
                };
            };
        } else {
            private _className = format ["%1_IV", _type];
            private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "IV";
            private _ivConfig = _defaultConfig >> _className;
            private _painReduce             = GET_NUMBER(_ivConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce") * _IVflow);
            private _timeInSystem           = GET_NUMBER(_ivConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem") * _IVflow);
            private _timeTillMaxEffect      = GET_NUMBER(_ivConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect") * _IVflow);
            private _viscosityChange        = GET_NUMBER(_ivConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange") * _IVflow);
            private _hrIncreaseLow          = GET_ARRAY(_ivConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow") * _IVflow);
            private _hrIncreaseNormal       = GET_ARRAY(_ivConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal") * _IVflow);
            private _hrIncreaseHigh         = GET_ARRAY(_ivConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh") * _IVflow);
            private _alphaFactor            = GET_NUMBER(_ivConfig >> "alphaFactor",getNumber (_defaultConfig >> "alphaFactor") * _IVflow);
            private _maxRelief              = GET_NUMBER(_ivConfig >> "maxRelief",getNumber (_defaultConfig >> "maxRelief") * _IVflow);
            private _opioidRelief           = GET_NUMBER(_ivConfig >> "opioidRelief",getNumber (_defaultConfig >> "opioidRelief") * _IVflow);
            private _opioidEffect           = GET_NUMBER(_ivConfig >> "opioidEffect",getNumber (_defaultConfig >> "opioidEffect") * _IVflow);
            private _viscosity              = GET_NUMBER(_ivConfig >> "viscosity",getNumber (_defaultConfig >> "viscosity"));
            private _dose                   = GET_NUMBER(_medicationConfig >> "dose",getNumber (_defaultConfig >> "dose"));
            private _heartRate = GET_HEART_RATE(_patient);
            private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
            _hrIncrease params ["_minIncrease", "_maxIncrease"];
            private _heartRateChange = _minIncrease + random (_maxIncrease - _minIncrease);

            private _presentPain = GET_PAIN(_patient);
            private _presentReduce = 0;
            if (_maxRelief > 0) then {
                if (_presentPain > _maxRelief) then {
                    _painReduce = _painReduce / 4;
                };
            };
            private _medicationParts = _className splitString "_";
            private _baseName = (_medicationParts select 0); 
            private _medicationName = (_baseName splitString "Infusion") select 0;
            TRACE_3("adjustments",_heartRateChange,_painReduce,_viscosityChange);

            [_patient, _medicationName, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate] call EFUNC(vitals,addMedicationAdjustment);
            [_patient, _medicationName] call ACEFUNC(medical_treatment,onMedicationUsage);

            private _IVflow = _unit getVariable [QGVAR(IVflow), [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _IVrate = _unit getVariable [QGVAR(IVrate), [0,0,0,0,0,0,0,0,0,0,0,0]];

            private _bagChange = (_flowCalculation * (_IVflow select _bodyPart) * (_IVrate select _bodyPart) * _viscosity) min _bagVolumeRemaining;  // absolute value of the change in miliLiters

            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;
            _incomingFlowAmount set [_bodyPart, ((_incomingFlowAmount select _bodyPart) + _bagChange)];
            private _incomingFlowDifference = _incomingFlowAmount - (10 * _vasoconstriction);

            _totalFlow = 0;
            {
                _totalFlow = _totalFlow + _x;
            } forEach _incomingFlowAmount;
            if (GVAR(IVComplications)) && (_totalFlow > (10 * _vasoconstriction)) then {[_unit,  _incomingFlowDifference] call FUNC(handleIVComplications)};
            if (GVAR(IVComplications)) && (((_incomingFlowAmount select _bodyPart) / (_IVrate select _bodyPart)) > (10 * _vasoconstriction)) then {[_unit, _bodyPart, _incomingFlowDifference] call FUNC(handleLimbIVComplications)};

            if (_hypothermia) then {
                // If fluid warmers are on the line, fluids are "warmed" and added to the warmer. If there is no fluid warmer on the line, the fluids stayed cooled
                if (_fluidWarmer select _bodyPart == 1) then {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) + _bagChange)];
                } else {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) - _bagChange)];
                };
            };
            
            if (_enableFluidShift) then {
                _ECP = _ECP + _bagChange / 2; 
                _ISP = _ISP + _bagChange / 2; 
                _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000);
                } else {
                { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                };
        };
    

        if (_bagVolumeRemaining < 0.01) then {
            []
        } else {
            [_bagVolumeRemaining, _type, _bodyPart, _treatment, _rateCoef, _item]
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

// Movement and recovery of interstital fluid and SRBC collection
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

_unit setVariable [QEGVAR(circulation,bodyFluid), [_ECB, _ECP, _SRBC, _ISP, (_ECP + _ECB)], _syncValues];

((_lossVolumeChange + GET_BLOOD_VOLUME_LITERS(_unit)) max 0.01)
