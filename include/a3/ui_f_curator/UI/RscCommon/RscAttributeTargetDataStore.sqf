// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Defines
#define TRUE 0
#define FALSE 1

// Parameters
private ["_action", "_parameters", "_object"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_object 	= _this param [2, objNull, [objNull]];

// The tool box IDC
private "_idcToolBox";
_idcToolBox = IDC_RSCATTRIBUTETARGETDATASTORE_VALUE;

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
		_ctrlToolBox ctrlAddEventHandler ["ToolBoxSelChanged", { uiNamespace setVariable ["RscAttributeTargetDataStore_value", _this select 1]; }];
		
		// Set the default value
		if (_object getVariable ["RscAttributeTargetDataStore", TRUE] == TRUE) then {
			_ctrlToolBox lbSetCurSel 0;
		} else {
			_ctrlToolBox lbSetCurSel 1;
		};
	};
	
	case "confirmed": {
		// The old state
		private "_stateOld";
		_stateOld = _object getVariable ["RscAttributeTargetDataStore", TRUE];
		
		// Store
		_object setVariable ["RscAttributeTargetDataStore", uiNamespace getVariable ["RscAttributeTargetDataStore_value", _object getVariable ["RscAttributeTargetDataStore", TRUE]], true];
		
		// The new state
		private "_stateNew";
		_stateNew = _object getVariable ["RscAttributeTargetDataStore", TRUE];
		
		// In case the data storing was disabled, we reset the target's shooter's table
		if (_stateNew == FALSE && { _stateOld != _stateNew }) then {
			["resetShootersData", [_object]] call BIS_fnc_target;
		};
	};
	
	case "onUnload": {
		// Reset
		uiNamespace setVariable ["RscAttributeTargetDataStore_value", nil];
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
