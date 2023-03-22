// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_object"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_object		= _this param [2, objNull, [objNull]];

// The tool box IDC
private "_idcToolBox";
_idcToolBox = IDC_RSCATTRIBUTETARGETSTATE_VALUE;

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
		_ctrlToolBox ctrlAddEventHandler ["ToolBoxSelChanged", { with uiNamespace do { RscAttributeTargetState_value = _this select 1; }; }];
		
		// Set the default value
		_ctrlToolBox lbSetCurSel (round (_object animationPhase (["getAnimatedSelection", [_object]] call BIS_fnc_target)));
	};
	
	case "confirmed": {
		// The old and new state
		private ["_oldState", "_newState"];
		_oldState = round (_object animationPhase (["getAnimatedSelection", [_object]] call BIS_fnc_target));
		_newState = uiNamespace getVariable ["RscAttributeTargetState_value", _object getVariable ["RscAttributeTargetState", 0]];
		
		// Do the states differ
		if (_oldState != _newState) then {
			// Store the new state
			_object setVariable ["RscAttributeTargetState", _newState, true];
			
			// Figure out what is the current animation state
			private "_animationPhaseString";
			_animationPhaseString = ["getAnimationPhaseString", [_object]] call BIS_fnc_target;
			
			// The animation direction
			private "_direction";
			_direction = if (_animationPhaseString == "up") then { "down" } else { "up" };
			
			// Animate target
			["animate", [_object, _direction]] call BIS_fnc_target;
		};
	};
	
	case "onUnload": {
		// Reset
		RscAttributeTargetState_value = nil;
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
