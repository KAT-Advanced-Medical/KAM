#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTEBEHAVIOUR_SAFE,
	IDC_RSCATTRIBUTEBEHAVIOUR_AWARE,
	IDC_RSCATTRIBUTEBEHAVIOUR_COMBAT,
	IDC_RSCATTRIBUTEBEHAVIOUR_STEALTH,
	IDC_RSCATTRIBUTEBEHAVIOUR_DEFAULT
];
_states = [
	"SAFE",
	"AWARE",
	"COMBAT",
	"STEALTH",
	"UNCHANGED"
];
_colors = [
	[0,1,0,1],
	[1,1,0,1],
	[1,0,0,1],
	[0,1,1,1],
	[1,1,1,1]
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeBehaviour};"];
			_ctrl ctrlsetactivecolor (_colors select _foreachindex);
		} foreach _idcs;

		//--- Select the current state
		_selected = if (typename _entity == typename []) then {
			waypointbehaviour _entity
		} else {
			(_display displayctrl IDC_RSCATTRIBUTEBEHAVIOUR_DEFAULT) ctrlshow false;
			behaviour leader _entity
		};
		if (_selected == "CARELESS") then {_selected = "SAFE";};
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeBehaviour;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_scale = 1.25;
			_color = +(_colors select _foreachindex);//[1,1,1,0.4];
			if (_ctrl != _ctrlSelected) then {
				_scale = 1;
				_color set [3,0.4];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeBehaviour_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeBehaviour_selected",0];
		_selected = _states select _selectedIndex;
		if (typename _entity == typename []) then {
			if (currentwaypoint (_entity select 0) == (_entity select 1) && _selected != "UNCHANGED") then {(_entity select 0) setbehaviour _selected;};
			_entity setwaypointbehaviour _selected;
		} else {
			_entity setbehaviour _selected;
			_entity setvariable ["updated",true,true];
		};
		false
	};
	case "onUnload": {
		RscAttributeBehaviour_selected = nil;
	};
};