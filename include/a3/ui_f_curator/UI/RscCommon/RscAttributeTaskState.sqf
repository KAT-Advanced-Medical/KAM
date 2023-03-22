#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTETASKSTATE_ASSIGNED,
	IDC_RSCATTRIBUTETASKSTATE_CREATED,
	IDC_RSCATTRIBUTETASKSTATE_SUCCEEDED,
	IDC_RSCATTRIBUTETASKSTATE_FAILED,
	IDC_RSCATTRIBUTETASKSTATE_CANCELED
];
_states = ["Assigned","Created","Succeeded","Failed","Canceled"];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		RscAttributeTaskState_colors = [
			(configfile >> "RscMapControl" >> "Task" >> "color") call bis_fnc_colorCOnfigToRGBA,
			(configfile >> "RscMapControl" >> "Task" >> "colorCreated") call bis_fnc_colorCOnfigToRGBA,
			(configfile >> "RscMapControl" >> "Task" >> "colorDone") call bis_fnc_colorCOnfigToRGBA,
			(configfile >> "RscMapControl" >> "Task" >> "colorFailed") call bis_fnc_colorCOnfigToRGBA,
			(configfile >> "RscMapControl" >> "Task" >> "colorCanceled") call bis_fnc_colorCOnfigToRGBA
		];

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeTaskState};"];
			_color = RscAttributeTaskState_colors select _foreachindex;
			_ctrl ctrlsetactivecolor _color;
			_ctrl ctrlcommit 0;
		} foreach _idcs;

		//--- Select the current state
		_selected = _unit getvariable ["RscAttributeTaskState","Created"];
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeTaskState;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeTaskState};"];

			_color = +(RscAttributeTaskState_colors select _foreachindex);
			_scale = 1;
			if (_ctrl == _ctrlSelected) then {
				_scale = 1.25;
			} else {
				_color set [3,0.4];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeTaskState_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_stateIndex = uinamespace getvariable ["RscAttributeTaskState_selected",0];
		_state = _states select _stateIndex;
		_unit setvariable ["RscAttributeTaskState",_state,true];
		_unit setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		RscAttributeTaskState_selected = nil;
		RscAttributeTaskState_colors = nil;
	};
};