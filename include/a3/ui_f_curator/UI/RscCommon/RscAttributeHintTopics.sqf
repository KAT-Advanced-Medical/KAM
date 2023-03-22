// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_logic"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_logic 		= _this param [2, objNull, [objNull]];

// The tree IDC
private "_idcTree";
_idcTree = IDC_RSCATTRIBUTEHINTTOPICS_VALUE;

// Sub-functions
switch _action do {
	case "onLoad": {
		// Parameters
		private ["_display"];
		_display = _parameters param [0, displayNull, [displayNull]];

		// The tree control
		private "_tree";
		_tree = _display displayCtrl _idcTree;

		// The tree event handler
		_tree ctrlAddEventHandler ["treeSelChanged","with uiNamespace do { ['treeSelChanged', [ctrlParent (_this select 0)]] call RscAttributeHintTopics; };"];

		// We load all Hint topics from configuration file
		private "_topics";
		_topics = ["getTopics"] call RscAttributeHintTopics;

		// Benchmark
		private "_tickStart";
		_tickStart = diag_tickTime;

		// The key color
		private "_keyColor";
		_keyColor = (["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;

		// Add all the Topics to the combo box
		{
			// Make sure topic is valid
			if (_x != "" && toLower _x != "default") then {
				// Topic
				private ["_topicId", "_topicTitle"];
				_topicId 	= _x;
				_topicTitle 	= ["getTopicDisplayName", [_topicId]] call RscAttributeHintTopics;

				// Make sure topic name is valid
				if (_topicTitle != "" && toLower _topicTitle != "default") then
				{
					// Hints under this topic
					private "_hints";
					_hints = ["getHints", [_topicId]] call RscAttributeHintTopics;

					// Add the topic
					private "_topicClass";
					_topicClass = _tree tvAdd [[], _topicTitle];

					// Store topic id
					_tree tvSetData [[_topicClass], _topicId];

					// Sort the topics tree
					_tree tvSort [[_topicClass], false];

					// Add the hints
					{
						// Hint
						private ["_hintId", "_hintTitle"];
						_hintId 	= _x;
						_hintTitle 	= ["getHintDisplayName", [_topicId, _hintId]] call RscAttributeHintTopics;

						// We need to fix the hint arguments in certain special cases
						if (_hintTitle == "%11") then {
							// The hint arguments
							private "_hintArguments";
							_hintArguments = ["getHintArguments", [_topicId, _hintId]] call RscAttributeHintTopics;

							private "_result";
							_result = [_hintArguments, _keyColor] call BIS_fnc_advHintArg;

							// The final hint title
							_hintTitle = format ([_hintTitle] + _result);
						};

						// Add item to tree
						private "_treeHint";
						_treeHint = _tree tvAdd [[_topicClass], _hintTitle];

						// Store hint id
						_tree tvSetData [[_topicClass, _treeHint], _hintId];

						// Sort the hints tree
						_tree tvSort [[_treeHint], false];
					} forEach _hints;
				};
			};
		} forEach _topics;

		// Benchmark
		["Hints loading: %1 ms", diag_tickTime - _tickStart] call BIS_fnc_logFormat;
	};

	case "treeSelChanged" : {
		// Parameters
		private ["_display"];
		_display = _parameters param [0, displayNull, [displayNull]];

		// The tree control
		private "_tree";
		_tree = _display displayCtrl _idcTree;

		// The indexes
		private ["_topicIndex", "_hintIndex"];
		_topicIndex 	= tvCurSel _tree param [0, 0, [0]];
		_hintIndex	= tvCurSel _tree param [1, 0, [0]];

		// The current selected topic and hint
		private ["_topic", "_hint"];
		_topic 	= _tree tvData [_topicIndex];
		_hint	= _tree tvData [_topicIndex, _hintIndex];

		// Log
		["Tree Selection Changed, Topic: %1, Hint: %2", _topic, _hint] call BIS_fnc_logFormat;
	};

	case "getTopics" : {
		// Return
		(configfile >> "CfgHints") call BIS_fnc_getCfgSubClasses;
	};

	case "getHints" : {
		// Parameters
		private ["_topic"];
		_topic = _parameters param [0, "", [""]];

		// Return
		(configfile >> "CfgHints" >> _topic) call BIS_fnc_getCfgSubClasses;
	};

	case "getHintArguments" : {
		// Parameters
		private ["_topic", "_hint"];
		_topic 	= _parameters param [0, "", [""]];
		_hint	= _parameters param [1, "", [""]];

		// Return
		getArray (configfile >> "CfgHints" >> _topic >> _hint >> "Arguments");
	};

	case "getTopicDisplayName" : {
		// Parameters
		private ["_topic"];
		_topic = _parameters param [0, "", [""]];

		// The display name
		private "_displayName";
		_displayName = getText (configFile >> "CfgHints" >> _topic >> "DisplayName");

		// Return
		_displayName;
	};

	case "getHintDisplayName" : {
		// Parameters
		private ["_topic", "_hint"];
		_topic 	= _parameters param [0, "", [""]];
		_hint 	= _parameters param [1, "", [""]];

		// The display name
		private "_displayName";
		_displayName = getText (configFile >> "CfgHints" >> _topic >> _hint >> "displayName");

		// Return
		_displayName;
	};

	case "confirmed": {
		// Parameters
		private ["_display"];
		_display = _parameters param [0, displayNull, [displayNull]];

		// The tree control
		private "_tree";
		_tree = _display displayCtrl _idcTree;

		// The indexes
		private ["_topicIndex", "_hintIndex"];
		_topicIndex 	= tvCurSel _tree param [0, 0, [0]];
		_hintIndex	= tvCurSel _tree param [1, 0, [0]];

		// The current selected topic and hint
		private ["_topic", "_hint"];
		_topic 	= _tree tvData [_topicIndex];
		_hint	= _tree tvData [_topicIndex, _hintIndex];

		// Store
		_logic setVariable ["topic", _topic, true];
		_logic setVariable ["hint", _hint, true];
	};

	case "onUnload": {

	};

	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
