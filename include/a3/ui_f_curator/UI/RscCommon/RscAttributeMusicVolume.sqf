#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEMUSICVOLUME_VALUE;
		_ctrlSlider slidersetposition (musicvolume * 10);
		_ctrlSlider ctrladdeventhandler ["sliderposchanged","with uinamespace do {['sliderPosChanged',_this,objnull] call RscAttributeMusicVolume;};"];
		RscAttributeMusicVolume_volume = musicvolume;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEMUSICVOLUME_VALUE;
		_unit setvariable ["RscAttributeMusicVolume",sliderposition _ctrlSlider * 0.1,true];
		RscAttributeMusicVolume_volume = nil;
	};
	case "sliderPosChanged": {
		_ctrlSlider = _params select 0;
		0 fademusic (sliderposition _ctrlSlider * 0.1);
	};
	case "onUnload": {
		0 fademusic (uinamespace getvariable ["RscAttributeMusicVolume_volume",musicvolume]);
	};
};