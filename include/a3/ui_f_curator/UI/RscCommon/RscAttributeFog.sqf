#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_default = +(missionnamespace getvariable ["bis_fnc_setfog_value",[fog,0.1,getterrainheightasl position _unit]]);
		RscAttributeFog_default = +_default;
		RscAttributeFog_params = _default;
		RscAttributeFog_height = getposasl _unit select 2;

		_display = _params select 0;
		if (!isserver || !ismultiplayer) then {
			_display displayaddeventhandler ["mousemoving","with uinamespace do {['update',_this,objnull] call RscAttributeFog};"];
			_display displayaddeventhandler ["mouseholding","with uinamespace do {['update',_this,objnull] call RscAttributeFog};"];
		};

		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEFOG_VALUE;
		_ctrlValue ctrladdeventhandler ["sliderposchanged","with uinamespace do {['valueChanged',_this,objnull] call RscAttributeFog};"];
		_ctrlValue slidersetposition ((_default select 0) * 10);

		_ctrlAltValue = _display displayctrl IDC_RSCATTRIBUTEFOG_ALTVALUE;
		_ctrlAltValue ctrladdeventhandler ["sliderposchanged","with uinamespace do {['altValueChanged',_this,objnull] call RscAttributeFog};"];
		_ctrlAltValue slidersetrange [0,getterrainheightasl position _unit];
		_ctrlAltValue slidersetposition (_default select 2);
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEFOG_VALUE;
		_value = sliderposition _ctrlValue / 10;
		_fogParams = uinamespace getvariable ["RscAttributeFog_params",[fog,0.1,0]];
		_fogParams set [0,_value];
		_fogParams set [2,((_value * 2) min 1) * RscAttributeFog_height];
		if ("isDelayEnabled" call bis_fnc_moduleWeather) then {
			["setFog",_fogParams] call bis_fnc_moduleWeather;
		} else {
			_fogParams call bis_fnc_setfog;
			RscAttributeFog_default = nil;
		};
		_unit setvariable ["RscAttributeFog",_fogParams];
		_unit setvariable ["updated",true,true];
	};
	case "onUnload": {
		if (!isnil "RscAttributeFog_default") then {
			0 setfog RscAttributeFog_default;
		};
		RscAttributeFog_default = nil;
	};
	case "valueChangedx": {
		_value = (_params select 1) / 10;
		_fogParams = uinamespace getvariable ["RscAttributeFog_params",[fog,0.1,0]];
		_fogParams set [0,_value];
		_fogParams set [2,((_value * 2) min 1) * RscAttributeFog_height];
		0 setfog _fogParams;
	};
	case "update": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEFOG_VALUE;
		_value = sliderposition _ctrlValue / 10;
		_fogParams = uinamespace getvariable ["RscAttributeFog_params",[fog,0.1,0]];
		_fogParams set [0,_value];
		_fogParams set [2,((_value * 2) min 1) * RscAttributeFog_height];
		0 setfog _fogParams;
		1 setfog _fogParams;
	};


/*
	case "altValueChanged": {
		_altValue = _params select 1;
		_fogParams = uinamespace getvariable ["RscAttributeFog_params",[fog,0.1,0]];
		_fogParams set [2,_altValue];
		0 setfog _fogParams;
	};
*/w
};