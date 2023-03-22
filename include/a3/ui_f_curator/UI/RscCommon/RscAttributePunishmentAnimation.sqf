// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_logic"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_logic 		= _this param [2, objNull, [objNull]];

// Animation buttons IDCS
private "_idcs";
_idcs = [
	IDC_RSCATTRIBUTEPUNISHMENTANIMATION_PUSHUPS,
	IDC_RSCATTRIBUTEPUNISHMENTANIMATION_LEGPUSHUPS
];

// Sub-functions
switch _action do {
	case "onLoad": {
		// Parameters
		private ["_display"];
		_display = _parameters select 0;
		
		// Go through each button
		{
			// The control
			private "_ctrl";
			_ctrl = _display displayCtrl _x;
			
			// Add event handler
			_ctrl ctrlAddEventHandler ["buttonclick", "with uinamespace do {['onButtonClick',[_this select 0, 0.1]] call RscAttributePunishmentAnimation};"];
			
			// Whether this logic has been clicked
			if (!isNil { _logic getVariable "punishment" }) then {
				// The previously selected index
				private "_index";
				_index = if ((_logic getVariable "punishment") == "AmovPercMstpSnonWnonDnon_exercisePushup") then { 0; } else { 1; };
				
				// Match?
				if (_forEachIndex == _index) then {
					// Set default color and size
					_ctrl ctrlSetTextColor [1,1,1,1];
					[_ctrl, 1.25, 0.1] call bis_fnc_ctrlSetScale;
				} else {
					// Set default color and size
					_ctrl ctrlSetTextColor [1,1,1,0.5];
					[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
				};
			} else {
				// Set default color and size
				_ctrl ctrlSetTextColor [1,1,1,0.5];
				[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
			};
			
			// Commit control changes
			_ctrl ctrlCommit 0;
		} forEach _idcs;
		
		// Log
		["OnLoad (%1)", _parameters] call BIS_fnc_logFormat;
	};
	
	case "onButtonClick" : {
		// Parameters
		private ["_ctrlAnimation", "_delay"];
		_ctrlAnimation 	= _parameters select 0;
		_delay 		= _parameters select 1;
		
		// The display
		private "_display";
		_display = ctrlParent _ctrlAnimation;
		
		// Reset all buttons first
		{
			// The button control
			private "_ctrl";
			_ctrl = _display displayCtrl _x;
			
			// Reset
			_ctrl ctrlSetTextColor [1,1,1,0.5];
			[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
			_ctrl ctrlCommit 0;
		} forEach _idcs;
		
		// Highlight the currently selected button
		_ctrlAnimation ctrlSetTextColor [1,1,1,1];
		[_ctrlAnimation, 1.25, _delay] call bis_fnc_ctrlSetScale;
		_ctrlAnimation ctrlCommit 0;
		
		// Store idc
		uiNamespace setVariable ["RscAttributePunishmentAnimation_index", _idcs find (ctrlIdc _ctrlAnimation)];
		
		// Log
		["OnButtonClicked (%1)", _parameters] call BIS_fnc_logFormat;
	};
	
	case "confirmed": {
		// The animation index, might be invalid in case the user did not select any Animation in the UI
		private "_animationIndex";
		_animationIndex = uinamespace getVariable ["RscAttributePunishmentAnimation_index", -1];
		
		// In case user selected a Stage we proceed
		if (_animationIndex != -1) then {
			// The animation to use
			private "_animation";
			_animation = [
				"AmovPercMstpSnonWnonDnon_exercisePushup",
				"AmovPercMstpSnonWnonDnon_exercisekneeBendA"
			] select _animationIndex;
			
			// Store variable in game logic
			_logic setVariable ["punishment", _animation, true];
		} else {
			// Log
			"Confirmed - Punishment Animation confirmed but no Animation was selected" call BIS_fnc_log;
		};
		
		// Return
		false;
	};
	
	case "onUnload": {
		// Reset variables
		uiNamespace setVariable ["RscAttributePunishmentAnimation_index", nil];
		
		// Log
		"OnUnload" call BIS_fnc_log;
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
