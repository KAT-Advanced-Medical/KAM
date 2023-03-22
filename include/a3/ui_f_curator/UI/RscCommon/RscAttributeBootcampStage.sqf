// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_logic"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_logic 		= _this param [2, objNull, [objNull]];

// Stages pictures/buttons IDCs
private "_idcs";
_idcs = [
	IDC_RSCATTRIBUTEBOOTCAMPSTAGE_INFANTRY,
	IDC_RSCATTRIBUTEBOOTCAMPSTAGE_MOTORIZEDVEHICLES
];

// Sub-functions
switch _action do {
	case "onLoad": {
		// Parameters
		private ["_display"];
		_display = _parameters select 0;

		// Add handlers to all buttons
		// If Stage of button is already completed we do not add handler to this
		// Image should also change to Green
		{
			// The control
			private "_ctrl";
			_ctrl = _display displayCtrl _x;

			// Flags
			private ["_isCompleted", "_isCurrent"];
			_isCompleted	= false;
			_isCurrent	= false;

			// We need to use missionNamespace
			with missionNamespace do {
				_isCompleted	= ["isStageIndexCompleted", [_forEachIndex]] call BIS_fnc_flow;
				_isCurrent	= ["isStageIndexCurrent", [_forEachIndex]] call BIS_fnc_flow;
			};

			// If completed, add event handlers, otherwise mark button with green color
			if (!_isCompleted && !_isCurrent) then {
				_ctrl ctrlAddEventHandler ["buttonclick", "with uinamespace do {['onButtonClick',[_this select 0, 0.1]] call RscAttributeBootcampStage};"];
				_ctrl ctrlSetTextColor [1,1,1,0.5];
				["Todo: %1", _ctrl] call BIS_fnc_logFormat;
			} else {
				// In progress or completed
				if (_isCurrent) then {
					// In progress
					_ctrl ctrlSetTextColor [1,1,0,0.5];
					["In Progress: %1", _ctrl] call BIS_fnc_logFormat;
				} else {
					// Completed
					_ctrl ctrlSetTextColor [0,1,0,0.5];
					["Completed: %1", _ctrl] call BIS_fnc_logFormat;
				};
			};

			// Set scale and commit
			[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
			_ctrl ctrlCommit 0;
		} foreach _idcs;

		// The custom button
		private "_pauseButton";
		_pauseButton = _display displayCtrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;
		_pauseButton ctrlSetText localize "STR_A3_rscattributebootcampstage_pause";
		_pauseButton ctrlSetTooltip localize "STR_A3_rscattributebootcampstage_pause_tooltip";

		// Whether there is a Stage currently selected
		private "_isStageSelected";
		_isStageSelected = false;

		// We need to use missionNamespace
		with missionNamespace do {
			_isStageSelected = ["isStageSelected"] call BIS_fnc_flow;
		};

		// Hide button if not needed
		if (_isStageSelected) then {
			_pauseButton ctrlEnable true;
			_pauseButton ctrlAddEventHandler ["buttonclick", { ["setCurrentStage", [""]] call BIS_fnc_flow; closeDialog 0; }];
		} else {
			_pauseButton ctrlEnable false;
		};

		// Log
		["OnLoad (%1)", _parameters] call BIS_fnc_logFormat;
	};

	case "onButtonClick": {
		// Parameters
		private ["_stageCtrl", "_delay"];
		_stageCtrl 	= _parameters select 0;
		_delay 		= _parameters select 1;

		// The display
		private "_display";
		_display = ctrlParent _stageCtrl;

		// Reset all buttons first
		{
			// The button control
			private "_ctrl";
			_ctrl = _display displayCtrl _x;

			// Flags
			private ["_isCompleted", "_isCurrent"];
			_isCompleted	= false;
			_isCurrent	= false;

			// We need to use missionNamespace
			with missionNamespace do {
				_isCompleted	= ["isStageIndexCompleted", [_forEachIndex]] call BIS_fnc_flow;
				_isCurrent	= ["isStageIndexCurrent", [_forEachIndex]] call BIS_fnc_flow;
			};

			if (!_isCompleted && !_isCurrent) then {
				// Todo
				_ctrl ctrlSetTextColor [1,1,1,0.5];
				[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
				_ctrl ctrlCommit 0;
			} else {
				if (_isCurrent) then {
					// In progress
					_ctrl ctrlSetTextColor [1,1,0,0.5];
					[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
					_ctrl ctrlCommit 0;
				} else {
					// Completed
					_ctrl ctrlSetTextColor [0,1,0,0.5];
					[_ctrl, 1, 0] call bis_fnc_ctrlSetScale;
					_ctrl ctrlCommit 0;
				};
			};
		} foreach _idcs;

		// Highlight the currently selected button
		_stageCtrl ctrlSetTextColor [1,1,1,1];
		[_stageCtrl, 1.25, _delay] call bis_fnc_ctrlSetScale;
		_ctrl ctrlCommit 0;

		// Store idc
		uiNamespace setVariable ["RscAttributeTest_stageIndex", _idcs find (ctrlIdc _stageCtrl)];

		// Log
		["OnButtonClicked (%1)", _parameters] call BIS_fnc_logFormat;
	};

	case "confirmed": {
		private "_valid";
		_valid = "true";

		// Namespace is important
		with missionNamespace do {
			// Are there recruits in game
			if (count (["allRecruits"] call BIS_fnc_flow) < 1) then {
				[BIS_curator, localize "STR_A3_rscattributebootcampstage_pause_norecruits"] call BIS_fnc_showCuratorFeedbackMessage;
				_valid = false;
			};
		};
		if (!_valid) exitWith {};

		// The stage index, might be invalid in case the user did not select any Stage in the UI
		private "_stageIndex";
		_stageIndex = uinamespace getVariable ["RscAttributeTest_stageIndex", -1];

		// Log
		["Stage Index (%1)", _stageIndex] call BIS_fnc_logFormat;

		// In case user selected a Stage we proceed
		if (_stageIndex != -1) then {
			// Namespace is important
			with missionNamespace do {
				// Get all the Stages
				private "_stagesIds";
				_stagesIds = ["getStagesIds"] call BIS_fnc_flow;

				// The Stage Id, in case user has selected one
				private "_stageId";
				_stageId = _stagesIds select _stageIndex;

				// Set new Stage as current
				["setCurrentStage", [_stageId]] call BIS_fnc_flow;

				// Get the stage title
				private "_stageTitle";
				_stageTitle = ["getTitle", [_stageId]] call BIS_fnc_stage;

				// Show notification to all connected Instructors and Recruits
				[["BootcampStageChanged", [_stageTitle]], "BIS_fnc_showNotification", nil, false] call BIS_fnc_mp;

				// Log
				["Confirmed - Training Stage (%1) confirmed", _stageId] call BIS_fnc_logFormat;
			};
		} else {
			// Log
			"Confirmed - Training Stage confirmed but no Stage was selected" call BIS_fnc_log;
		};

		// Return
		false;
	};

	case "onUnload": {
		// Reset variables
		uiNamespace setVariable ["RscAttributeTest_stageIndex", nil];

		// Log
		"OnUnload" call BIS_fnc_log;
	};

	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
