#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;

		_curator = getassignedcuratorlogic player;
		_mode = _curator getvariable ["bis_fnc_curatorVisionModes_current",0];
		_modes = _curator call bis_fnc_curatorVisionModes;

		_cfgFLIRModeNames = getarray (configfile >> "cfgIngameUI" >> "FLIRModeNames" >> "FLIRModeName");
		_cfgFLIRModeColors = getarray (configfile >> "cfgIngameUI" >> "FLIRModeColors" >> "FLIRModeColor");
		_controls = [
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE0,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE1,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE2,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE3,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE4,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE5,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE6,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE7,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE8,
			_display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODE9
		];


		_modesCount = count _modes;
		_commitTime = if (_modesCount > 1) then {0.2} else {0};
		_controlGroup = _display displayctrl IDC_RSCCURATORVISIONMODES_VISIONMODES;
		_controlGroupPos = ctrlposition _controlGroup;
		_modeW = (_controlGroupPos select 2) * 0.1;
		_modeX = ((_controlGroupPos select 2) - (_modeW * _modesCount)) * 0.5;

		_controlFrame = _display displayctrl IDC_RSCCURATORVISIONMODES_FRAME;
		_controlFramePos = ctrlposition _controlFrame;
		_controlFramePos set [0,_modeX];
		_controlFramePos set [2,_modeW * _modesCount];
		_controlFrame ctrlsetposition _controlFramePos;
		_controlFrame ctrlcommit 0;

		{
			_name = "";
			_colorBackground = [0,0,0,0];
			_color = [0,0,0,0];
			switch _x do {
				case -2: {
					_name = "NVG";
					_colorBackground = [0,0.5,0,1];
					_color = [0,0,0,1];
				};
				case -1: {
					_name = "Normal";
					_colorBackground = [0.5,0.5,0.5,1];
					_color = [0,0,0,1];
				};
				default {
					_name = _cfgFLIRModeNames select _x;
					_colors = _cfgFLIRModeColors select _x;
					_colorBackground = _colors select 0;
					_color = _colors select 1;
				};
			};
			_control = _controls select _foreachindex;
			if (_foreachindex != _mode) then {
				_color set [3,0.5];
				_colorBackground set [3,0.5];
			};
			_control ctrlsettext _name;
			_control ctrlsettextcolor _color;
			_control ctrlsetbackgroundcolor _colorBackground;

			_controlPos = ctrlposition _control;
			_controlPos set [0,_modeX + _modeW * _foreachindex];
			_controlPos set [2,_modeW];
			_control ctrlsetposition _controlPos;
			_control ctrlcommit 0;	
		} foreach _modes;

		_control = _controls select _mode;
		_controlPos = ctrlposition _control;
		_controlPos set [3,(_controlPos select 3) * 1.3];
		_control ctrlsetposition _controlPos;
		_control ctrlcommit _commitTime;
	};
};