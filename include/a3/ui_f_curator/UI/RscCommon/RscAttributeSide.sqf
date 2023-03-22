#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTESIDE_OPFOR,
	IDC_RSCATTRIBUTESIDE_BLUFOR,
	IDC_RSCATTRIBUTESIDE_INDEPENDENT,
	IDC_RSCATTRIBUTESIDE_CIVILIAN
];

switch _mode do {
	case "onLoad": {

		//--- Get default / remembered sides
		_selected = _unit getvariable "RscAttributeSide";
		if (isnil "_selected") then {
			_selected = missionnamespace getvariable "RscAttributeSide_selected";
			if (isnil "_selected") then {_selected = [0,1,2,3];};
		};

		_selectedUnit = _unit getvariable ["RscAttributeSide",[]];
		RscAttributeSide_selected = [];

		//--- Add handlers to all buttons
		_display = _params select 0;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeSide};"];

			_color = _foreachindex call bis_fnc_sidecolor;
			_ctrl ctrlsetactivecolor _color;
			_color set [3,0.5];
			_ctrl ctrlsettextcolor _color;

			if (_foreachindex in _selected) then {
				['onButtonClick',[_ctrl,0]] call RscAttributeSide;
			};
			_side = _foreachindex call bis_fnc_sidetype;
			//_ctrl ctrlenable !(_side in _selectedUnit);
		} foreach _idcs;

	};
	case "onButtonClick": {

		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;

		_sideID = _idcs find (ctrlidc _ctrlSelected);
		_color = _sideID call bis_fnc_sidecolor;
		_scale = 1;
		_alpha = 0.5;
		if (_sideID in RscAttributeSide_selected && count RscAttributeSide_selected > 1) then {
			RscAttributeSide_selected = RscAttributeSide_selected - [_sideID];
		} else {
			if !(_sideID in RscAttributeSide_selected) then {
				RscAttributeSide_selected = RscAttributeSide_selected + [_sideID];
			};
			_scale = 1.2;
			_alpha = 1;
		};
		_color set [3,_alpha];
		_ctrlSelected ctrlsettextcolor _color;
		[_ctrlSelected,_scale,_delay] call bis_fnc_ctrlsetscale;
	};
	case "confirmed": {
		_selected = +(uinamespace getvariable ["RscAttributeSide_selected",[]]);
		{
			_selected set [_foreachindex,_x call bis_fnc_sidetype];
		} foreach _selected;
		_unit setvariable ["RscAttributeSide",_selected,true];
		_unit setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		missionnamespace setvariable ["RscAttributeSide_selected",RscAttributeSide_selected];
		RscAttributeSide_selected = nil;
	};
};