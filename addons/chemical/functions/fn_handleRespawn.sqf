



[] spawn { 
	waitUntil {!(isNull player)};	
	player setVariable ["kat_medical_enteredPoisen",false,true];
	player setVariable ["kat_gas_timeleft",missionNamespace getVariable ["kat_medical_infectTime",60],true];
	player setVariable ["kat_medical_poisenType","",true];
	player setVariable ["kat_medical_airPoisend",false,true];
	player setVariable ["kat_medical_CS",false,true];
	player setVariable ["kat_gasmask_durability",10,true];

	"kat_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
	private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
	private _obj = _ui displayCtrl 101;
	_obj ctrlAnimateModel ["Threat_Level_Source", 0, true];

	if (player getVariable ["KAT_PAIN_EFFECT",0] != 0) then {
		KAT_PAIN_EFFECT ppEffectEnable false;
	};

	player setVariable ["kat_isRespawned",true,true];

	[{
		player setVariable ["kat_isRespawned",false,true];
	},[],10]call CBA_fnc_waitAndExecute;

};