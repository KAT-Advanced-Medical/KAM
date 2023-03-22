#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTESPEEDMODE_LIMITED,
	IDC_RSCATTRIBUTESPEEDMODE_NORMAL,
	IDC_RSCATTRIBUTESPEEDMODE_FULL,
	IDC_RSCATTRIBUTESPEEDMODE_DEFAULT
];
_states = [
	"LIMITED",
	"NORMAL",
	"FULL",
	"UNCHANGED"
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeSpeedMode};"];
			_ctrl ctrlsetactivecolor (_colors select _foreachindex);
		} foreach _idcs;

		//--- Select the current state
		_selected = if (typename _entity == typename []) then {
			waypointspeed _entity
		} else {
			(_display displayctrl IDC_RSCATTRIBUTESPEEDMODE_DEFAULT) ctrlshow false;
			speedmode leader _entity
		};
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeSpeedMode;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.4];
			[_ctrl,if (_ctrl != _ctrlSelected) then {1} else {1.25},_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;
		_ctrlSelected ctrlsettextcolor [1,1,1,1];

		RscAttributeSpeedMode_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeSpeedMode_selected",0];
		_selected = _states select _selectedIndex;
		if (typename _entity == typename []) then {
			if (currentwaypoint (_entity select 0) == (_entity select 1) && _selected != "UNCHANGED") then {(_entity select 0) setspeedmode _selected;};
			_entity setwaypointspeed _selected;
		} else {
			_entity setspeedmode _selected;
			_entity setvariable ["updated",true,true];
		};
		false
	};
	case "onUnload": {
		RscAttributeSpeedMode_selected = nil;
	};
};