// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_object"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_object		= _this param [2, objNull, [objNull]];

// The slider IDC
private "_idcSlider";
_idcSlider = IDC_RSCATTRIBUTETARGETPOPUPDELAY_VALUE;

// Sub-functions
switch _action do {
	case "onLoad": {
		// The display
		private "_display";
		_display = _parameters param [0, displayNull, [displayNull]];
		
		// The delay slider
		private "_slider";
		_slider = _display displayCtrl _idcSlider;
		
		// Set slider range
		_slider sliderSetRange [1, 10];
		
		// Set the initial position
		_slider sliderSetPosition (_object getVariable ["RscAttributeTargetPopupDelay", 2]);
	};
	
	case "confirmed": {
		// The display
		private "_display";
		_display = _parameters param [0, displayNull, [displayNull]];
		
		// The delay slider
		private "_slider";
		_slider = _display displayCtrl _idcSlider;
		
		// The delay value
		private "_delay";
		_delay = sliderPosition _slider;
		
		// Store delay information
		_object setVariable ["RscAttributeTargetPopupDelay", _delay, true];
	};
	
	case "onUnload": {
		
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
