#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_chemDetector;
 *
 * Public: No
*/
params ["_unit"];

"KAT_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
private _obj = _ui displayCtrl 101;

_fnc_showThreat = {
	params ["_unit","_obj"];

	if(_unit getVariable [QGVAR(enteredPoisen),false]) then {
		_obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
	};

	[
		{
			params["_unit"];
			_unit getVariable[QGVAR(enteredPoisen),false]
		},
		{
			params["_unit"];
			if ("ChemicalDetector_01_watch_F" in (assigneditems _unit)) then {
				private _prozent = _unit getVariable [QGVAR(gasPercentage),0];
				private _thread = parseNumber (_prozent toFixed 1);
				if(_thread < 0) then { _thread = 0};
				if(_thread > 1) then { _thread = 1};
				_obj ctrlAnimateModel ["Threat_Level_Source", _thread, true];
			};
			[] call FUNC(chemDetector);
		},
		[_unit]
	] call CBA_fnc_waitUntilAndExecute;
};

[_unit,_obj] call _fnc_showThreat;
