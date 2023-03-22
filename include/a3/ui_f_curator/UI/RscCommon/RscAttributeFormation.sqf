#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTEFORMATION_WEDGE,
	IDC_RSCATTRIBUTEFORMATION_VEE,
	IDC_RSCATTRIBUTEFORMATION_LINE,
	IDC_RSCATTRIBUTEFORMATION_COLUMN,
	IDC_RSCATTRIBUTEFORMATION_FILE,
	IDC_RSCATTRIBUTEFORMATION_STAG_COLUMN,
	IDC_RSCATTRIBUTEFORMATION_ECH_LEFT,
	IDC_RSCATTRIBUTEFORMATION_ECH_RIGHT,
	IDC_RSCATTRIBUTEFORMATION_DIAMOND,
	IDC_RSCATTRIBUTEFORMATION_DEFAULT
];
_states = [
	"WEDGE",
	"VEE",
	"LINE",
	"COLUMN",
	"FILE",
	"STAG COLUMN",
	"ECH LEFT",
	"ECH RIGHT",
	"DIAMOND",
	"NO CHANGE"
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeFormation};"];
		} foreach _idcs;

		//--- Select the current state
		_selected = if (typename _entity == typename []) then {
			waypointformation _entity
		} else {
			(_display displayctrl IDC_RSCATTRIBUTEFORMATION_DEFAULT) ctrlshow false;
			formation _entity;
		};
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeFormation;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_scale = 1;
			_color = [1,1,1,0.4];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1.25;
				_color = [1,1,1,1];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeFormation_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeFormation_selected",0];
		_selected = _states select _selectedIndex;
		if (typename _entity == typename []) then {
			if (currentwaypoint (_entity select 0) == (_entity select 1) && _selected != "NO CHANGE") then {(_entity select 0) setformation _selected;};
			_entity setwaypointformation _selected;
		} else {
			_entity setformation _selected;
			_entity setvariable ["updated",true,true];
		};
		false
	};
	case "onUnload": {
		RscAttributeFormation_selected = nil;
	};
};