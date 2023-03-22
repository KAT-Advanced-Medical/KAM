// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_logic"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_logic 		= _this param [2, objNull, [objNull]];

// The Edit control IDC
private "_idcEdit";
_idcEdit = IDC_RSCATTRIBUTEHINTCUSTOM_EDITTITLE;

// Sub-functions
switch _action do {
	case "onLoad": {
		
	};
	
	case "confirmed": {
		// Parameters
		private ["_display"];
		_display = _parameters select 0;
		
		// The Edit control
		private "_edit";
		_edit = _display displayCtrl _idcEdit;
		
		// Check text
		private "_text";
		_text = ctrlText _edit;
		
		// Store
		_logic setVariable ["custom", _text, true];
	};
	
	case "onUnload": {
		
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
