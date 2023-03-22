#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcTabs = [
	IDC_RSCATTRIBUTEOWNERS_TABSIDE,
	IDC_RSCATTRIBUTEOWNERS_TABGROUP,
	IDC_RSCATTRIBUTEOWNERS_TABUNIT
];
_idcGroups = [
	IDC_RSCATTRIBUTEOWNERS_SIDE,
	IDC_RSCATTRIBUTEOWNERS_GROUP,
	IDC_RSCATTRIBUTEOWNERS_UNIT
];
_idcSides = [
	IDC_RSCATTRIBUTEOWNERS_OPFOR,
	IDC_RSCATTRIBUTEOWNERS_BLUFOR,
	IDC_RSCATTRIBUTEOWNERS_INDEPENDENT,
	IDC_RSCATTRIBUTEOWNERS_CIVILIAN
];
_idcGroups = [
	_idcSides,
	[IDC_RSCATTRIBUTEOWNERS_GROUPLIST],
	[IDC_RSCATTRIBUTEOWNERS_UNITLIST]
];

switch _mode do {
	case "onLoad": {

		//--- Get default / remembered owners
		_selected = +(_unit getvariable "RscAttributeOwners");
		if (isnil "_selected") then {
			_selected = missionnamespace getvariable "RscAttributeOwners_sides";
			if (isnil "_selected") then {
				_selected = [];
				{
					if (playableslotsnumber _x > 0) then {_selected set [count _selected,_x];};
				} foreach [east,west,civilian,resistance];
			};
		};
		_selectedUnit = _unit getvariable ["RscAttributeOwners",[]];
		RscAttributeOwners_sides = [];
		_tab = if (count _selected > 0) then {
			switch (typename (_selected select 0)) do {
				case (typename objnull): {2};
				case (typename grpnull): {1};
				default {0};
			};
		} else {
			0
		};

		//--- Init tabs
		_display = _params select 0;
		['switchTab',[_display,_tab]] call RscAttributeOwners;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler [
				"buttonclick",
				format ["with uinamespace do {['switchTab',[ctrlparent (_this select 0),%1]] call RscAttributeOwners;};",_foreachindex]
			];
		} foreach _idcTabs;

		//--- Init side
		_playerside = player call bis_fnc_objectside;
		{
			_ctrl = _display displayctrl _x;
			_side = _foreachindex call bis_fnc_sideType;
			if (/*playableslotsnumber _side > 0 && */[_side,_playerside] call bis_fnc_arefriendly) then {
				_ctrl = _display displayctrl _x;
				_side = _foreachindex call bis_fnc_sideType;

				_color = _foreachindex call bis_fnc_sidecolor;
				_ctrl ctrlsetactivecolor _color;
				_color set [3,0.5];
				_ctrl ctrlsettextcolor _color;

				_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['selectSide',[_this select 0,0.1]] call RscAttributeOwners;};"];
				if (_side in _selected) then {
					['selectSide',[_ctrl,0]] call RscAttributeOwners;
				};
			} else {
				_ctrl ctrlshow false;
			};

			_sideIcons set [count _sideIcons,ctrltext _ctrl];
		} foreach _idcSides;

		//--- Init players and groups
		_sideIcons = [
			gettext (configfile >> "CfgDiary" >> "Icons" >> "playerEast"),
			gettext (configfile >> "CfgDiary" >> "Icons" >> "playerWest"),
			gettext (configfile >> "CfgDiary" >> "Icons" >> "playerGuer"),
			gettext (configfile >> "CfgDiary" >> "Icons" >> "playerCiv")
		];
		_units = [];
		_groups = [];
		_selectedGroup = 0;
		_selectedUnit = 0;
		_ctrlGroupList = _display displayctrl IDC_RSCATTRIBUTEOWNERS_GROUPLIST;
		_ctrlUnitList = _display displayctrl IDC_RSCATTRIBUTEOWNERS_UNITLIST;
		{
			_grp = group _x;
			_grpSideID = (side _grp) call bis_fnc_sideID;
			if (_grpSideID < count _sideIcons) then {
				_grpSideIcon = _sideIcons select _grpSideID;
				if !(_grp in _groups) then {
					//--- Add group
					_groups set [count _groups,_grp];
					_lbAdd = _ctrlGroupList lbadd groupid _grp;
					_ctrlGroupList lbsetvalue [_lbAdd,_lbAdd];
					_ctrlGroupList lbsetpicture [_lbAdd,_grpSideIcon];
					if (_grp in _selected) then {_selectedGroup = _lbAdd;};
				};

				//--- Add player
				_units set [count _units,_x];
				_lbAdd = _ctrlUnitList lbadd name _x;
				_ctrlUnitList lbsetvalue [_lbAdd,_lbAdd];
				_ctrlUnitList lbsetpicture [_lbAdd,_grpSideIcon];
				if (_x in _selected) then {_selectedUnit = _lbAdd;};
			};
		} foreach (playableunits + switchableunits);

		//--- Sort and pre-select existing owners
		lbsort _ctrlGroupList;
		lbsort _ctrlUnitList;
		{if (_ctrlGroupList lbvalue _foreachindex == _selectedGroup) exitwith {_ctrlGroupList lbsetcursel _foreachindex;};} foreach _groups;
		{if (_ctrlUnitList lbvalue _foreachindex == _selectedUnit) exitwith {_ctrlUnitList lbsetcursel _foreachindex;};} foreach _units;
		RscAttributeOwners_groups = _groups;
		RscAttributeOwners_units = _units;
	};
	case "switchTab": {
		private ["_display","_add","_tab"];
		_display = _params select 0;
		_tab = _params select 1;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlenable !(_tab == _foreachindex);
		} foreach _idcTabs;
		{
			_show = _tab == _foreachindex;
			_fade = [1,0] select _show;
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlenable _show;
				_ctrl ctrlsetfade _fade;
				_ctrl ctrlcommit 0;
			} foreach _x;
		} foreach _idcGroups;
	};
	case "selectSide": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;

		_sideID = _idcSides find (ctrlidc _ctrlSelected);
		_side = _sideID call bis_fnc_sideType;
		_color = _sideID call bis_fnc_sidecolor;
		_scale = 1;
		_alpha = 0.5;
		if (_side in RscAttributeOwners_sides) then {
			RscAttributeOwners_sides = RscAttributeOwners_sides - [_side];
		} else {
			if !(_side in RscAttributeOwners_sides) then {
				RscAttributeOwners_sides = RscAttributeOwners_sides + [_side];
			};
			_scale = 1.2;
			_alpha = 1;
		};
		_color set [3,_alpha];
		_ctrlSelected ctrlsettextcolor _color;
		[_ctrlSelected,_scale,_delay] call bis_fnc_ctrlsetscale;
	};
	case "confirmed": {
		_display = _params select 0;
		_tab = 0;
		{
			if !(ctrlenabled (_display displayctrl _x)) exitwith {_tab = _foreachindex;};
		} foreach _idcTabs;

		//--- Based owners on selected tab
		_owners = [];
		switch _tab do {
			case 0: {
				_owners = +(uinamespace getvariable ["RscAttributeOwners_sides",[]]);
			};
			case 1: {
				_ctrlGroupList = _display displayctrl IDC_RSCATTRIBUTEOWNERS_GROUPLIST;
				_owners = [RscAttributeOwners_groups select (_ctrlGroupList lbvalue lbcursel _ctrlGroupList)];
			};
			case 2: {
				_ctrlUnitList = _display displayctrl IDC_RSCATTRIBUTEOWNERS_UNITLIST;
				_owners = [RscAttributeOwners_units select (_ctrlUnitList lbvalue lbcursel _ctrlUnitList)];

			};
		};
		_unit setvariable ["RscAttributeOwners",_owners,true];
		_unit setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		missionnamespace setvariable ["RscAttributeOwners_sides",RscAttributeOwners_sides];
		RscAttributeOwners_sides = nil;
		RscAttributeOwners_groups = nil;
		RscAttributeOwners_units = nil;
	};
};