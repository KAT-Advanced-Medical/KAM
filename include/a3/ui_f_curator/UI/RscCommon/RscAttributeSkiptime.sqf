#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

//--- Minimum change to be synced by engine is 10 minutes
#define MINSYNCTIME	15

switch _mode do {
	case "onLoad": {
		_range = "range" call bis_fnc_moduleSkiptime;
		_value = (("delay" call bis_fnc_moduleSkiptime) * 60) max 0;

		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTESKIPTIME_VALUE;
		_ctrlSlider ctrladdeventhandler ["sliderposchanged","with uinamespace do {['sliderPosChanged',_this,objnull] call RscAttributeSkiptime};"];
		_ctrlSlider slidersetrange [0,0.9];
		_ctrlSlider slidersetposition _value;
		["sliderPosChanged",[_ctrlSlider,_value],objnull] call RscAttributeSkiptime;

		[_display] spawn {
			disableserialization;
			_display = _this select 0;
			_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTESKIPTIME_VALUE;
			while {!isnull _display} do {
				_value = sliderposition _ctrlSlider;
				_ctrlSlider slidersetposition _value;
				["sliderPosChanged",[_ctrlSlider,_value],objnull] call RscAttributeSkiptime;
				_time = time + 1;
				waituntil {time > _time};
			};
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTESKIPTIME_VALUE;
		_value = sliderposition _ctrlSlider;
		_value = -log (1 - _value);
		_value = (_value * 24 * 7) max 0;
		if (_value < (MINSYNCTIME / 60) && _value > 0) then {_value = MINSYNCTIME / 60;}; //--- Minimum change to be synced by engine is 10 mins
		if (_value > 0) then {
			if ("isDelayEnabled" call bis_fnc_moduleSkiptime) then {
				["setDelay",_value] call bis_fnc_moduleSkiptime;
			} else {
				[_value,true,true] call bis_fnc_setDate;
			};
		};
	};
	case "onUnload": {
	};

	case "sliderPosChanged": {
		_ctrlSlider = _params select 0;
		_value = (_params select 1);
		_value = -log (1 - _value);
		_value = (_value * 60 * 24 * 7) max 0;
		if (_value < MINSYNCTIME && _value > 0) then {_value = MINSYNCTIME;};
		_display = ctrlparent _ctrlSlider;
		_ctrlTime = _display displayctrl IDC_RSCATTRIBUTESKIPTIME_TIME;
		_ctrlSkiptime = _display displayctrl IDC_RSCATTRIBUTESKIPTIME_SKIPTIME;

		_daytime = (daytime + _value / 60) % 24;
		_valuetext = if (_value < 1440) then {
			if (_value < 60) then {
				format ["(+%1 %2)",round _value,localize "STR_A3_RscAttributeSkiptime_minutes"]
			} else {
				format ["(+%1 %2)",round (_value / 60),localize "STR_A3_RscAttributeSkiptime_hours"]
			};
		} else {
			format ["(+%1 %2)",round (_value / 1440),localize "STR_A3_RscAttributeSkiptime_days"]
		};
		_ctrlTime ctrlsettext ([_daytime,"HH:MM:SS"] call bis_fnc_timetostring);
		_ctrlSkiptime ctrlsettext _valuetext;
	};
};