#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

//--- Minimum change to be synced by engine is 10 minutes
#define MINSYNCTIME	15

switch _mode do {
	case "onLoad": {

		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTETIMEMULTIPLIER_VALUE;
		_ctrlSlider ctrladdeventhandler ["sliderposchanged","with uinamespace do {['sliderPosChanged',_this,objnull] call RscAttributeTimeMultiplier};"];
		_ctrlSlider slidersetposition timeMultiplier;
		["sliderPosChanged",[_ctrlSlider,timeMultiplier],objnull] call RscAttributeTimeMultiplier;

	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTETIMEMULTIPLIER_VALUE;
		[(floor sliderposition _ctrlSlider) max (sliderrange _ctrlSlider select 0),"settimemultiplier",false] call bis_fnc_mp;
	};
	case "onUnload": {
	};

	case "sliderPosChanged": {
		_ctrlSlider = _params select 0;
		_value = floor (_params select 1);

		_display = ctrlparent _ctrlSlider;
		_ctrlMultiplier = _display displayctrl IDC_RSCATTRIBUTETIMEMULTIPLIER_MULTIPLIER;
		_ctrlExample = _display displayctrl IDC_RSCATTRIBUTETIMEMULTIPLIER_EXAMPLE;

		_ctrlMultiplier ctrlsettext format ["%1x",_value];
		if (_value == 0) then {
			_ctrlExample ctrlsettext format ["(%1)",localize "str_disp_int_title"];
		} else {
			_ctrlExample ctrlsettext format ["(1 %1 = %2)",localize "str_disp_xbox_editor_wizard_time_day",[24 / _value] call bis_fnc_timetostring];
		};
	};
};