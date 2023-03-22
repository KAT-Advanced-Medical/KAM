// Includes
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_object"];
_action 	= _this param [0, "", [""]];
_parameters = _this param [1, [], [[]]];
_object 	= _this param [2, objNull, [objNull]];

// Sub-functions
switch _action do {
	case "onLoad": {
		// The display
		private "_display";
		_display = _parameters param [0, displayNull, [displayNull]];
		
		// The list box
		private "_listBox";
		_listBox = _display displayCtrl IDC_RSCATTRIBUTETARGETDATA_VALUE;
		
		// Fill the list box
		["uiFillTable", [_object, _listBox]] call BIS_fnc_target;
		
		// Store object within ui namespace
		missionNamespace setVariable ["RscAttributeTargetData_target", _object];
		
		// The custom button
		private "_button";
		_button = _display displayCtrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;
		_button ctrlSetText "Board";								// Localize
		_button ctrlSetTooltip "When clicked, all players will see this Target's Score Board";	// Localize
		_button ctrlAddEventHandler ["buttonclick", { ["uiOpenToAll", [missionNamespace getVariable ["RscAttributeTargetData_target", objNull]]] call BIS_fnc_target; }];
	};
	
	case "confirmed": {
		
	};
	
	case "onUnload": {
		missionNamespace setVariable ["RscAttributeTargetData_target", nil];
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
