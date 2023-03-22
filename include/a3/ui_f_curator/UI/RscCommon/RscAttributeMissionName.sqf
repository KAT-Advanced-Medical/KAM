#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMISSIONNAME_VALUE;
		_ctrlValue ctrlsettext (missionnamespace getvariable ["bis_fnc_moduleMissionName_name",""]);
		RscAttributeMissionName_name = "-";
		{
			_display displayaddeventhandler [_x,{with uinamespace do {["loop",_this,objnull] call RscAttributeMissionName;};}];
		} foreach ["mousemoving","mouseholding"];
	};
	case "loop": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMISSIONNAME_VALUE;
		_name = ctrltext _ctrlValue;
		if (_name != RscAttributeMissionName_name) then {
			RscAttributeMissionName_name = _name;
			_ctrlPreview = _display displayctrl IDC_RSCATTRIBUTEMISSIONNAME_PREVIEW;
			_ctrlPreview ctrlsetstructuredtext (([false,_name] call bis_fnc_moduleMissionName) select 2);
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMISSIONNAME_VALUE;
		_name = ctrltext _ctrlValue;
		if (_name != (missionnamespace getvariable ["bis_fnc_moduleMissionName_name",""])) then {
			missionnamespace setvariable ["bis_fnc_moduleMissionName_name",_name];
			publicvariable "bis_fnc_moduleMissionName_name";
			[true,"bis_fnc_moduleMissionName"] call bis_fnc_mp;
		};
	};
	case "onUnload": {
	};
};