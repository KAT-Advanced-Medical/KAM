#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEFUEL_VALUE;
		_ctrlSlider slidersetposition (fuel _unit * 10);
		_ctrlSlider ctrlenable alive _unit;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEFUEL_VALUE;
		_fuel = sliderposition _ctrlSlider * 0.1;
		if (abs(fuel _unit - _fuel) < 0.01) exitwith {};
		if (local _unit) then {
			_unit setfuel _fuel;
		} else {
			[[_unit,_fuel],"setFuel",_unit] call bis_fnc_mp;
		};
	};
	case "onUnload": {
	};
};