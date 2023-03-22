#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_value = [] call bis_fnc_countdown;
		if (_value <= 0 && ismultiplayer) then {_value = estimatedendservertime - servertime;};
		_min = if (_value <= 0) then {-1} else {0};

		_display = _params select 0;
		_ctrlTime = _display displayctrl IDC_RSCATTRIBUTECOUNTDOWN_TIME;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTECOUNTDOWN_VALUE;
		_ctrlSlider ctrladdeventhandler ["sliderposchanged","with uinamespace do {['sliderPosChanged',_this,objnull] call RscAttributeCountdown};"];
		_ctrlSlider slidersetrange [_min,3600];
		_ctrlSlider slidersetposition _value;
		["sliderPosChanged",[_ctrlSlider,_value],objnull] call RscAttributeCountdown;

		[_display] spawn {
			disableserialization;
			_display = _this select 0;
			_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTECOUNTDOWN_VALUE;
			while {!isnull _display} do {
				_value = sliderposition _ctrlSlider - 1;
				_ctrlSlider slidersetposition _value;
				["sliderPosChanged",[_ctrlSlider,_value],objnull] call RscAttributeCountdown;
				_time = time + 1;
				waituntil {time > _time};
			};
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTECOUNTDOWN_VALUE;
		_value = (sliderposition _ctrlSlider);

		if (_value >= 0) then {
			if (abs (([] call bis_fnc_missionTimeLeft) - _value) > 60) then {
				_valueText = format ["%1 %2",ceil (_value / 60),localize "STR_A3_RSCMPPROGRESS_min"];
				[["Countdown",[_valueText]],"bis_fnc_showNotification"] call bis_fnc_mp;
			};

			if (ismultiplayer) then {
				//estimatedtimeleft _value;
				_value call bis_fnc_estimatedtimeleft;
			} else {
				_value call bis_fnc_countdown;
			};
		} else {
			if (ismultiplayer) then {
				//estimatedtimeleft 1e10;
				1e10 call bis_fnc_estimatedtimeleft;
			} else {
				-1 call bis_fnc_countdown;
			};
		};
	};
	case "onUnload": {
	};

	case "sliderPosChanged": {
		_ctrlSlider = _params select 0;
		_value = _params select 1;
		_display = ctrlparent _ctrlSlider;
		_text = if (_value < 0) then {
			"--:--:--"
		} else {
			[(_value / 3600) % 24,"HH:MM:SS"] call bis_fnc_timetostring
		};

		_ctrlTime = _display displayctrl IDC_RSCATTRIBUTECOUNTDOWN_TIME;
		_ctrlTime ctrlsettext _text;
	};
};