#include "script_component.hpp"
///////////////////

///////////////////
"KAT_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
private _obj = _ui displayCtrl 101;

_fnc_showThreat = {
	params ["_unit","_obj"];

	if(_unit getVariable["kat_medical_enteredPoisen",false]) then {
		_obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
	};

	waituntil {_unit getVariable["kat_medical_enteredPoisen",false]};
	
	if ("ChemicalDetector_01_watch_F" in (assigneditems _unit)) then {
		private _prozent = _unit getVariable ["kat_gas_percente",0];
		private _thread = parseNumber (_prozent toFixed 1);
		if(_thread < 0) then { _thread = 0};
		if(_thread > 1) then { _thread = 1};
		_obj ctrlAnimateModel ["Threat_Level_Source", _thread, true];
	};

	[] spawn FUNC(chemDetector);
};


[player,_obj] spawn _fnc_showThreat;
