#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTEOVERCAST_VALUE000,
	IDC_RSCATTRIBUTEOVERCAST_VALUE025,
	IDC_RSCATTRIBUTEOVERCAST_VALUE050,
	IDC_RSCATTRIBUTEOVERCAST_VALUE075,
	IDC_RSCATTRIBUTEOVERCAST_VALUE100
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeOvercast};"];
			_ctrl ctrlcommit 0;
		} foreach _idcs;

		RscAttributeOvercast_default = overcast;
		RscAttributeOvercast_value = overcast;
		_selectedIdc = _idcs select round (overcast * 4);
		['onButtonClick',[_display displayctrl _selectedIdc,0]] call RscAttributeOvercast;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.5];
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;
		_ctrlSelected ctrlsettextcolor [1,1,1,1];
		[_ctrlSelected,1.25,_delay] call bis_fnc_ctrlsetscale;
		if (_delay > 0) then {
			RscAttributeOvercast_value = (_idcs find (ctrlidc _ctrlSelected)) / 4;
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_value = uinamespace getvariable ["RscAttributeOvercast_value",0];
		if ("isDelayEnabled" call bis_fnc_moduleWeather) then {
			["setOvercast",_value] call bis_fnc_moduleWeather;
		} else {
			_value spawn bis_fnc_setovercast;
			RscAttributeOvercast_default = nil;
		};
		_unit setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		if (!isnil "RscAttributeOvercast_default") then {
			//--- Reset to the original value
			[RscAttributeOvercast_default,false] spawn bis_fnc_setovercast;
		};
		RscAttributeOvercast_default = nil;
		RscAttributeOvercast_value = nil;
	};
};