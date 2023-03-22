#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#include "\A3\ui_f\scripts\IGUI\RscMissionStatus.sqf"

_mode = _this select 0;
_params = _this select 1;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_logic = getassignedcuratorlogic player;
		missionnamespace setvariable ["RscDisplayCurator_logic",_logic];

		RscDisplayCurator_screenshotMode = false;
		RscDisplayCurator_keys = [];
		RscDisplayCurator_keys resize 255;
		RscDisplayCurator_sections = [0,0];
		showhud true;


			_ctrlBlack = _display displayctrl IDC_RSCDISPLAYCURATOR_BLACK;
			_ctrlBlack ctrlsetfade 1;
			_ctrlBlack ctrlcommit 1;
			_ctrlBlack ctrlenable false;

		player playactionnow "gear";

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with (uinamespace) do {['toggleTree',_this + [false],''] call RscDisplayCurator_script;};"];
		} foreach [
			IDC_RSCDISPLAYCURATOR_ADDBARTITLE,
			IDC_RSCDISPLAYCURATOR_MISSIONBARTITLE
		];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with (uinamespace) do {['modeChanged',_this,''] call RscDisplayCurator_script;};"];
		} foreach [
			IDC_RSCDISPLAYCURATOR_MODEUNITS,
			IDC_RSCDISPLAYCURATOR_MODEGROUPS,
			IDC_RSCDISPLAYCURATOR_MODEMODULES,
			IDC_RSCDISPLAYCURATOR_MODEMARKERS,
			IDC_RSCDISPLAYCURATOR_MODERECENT
		];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with (uinamespace) do {['sideChanged',_this,''] call RscDisplayCurator_script;};"];
		} foreach [
			IDC_RSCDISPLAYCURATOR_SIDEBLUFOR,
			IDC_RSCDISPLAYCURATOR_SIDEOPFOR,
			IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT,
			IDC_RSCDISPLAYCURATOR_SIDECIVILIAN,
			IDC_RSCDISPLAYCURATOR_SIDEEMPTY
		];

		//--- Mouse area
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["mousemoving","with (uinamespace) do {RscDisplayCurator_mousePos = [_this select 1,_this select 2];};"];
			_ctrl ctrladdeventhandler ["mouseholding","with (uinamespace) do {RscDisplayCurator_mousePos = [_this select 1,_this select 2];};"];
		} foreach [IDC_RSCDISPLAYCURATOR_MOUSEAREA,IDC_RSCDISPLAYCURATOR_MISSION];

		//--- Hide sidebars
		_sideBars = [
			[
				IDC_RSCDISPLAYCURATOR_MISSION,
				[IDC_RSCDISPLAYCURATOR_ENTITIES]
			],
			[
				IDC_RSCDISPLAYCURATOR_ADD,
				[
					IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
					IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
					IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
					IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
					IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY,
					IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
					IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
					IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER,
					IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV,
					IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY,
					IDC_RSCDISPLAYCURATOR_CREATE_MODULES,
					IDC_RSCDISPLAYCURATOR_CREATE_MARKERS,
					IDC_RSCDISPLAYCURATOR_CREATE_RECENT
				]
			]
		];
		{
			_ctrl = _display displayctrl (_x select 0);
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
			_ctrl ctrlenable false;
			{
				(_display displayctrl _x) ctrlenable false;
			} foreach (_x select 1);
		} foreach _sideBars;

		//--- Toggle clock
		_control = _display displayctrl IDC_RSCDISPLAYCURATOR_CLOCK;
		_control ctrlshow (profilenamespace getvariable ["RscDisplayCurator_watch",true]);

		//--- Toggle compass
		_control = _display displayctrl IDC_RSCDISPLAYCURATOR_COMPASS;
		_control ctrlshow (profilenamespace getvariable ["RscDisplayCurator_compass",true]);

		//--- Hide task notification
		_ctrlNotification = _display displayctrl IDC_RSCNOTIFICATION_NOTIFICATIONAREA;
		_ctrlNotification ctrlshow false;
		_ctrlNotification ctrlenable false;

		//--- Hide hint
		_ctrlHintGroup = _display displayctrl IDC_RSCADVANCEDHINT_HINTGROUP;
		_ctrlHintGroup ctrlshow false;
		_ctrlHintGroup ctrlenable false;

		//--- Hite watermark
		_ctrlWatermark = _display displayctrl IDC_RSCDISPLAYCURATOR_WATERMARK;
		_ctrlWatermark ctrlshow false;
		_ctrlWatermark ctrlenable false;

		//--- Remove ability to exit the interface
		_display displayaddeventhandler ["keydown","with (uinamespace) do {['keyDown',_this,''] call RscDisplayCurator_script;};"];
		_display displayaddeventhandler ["keyup","with (uinamespace) do {['keyUp',_this,''] call RscDisplayCurator_script;};"];
		_display displayaddeventhandler ["mousemoving","with (uinamespace) do {['Loop',_this,''] call RscDisplayCurator_script;};"];
		_display displayaddeventhandler ["mouseholding","with (uinamespace) do {['Loop',_this,''] call RscDisplayCurator_script;};"];

		//--- Set vision mode
		[_logic,0] call bis_fnc_toggleCuratorVisionMode;

		//--- Search field
		_ctrlSearch = _display displayctrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
		_ctrlSearch ctrladdeventhandler ["setfocus",{missionnamespace setvariable ["RscDisplayCurator_search",true];}];
		_ctrlSearch ctrladdeventhandler ["killfocus",{missionnamespace setvariable ["RscDisplayCurator_search",false];}];
		missionnamespace setvariable ["RscDisplayCurator_search",false];

		//--- Draw custom 3D icons
		removemissioneventhandler ["draw3d",_logic getvariable ["bis_fnc_addcuratoricon_draw",-1]];
		RscDisplayCurator_fadeStart = getnumber (configfile >> "cfgcurator" >> "drawobject" >> "3D" >> "startIconFading");
		RscDisplayCurator_fadeEnd = getnumber (configfile >> "cfgcurator" >> "drawobject" >> "3D" >> "endIconFading");
		_draw3d = addmissioneventhandler [
			"draw3d",
			{
				_fadeStart = uinamespace getvariable ["",1000];
				_fadeEnd = uinamespace getvariable ["",2000];
				{
					_icon = _x select 0;
					if (count _icon > 0) then {
						_show3D = _x select 2;
						if (_show3D) then {
							_pos = _icon select 2;
							_dis = _pos distance curatorcamera;
							if (_dis < _fadeEnd) then {
								_coef = linearconversion [_fadeStart,_fadeEnd,_dis,1,0,true];
								_icon set [3,(_icon select 3) * _coef];
								_icon set [4,(_icon select 4) * _coef];
								drawicon3d _icon;
							};
						};
					};
				} foreach +((getassignedcuratorlogic player) getvariable ["bis_fnc_addcuratoricon",[]]);
			}
		];
		_logic setvariable ["bis_fnc_addcuratoricon_draw",_draw3d];

		//--- Draw custom 2D icons
		RscDisplayCurator_iconSize = getnumber (configfile >> "CfgInGameUI" >> "IslandMap" >> "size");
		_ctrlMap = _display displayctrl IDC_RSCDISPLAYCURATOR_MAINMAP;
		_ctrlMap ctrladdeventhandler [
			"draw",
			"
				_iconSize = uinamespace getvariable ['RscDisplayCurator_iconSize',26];
				{
					_icon = _x select 0;
					if (count _icon > 0) then {
						_show2D = _x select 1;
						if (_show2D) then {
							_icon set [3,(_icon select 3) * _iconSize];
							_icon set [4,(_icon select 4) * _iconSize];
							(_this select 0) drawicon _icon;
						};
					};
				} foreach +((getassignedcuratorlogic player) getvariable ['bis_fnc_addcuratoricon',[]]);
			"
		];

		//--- Mission status
		missionnamespace setvariable [
			"RscMissionStatus_buttonClick",
			{
				_target = _this select 0;
				_instant = _this select 1;
				_position = +_target;
				_position set [2,(_position select 2) + 50];
				_dir = direction curatorcamera;
				_position = [_position,100,_dir + 180] call bis_fnc_relpos;
				0 = [_position,_target,!_instant] spawn bis_fnc_setcuratorcamera;
			}
		];

		[_logic,_display,_sideBars] spawn {
			disableserialization;
			_logic = _this select 0;
			_display = _this select 1;
			_sideBars = _this select 2;

			waituntil {!isnull curatorcamera && !([] call bis_fnc_isLoading)};

			//--- Default menu section
			with missionnamespace do {
				if (isnil "RscDisplayCurator_sections") then {RscDisplayCurator_sections = [0,0];};
			};
			_sections = missionnamespace getvariable "RscDisplayCurator_sections";
			_mode = _sections param [0,0,[0]];
			_side = _sections param [1,0,[0]];
			_modeIDC = [
				IDC_RSCDISPLAYCURATOR_MODEUNITS,
				IDC_RSCDISPLAYCURATOR_MODEGROUPS,
				IDC_RSCDISPLAYCURATOR_MODEMODULES,
				IDC_RSCDISPLAYCURATOR_MODEMARKERS,
				IDC_RSCDISPLAYCURATOR_MODERECENT
			] select (_mode max 0 min 4);
			_sideIDC = [
				IDC_RSCDISPLAYCURATOR_SIDEBLUFOR,
				IDC_RSCDISPLAYCURATOR_SIDEOPFOR,
				IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT,
				IDC_RSCDISPLAYCURATOR_SIDECIVILIAN,
				IDC_RSCDISPLAYCURATOR_SIDEEMPTY
			] select (_side max 0 min 4);

			_modeControl = if (_mode > 0) then {_display displayctrl _modeIDC} else {_display displayctrl IDC_RSCDISPLAYCURATOR_MODEUNITS};
			ctrlactivate _modeControl;
			["modeChanged",[_modeControl],""] call RscDisplayCurator_script;

			_sideControl = if (_side > 0) then {_display displayctrl _sideIDC} else {_display displayctrl IDC_RSCDISPLAYCURATOR_SIDEBLUFOR};
			ctrlactivate _sideControl;
			["sideChanged",[_sideControl],""] call RscDisplayCurator_script;

			//--- Toggle compass
			showcuratorcompass (profilenamespace getvariable ["RscDisplayCurator_compass",true]);

			//--- Set default camera
			_cameraParams = _logic getvariable "bis_fnc_modulecuratorsetcamera_params";
			if !(isnil "_cameraParams") then {_cameraParams call bis_fnc_setcuratorcamera;};
			cameraEffectEnableHUD true;

			//--- Show sidebars
			_sidebarShow = missionnamespace getvariable ["RscDisplayCurator_sidebarShow",[true,true]];
			{
				_show = _sidebarShow param [_foreachindex,true,[true]];
				if (_show) then {
					_ctrl = _display displayctrl (_x select 0);
					_ctrl ctrlsetfade 0;
					_ctrl ctrlcommit 0.1;
					{
						(_display displayctrl _x) ctrlenable true;
					} foreach (_x select 1);
					_ctrl ctrlenable true;
				};
			} foreach _sideBars;

			//--- Fade in
			_ctrlBlack = _display displayctrl IDC_RSCDISPLAYCURATOR_BLACK;
			_ctrlBlack ctrlsetfade 1;
			_ctrlBlack ctrlcommit 1;
			_ctrlBlack ctrlenable false;
			("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","black in"];
		};

		//--- Hide existing hints
		("RscAdvancedHint" call bis_fnc_rsclayer) cuttext ["","plain"];

		//--- Show modules
		{
			if ((_x call bis_fnc_objectside) == sidelogic) then {_x hideobject false;};
		} foreach (curatoreditableobjects _logic + (_logic getvariable ["hideObjects",[]]));

		//--- Let outside systems now that the interface was opened withing this game session
		uinamespace setvariable ["RscDisplayCurator_opened",true];
	};

	//--- Rendertarget camera update. ToDo: Move to engine
	case "Loop": {
		_display = _params select 0;
		_logic = getassignedcuratorlogic player;

		//--- Update clock
		_ctrlClock = _display displayctrl IDC_RSCDISPLAYCURATOR_CLOCK;
		if (ctrlshown _ctrlClock && time > (_logic getvariable ["clocktime",0])) then {
			_ctrlClockDuration = _display displayctrl IDC_RSCDISPLAYCURATOR_CLOCKDURATION;
			_ctrlClockDaytime = _display displayctrl IDC_RSCDISPLAYCURATOR_CLOCKDAYTIME;
			_ctrlClockCountdown = _display displayctrl IDC_RSCDISPLAYCURATOR_CLOCKCOUNTDOWN;

			_countdown = [] call bis_fnc_missionTimeLeft;
			_countdownText = if (_countdown < 0) then {"-:--:--"} else {[_countdown / 3600] call bis_fnc_timetostring};

			_ctrlClockDuration ctrlsettext ("+" + ([time / 3600] call bis_fnc_timetostring));
			_ctrlClockDaytime ctrlsettext ([daytime,"HH:MM"] call bis_fnc_timetostring);
			_ctrlClockCountdown ctrlsettext ("-" + _countdownText);

			_logic setvariable ["clocktime",time + 1];
		};

		//--- Let Eagle circle around camera
		_bird = _logic getvariable ["bird",objnull];
		if (time > (_logic getvariable ["birdtime",0])) then {
			_pos = [
				(position curatorCamera select 0) - 21 + random 42,
				(position curatorCamera select 1) - 21 + random 42,
				70
			];
			if (_bird distance _pos > 1000) then {_bird setpos _pos;};
			_bird camsetpos _pos;
			_bird camcommit 0;
			_logic setvariable ["birdtime",time + 1];
		};
	};
	case "keyDown": {
		_display = _params select 0;
		_key = _params select 1;
		_shift = _params select 2;
		_ctrl = _params select 3;
		_return = false;
		_button = controlnull;
		_buttonMode = "";

		//--- Terminate when focus is in the search field
		if (missionnamespace getvariable ["RscDisplayCurator_search",false]) exitwith { };

		//--- Terminate when the key is already held to prevent repeat call
		if !(isnil {RscDisplayCurator_keys select _key}) exitwith {};

		switch true do {
			case (_key in (actionKeys 'curatorInterface')): { //--- Prevent closing the interface when it's forced
				_return = [] call bis_fnc_isForcedCuratorInterface;
				if (_return) then {
					[objnull,000] spawn bis_fnc_showCuratorFeedbackMessage;
				};
			};
			case (_key in actionkeys 'help'): { //--- Show advanced hint (hijack of BIS_fnc_advHint)
				with missionnamespace do {
					BIS_fnc_advHint_HPressed = "true";
					[true] call BIS_fnc_AdvHintCall;
				};
				_return = "true";
			};
			case (_key in actionkeys 'curatorPersonView'): { //--- Toggle unit view
				if (cameraon == player && isNil {missionNamespace getVariable "BIS_curator_observedUnit"}) then {
					_objects = curatorselected select 0;
					{
						if (side group _x in [east,west,resistance,civilian]) exitwith {
							_x switchcamera "internal";
							_x cameraeffect ["terminate","back"];
							("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","black in"];
							missionNamespace setVariable ["BIS_curator_observedUnit", _x];

							_x spawn {
								waituntil {cameraon != _this || {isnull group _this} || {!alive _this}};
								if (!isnull curatorcamera && cameraon == _this) then {
									curatorcamera cameraeffect ["internal","back"];
									player switchcamera "internal";
									("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","black in"];
									missionNamespace setVariable ["BIS_curator_observedUnit", nil];
								};
							};
						};
					} foreach _objects;
				} else {
					curatorcamera cameraeffect ["internal","back"];
					player switchcamera "internal";
					("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","black in"];
					missionNamespace setVariable ["BIS_curator_observedUnit", nil];
				};
				_return = "true";
			};
			case (_key in actionkeys 'curatorNightvision'): { //--- Toggle vision mode
				[getassignedcuratorlogic player,if (_ctrl) then {-1} else {+1}] call bis_fnc_toggleCuratorVisionMode;
				_return = "true";
			};
			case (_key in actionkeys 'curatorCompass'): { //--- Toggle compass
				showcuratorcompass !showncuratorcompass;
				_control = _display displayctrl IDC_RSCDISPLAYCURATOR_COMPASS;
				_control ctrlshow showncuratorcompass;
				profilenamespace setvariable ["RscDisplayCurator_compass",ctrlshown _control];
				saveprofilenamespace;
			};
			case (_key in actionkeys 'curatorWatch'): { //--- Toggle clock
				_control = _display displayctrl IDC_RSCDISPLAYCURATOR_CLOCK;
				_control ctrlshow !(ctrlshown _control);
				profilenamespace setvariable ["RscDisplayCurator_watch",ctrlshown _control];
				saveprofilenamespace;
			};
			case (_key in actionkeys 'curatorMapTextures'): { //--- Toggle map textures
				_control = _display displayctrl IDC_MAP_TEXTURES;
				ctrlactivate _control;
			};
			case (_key == DIK_TAB): { //--- Toggle editing modes

				_index = -1;
				{
					if ({ctrlshown (_display displayctrl _x)} count _x > 0) exitwith {_index = _foreachindex;};
				} foreach [
					[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY],
					[IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER,IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV,IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY],
					[IDC_RSCDISPLAYCURATOR_CREATE_MODULES],
					[IDC_RSCDISPLAYCURATOR_CREATE_MARKERS],
					[IDC_RSCDISPLAYCURATOR_CREATE_RECENT]
				];
				_index = if (_ctrl) then {((_index - 1) + 5) % 5} else {(_index + 1) % 5};
				_idc = [IDC_RSCDISPLAYCURATOR_MODEUNITS,IDC_RSCDISPLAYCURATOR_MODEGROUPS,IDC_RSCDISPLAYCURATOR_MODEMODULES,IDC_RSCDISPLAYCURATOR_MODEMARKERS,IDC_RSCDISPLAYCURATOR_MODERECENT] select _index;
				_button = _display displayctrl _idc;
				ctrlactivate _button;
				["modeChanged",[_button],""] call RscDisplayCurator_script;
				["toggleTree",[_display displayctrl IDC_RSCDISPLAYCURATOR_ADDBARTITLE,true],""] call RscDisplayCurator_script;
			};
			case (_key in actionkeys 'curatorPingView'): { //--- Go to last ping
				_target = missionnamespace getvariable "bis_fnc_curatorPinged_player";
				if !(isnil "_target") then {
					_pos = getposatl _target;
					_posZ = (getposatl curatorcamera select 2) max 5;
					_pos set [2,(_pos select 2) + _posZ];
					_pos = [_pos,_posZ * 2,direction curatorcamera + 180] call bis_fnc_relpos;
					[_pos,_target] spawn bis_fnc_setcuratorcamera;
				};
				_return = "true";
			};
			case (_key in actionkeys 'curatorToggleInterface'): { //--- Screenshot mode
				RscDisplayCurator_screenshotMode = !RscDisplayCurator_screenshotMode;
				_fade = [0,1] select RscDisplayCurator_screenshotMode;
				{
					_control = _display displayctrl _x;
					_control ctrlenable !(RscDisplayCurator_screenshotMode);
					_control ctrlsetfade _fade;
					_control ctrlcommit 0.1;
				} foreach [
					IDC_RSCDISPLAYCURATOR_MAIN,
					IDC_RSCDISPLAYCURATOR_ADDBAR,
					IDC_RSCDISPLAYCURATOR_ADD,
					IDC_RSCDISPLAYCURATOR_MISSIONBAR,
					IDC_RSCDISPLAYCURATOR_MISSION,
					IDC_RSCMISSIONSTATUS_RSCMISSIONSTATUS
				];
				{
					_control = _display displayctrl _x;
					_control ctrlsetfade _fade;
					_control ctrlcommit 0.1;
				} foreach [
					IDC_RSCDISPLAYCURATOR_COMPASS,
					IDC_RSCDISPLAYCURATOR_CLOCK,
					IDC_RSCNOTIFICATION_NOTIFICATIONAREA,
					IDC_RSCADVANCEDHINT_HINTGROUP
				];
				if !(RscDisplayCurator_screenshotMode) then {
					_sidebarShow = missionnamespace getvariable ["RscDisplayCurator_sidebarShow",[true,true]];
					{
						_show = _sidebarShow param [_foreachindex,true,[true]];
						if !(_show) then {
							_control = _display displayctrl _x;
							_control ctrlsetfade 1;
							_control ctrlcommit 0;
							_control ctrlenable false;
						};
					} foreach [
						IDC_RSCDISPLAYCURATOR_MISSION,
						IDC_RSCDISPLAYCURATOR_ADD
					];
				};

				//--- Toggle modules
				_logic = getassignedcuratorlogic player;
				{
					if ((_x call bis_fnc_objectside) == sidelogic) then {_x hideobject RscDisplayCurator_screenshotMode;};
				} foreach (curatoreditableobjects _logic + (_logic getvariable ["hideObjects",[]]));

				showHUD !RscDisplayCurator_screenshotMode;
				_showWatermark = RscDisplayCurator_screenshotMode;
				if (_ctrl && _shift) then {_showWatermark = false;};
				_ctrlWatermark = _display displayctrl IDC_RSCDISPLAYCURATOR_WATERMARK;
				_ctrlWatermark ctrlshow _showWatermark;
				_return = "true";
			};
			case (_key in actionkeys 'curatorToggleEdit'): { //--- Switch section
				["toggleTree",[_display displayctrl IDC_RSCDISPLAYCURATOR_MISSIONBARTITLE,false],""] call RscDisplayCurator_script;
				_return = "true";
			};
			case (_key in actionkeys 'curatorToggleCreate'): { //--- Switch section
				["toggleTree",[_display displayctrl IDC_RSCDISPLAYCURATOR_ADDBARTITLE,false],""] call RscDisplayCurator_script;
				_return = "true";
			};
			case (_key == DIK_F1);
			case (_key == DIK_F2);
			case (_key == DIK_F3);
			case (_key == DIK_F4);
			case (_key == DIK_F5);
			case (_key == DIK_F6);
			case (_key == DIK_F7);
			case (_key == DIK_F8);
			case (_key == DIK_F9);
			case (_key == DIK_F10);
			case (_key == DIK_F11);
			case (_key == DIK_F12): {
				["cameraView",[_key,_ctrl],""] call RscDisplayCurator_script;
			};
		};
		RscDisplayCurator_keys set [_key,true];
		_return
	};
	case "keyUp": {
		_key = _params select 1;
		RscDisplayCurator_keys set [_key,nil];
	};
	case "toggleTree": {
		_ctrlTitle = _params select 0;
		_index = if (ctrlidc _ctrlTitle == IDC_RSCDISPLAYCURATOR_MISSIONBARTITLE) then {0} else {1};
		_ctrlTitleGroup = _display displayctrl ([IDC_RSCDISPLAYCURATOR_MISSIONBAR,IDC_RSCDISPLAYCURATOR_ADDBAR] select _index);
		if (!ctrlenabled _ctrlTitle || (ctrlfade _ctrlTitleGroup) > 0) exitwith {};

		_force = _params select 1;
		_display = ctrlparent _ctrlTitle;
		_ctrlGroupIDC = [IDC_RSCDISPLAYCURATOR_MISSION,IDC_RSCDISPLAYCURATOR_ADD] select _index;
		_ctrlGroup = _display displayctrl _ctrlGroupIDC;

		//--- Hide the group
		_fade = if (_force) then {0} else {(ctrlfade _ctrlGroup + 1) % 2};
		_enable = _fade == 0;
		_ctrlGroup ctrlenable _enable;
		_ctrlGroup ctrlsetfade _fade;
		_ctrlGroup ctrlcommit 0.1;

		//--- Disable the sub-elements (group cannot be disabled)
		_children = [
			[
				IDC_RSCDISPLAYCURATOR_ENTITIES
			],
			[
				IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
				IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
				IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
				IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
				IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY,
				IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
				IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
				IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER,
				IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV,
				IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY,
				IDC_RSCDISPLAYCURATOR_CREATE_MODULES,
				IDC_RSCDISPLAYCURATOR_CREATE_MARKERS,
				IDC_RSCDISPLAYCURATOR_CREATE_RECENT
			]
		] select _index;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlenable _enable;
		} foreach _children;

		//--- Save visibility of sidebars
		_sidebarShow = missionnamespace getvariable ["RscDisplayCurator_sidebarShow",[true,true]];
		_sidebarShow set [_index,_enable];
		missionnamespace setvariable ["RscDisplayCurator_sidebarShow",_sidebarShow];
	};
	case "modeChanged": {
		_ctrlSelected = _params select 0;
		_display = ctrlparent _ctrlSelected;
		_mode = 0;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.5];
			_scale = 0.8;
			_color = [1,1,1,0.5];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1;
				_color = [1,1,1,1];
				_mode = _foreachindex;
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,0.1] call bis_fnc_ctrlsetscale;
		} foreach [
			IDC_RSCDISPLAYCURATOR_MODEUNITS,
			IDC_RSCDISPLAYCURATOR_MODEGROUPS,
			IDC_RSCDISPLAYCURATOR_MODEMODULES,
			IDC_RSCDISPLAYCURATOR_MODEMARKERS,
			IDC_RSCDISPLAYCURATOR_MODERECENT
		];
		with missionnamespace do {
			RscDisplayCurator_sections set [0,_mode];
		};
		false
	};
	case "sideChanged": {
		_ctrlSelected = _params select 0;
		_display = ctrlparent _ctrlSelected;
		_selectedColor = [0,0,0,0];
		_side = 0;
		{
			_ctrl = _display displayctrl _x;

			_color = _foreachindex call bis_fnc_sidecolor;
			_scale = 0.8;
			if (_ctrl == _ctrlSelected) then {
				_selectedColor = _color;
				_scale = 1;
				_side = _foreachindex;
			} else {
				_color set [3,0.5];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,0.1] call bis_fnc_ctrlsetscale;
		} foreach [
			IDC_RSCDISPLAYCURATOR_SIDEOPFOR,
			IDC_RSCDISPLAYCURATOR_SIDEBLUFOR,
			IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT,
			IDC_RSCDISPLAYCURATOR_SIDECIVILIAN,
			IDC_RSCDISPLAYCURATOR_SIDEEMPTY
		];

		_selectedColor set [3,0.1];
		_createBackground = _display displayctrl IDC_RSCDISPLAYCURATOR_CREATECLASSESBACKGROUND;
		_createBackground ctrlsetbackgroundcolor _selectedColor;
		with missionnamespace do {
			RscDisplayCurator_sections set [1,_side];
		};
		false
	};
	case "cameraView": {
		_key = _params select 0;
		_ctrl = _params select 1;
		_keyID = [DIK_F1,DIK_F2,DIK_F3,DIK_F4,DIK_F5,DIK_F6,DIK_F7,DIK_F8,DIK_F9,DIK_F10,DIK_F11,DIK_F12] find _key;
		_cameraData = missionnamespace getvariable ["RscDisplayCurator",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		if (_ctrl) then {
			//--- Save camera position
			_cameraData set [_keyID,[getposatl curatorcamera,vectordir curatorcamera,vectorup curatorcamera]];
			missionnamespace setvariable ["RscDisplayCurator",_cameraData];
			("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","white in",0.5];
		} else {
			//--- Restore camera position
			_data = _cameraData select _keyID;
			if (count _data == 3) then {
				curatorcamera setposatl (_data select 0);
				curatorcamera setvectordir (_data select 1);
				curatorcamera setvectorup (_data select 2);
				("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","black in",0.5];
			};
		};
	};
	case "onUnload": {
		_logic = missionnamespace getvariable ["RscDisplayCurator_logic",getassignedcuratorlogic player];
		missionnamespace setvariable ["RscDisplayCurator_logic",nil];
		//_rendertargetcurator0 = _logic getvariable ["rendertargetcurator0",objnull];
		//_rendertargetcurator0 cameraeffect ["terminate","back"];
		camdestroy _rendertargetcurator0;
		vehicle player switchcamera cameraview;
		showhud true;

		//ppEffectDestroy (_logic getvariable ["ppColor",-1]);

		//--- Remove custom icons
		RscDisplayCurator_iconSize = nil;
		RscDisplayCurator_fadeStart = nil;
		RscDisplayCurator_fadeEnd = nil;
		removemissioneventhandler ["draw3d",_logic getvariable ["bis_fnc_addcuratoricon_draw",-1]];

		//--- Bird
		_bird = _logic getvariable ["bird",objnull];
		_bird setpos [100,100,100];

		//--- Hide modules
		{
			if ((_x call bis_fnc_objectside) == sidelogic) then {_x hideobject true;};
		} foreach (curatoreditableobjects _logic + (_logic getvariable ["hideObjects",[]]));

		_logic setvariable ["bis_fnc_modulecuratorsetcamera_params",[getposatl curatorcamera,vectordir curatorcamera]];

		//--- Outro effect
		("RscDisplayCurator" call bis_fnc_rscLayer) cuttext ["","black in"];
	};
};
