// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_object"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_object		= _this param [2, objNull, [objNull]];

// The tool box IDC
private "_idcToolBox";
_idcToolBox = IDC_RSCATTRIBUTETARGETPOPUP_VALUE;

// Sub-functions
switch _action do {
	case "onLoad": {
		// The display
		private "_display";
		_display = _parameters param [0, displayNull, [displayNull]];
		
		// The tool box
		private "_ctrlToolBox";
		_ctrlToolBox = _display displayCtrl _idcToolBox;
		
		// Add event handler
		_ctrlToolBox ctrlAddEventHandler ["ToolBoxSelChanged", { with uiNamespace do { RscAttributeTargetPopup_value = _this select 1; }; }];
		
		// Set the default value
		if (_object getVariable ["RscAttributeTargetPopup", 0] < 1) then {
			_ctrlToolBox lbSetCurSel 0;
		} else {
			_ctrlToolBox lbSetCurSel 1;
		};
	};
	
	case "confirmed": {
		// Store
		_object setVariable ["RscAttributeTargetPopup", uiNamespace getVariable ["RscAttributeTargetPopup_value", _object getVariable ["RscAttributeTargetPopup", 0]], true];
	};
	
	case "onUnload": {
		// Reset
		RscAttributeTargetPopup_value = nil;
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
