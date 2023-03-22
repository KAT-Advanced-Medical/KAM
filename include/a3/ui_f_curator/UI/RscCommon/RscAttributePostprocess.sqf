#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEPOSTPROCESS_VALUE;
		_ctrlValue ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',_this,objnull] call RscAttributePostprocess};"];
		_cursel = 0;
		_default = "";
		{
			_rootIndex = _foreachindex;
			{
				_displayName = gettext (_x >> "displayName");
				_lbadd = _ctrlValue lbadd _displayName;
				_ctrlValue lbsetvalue [_lbadd,_rootIndex];
				_ctrlValue lbsetdata [_lbadd,configname _x];
				if (_x in (missionnamespace getvariable ["bis_fnc_setppeffecttemplate_value",[configfile]])) then {
					_default = _x;
					_cursel = _lbadd;
				};
			} foreach ((_x >> "CfgPostProcessTemplates") call bis_fnc_returnchildren);
		} foreach [configfile,campaignconfigfile,missionconfigfile];
		_ctrlValue lbsetcursel _cursel;
		RscAttributePostProcess_default = _default;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEPOSTPROCESS_VALUE;
		_cursel = lbcursel _ctrlValue;
		_value = _ctrlValue lbvalue _cursel;
		_data = _ctrlValue lbdata _cursel;
		_cfgRoot = [configfile,campaignconfigfile,missionconfigfile] select _value;
		_cfg = _cfgRoot >> "CfgPostProcessTemplates" >> _data;

		if ("isDelayEnabled" call bis_fnc_modulePostprocess) then {
			["setEffect",_cfg] call bis_fnc_modulePostprocess;
		} else {
			[_cfg,10,true] call bis_fnc_setPPeffectTemplate;
			RscAttributePostProcess_default = nil;
		};
	};
	case "onUnload": {
		if (!isnil "RscAttributePostProcess_default") then {
			[nil,0,false] call bis_fnc_setPPeffectTemplate;
		};
		RscAttributePostProcess_default = nil;
	};
	case "lbSelChanged": {
		_ctrlValue = _params select 0;
		_cursel = _params select 1;
		_value = _ctrlValue lbvalue _cursel;
		_data = _ctrlValue lbdata _cursel;
		_cfgRoot = [configfile,campaignconfigfile,missionconfigfile] select _value;
		[_cfgRoot >> "CfgPostProcessTemplates" >> _data,0,false] call bis_fnc_setPPeffectTemplate;
	};
};