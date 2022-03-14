#include "script_component.hpp"

/////////////////////////

/////////////////////////

params ["_patient", "_bodyPart", "_classname"];

if (!alive _patient) exitWith {}; 

if(_classname == "Antidot") then {
		_patient setVariable ["kat_chemical_airPoisend",false,true];
		_patient setVariable ["kat_medical_isThreated",true,true];
		_patient setVariable ["kat_medical_enteredPoisen",false,true];
		if (_patient getVariable ["KAT_PAIN_EFFECT",0] != 0) then {
			KAT_PAIN_EFFECT ppEffectEnable false;
		};
};


// Get adjustment attributes for used medication
private _defaultConfig = configFile >> "ace_medical_treatment_actions";
private _medicationConfig = _defaultConfig >> _classname;

private _painReduce             = GET_NUMBER(_medicationConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce"));
private _timeInSystem           = GET_NUMBER(_medicationConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem"));
private _timeTillMaxEffect      = GET_NUMBER(_medicationConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect"));
private _maxDose                = GET_NUMBER(_medicationConfig >> "maxDose",getNumber (_defaultConfig >> "maxDose"));
private _viscosityChange        = GET_NUMBER(_medicationConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange"));
private _hrIncreaseLow          = GET_ARRAY(_medicationConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow"));
private _hrIncreaseNormal       = GET_ARRAY(_medicationConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal"));
private _hrIncreaseHigh         = GET_ARRAY(_medicationConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh"));
private _incompatibleMedication = GET_ARRAY(_medicationConfig >> "incompatibleMedication",getArray (_defaultConfig >> "incompatibleMedication"));

private _heartRate = _patient getVariable["ace_medical_heartrate",80];
private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
_hrIncrease params ["_minIncrease", "_maxIncrease"];
private _heartRateChange = _minIncrease + random (_maxIncrease - _minIncrease);	

TRACE_3("adjustments",_heartRateChange,_painReduce,_viscosityChange);
[_patient, _className, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange] call ace_medical_status_fnc_addMedicationAdjustment;



[_patient, _className, _maxDose, _incompatibleMedication] call ace_medical_treatment_fnc_onMedicationUsage;