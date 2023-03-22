#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_unchecked = gettext (configfile >> "RscCheckbox" >> "textureUnchecked");
_checked = gettext (configfile >> "RscCheckbox" >> "textureChecked");

_filterIDCs = [
	IDC_RSCATTRIBUTERESPAWNINVENTORY_FILTER1,
	IDC_RSCATTRIBUTERESPAWNINVENTORY_FILTER0,
	IDC_RSCATTRIBUTERESPAWNINVENTORY_FILTER2,
	IDC_RSCATTRIBUTERESPAWNINVENTORY_FILTER3
];
_treeIDCs = [
	IDC_RSCATTRIBUTERESPAWNINVENTORY_TREEEAST,
	IDC_RSCATTRIBUTERESPAWNINVENTORY_TREEWEST,
	IDC_RSCATTRIBUTERESPAWNINVENTORY_TREEGUER,
	IDC_RSCATTRIBUTERESPAWNINVENTORY_TREECIV
];

switch _mode do {
	case "onLoad": {
		RscAttributeRespawnInventory_tab = if (isnil "RscAttributeRespawnInventory_tab") then {-1} else {RscAttributeRespawnInventory_tab};
		_sideIDs = [0,1,2,3];

		_display = _params select 0;

		_ctrlButtonCustom = _display displayctrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;
		_ctrlButtonCustom ctrlsettext localize "str_disp_arcmap_clear";
		_ctrlButtonCustom ctrladdeventhandler ["buttonclick",{with uinamespace do {["clear",[ctrlparent (_this select 0)],objnull] call RscAttributeRespawnInventory;};}];

		RscAttributeRespawnInventory_objects = [[],[],[],[]];
		RscAttributeRespawnInventory_selected = [
			east call bis_fnc_getrespawninventories,
			west call bis_fnc_getrespawninventories,
			resistance call bis_fnc_getrespawninventories,
			civilian call bis_fnc_getrespawninventories
		];
		_curator = getassignedcuratorlogic player;
		_curatorRegisteredObjects = [];
		if (_curator call bis_fnc_moduleRespawnInventory) then {
			//--- All objects
			{
				{
					_curatorRegisteredObjects set [count _curatorRegisteredObjects,[_x,true,0,0]];
				} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
			} foreach activatedaddons;
		} else {
			//--- Registered curator objects
			_curatorRegisteredObjects = curatorregisteredobjects _curator;
		};
		{
			{
				//--- Force existing loadouts
				_curatorRegisteredObjects set [count _curatorRegisteredObjects,[_x,true,0,0]];
			} foreach _x;
		} foreach RscAttributeRespawnInventory_selected;
		{
			if (_x select 1) then {
				_class = tolower (_x select 0);
				_cfg = configfile >> "cfgvehicles" >> _class;
				_simulation = gettext (_cfg >> "simulation");
				_scope = getnumber (_cfg >> "scope") max getnumber (_cfg >> "scopeCurator");
				_scopeCurator = getnumber (_cfg >> "scopeCurator");
				if (_simulation == "soldier" && _scope > 1 && (_scopeCurator > 1 || !isnumber (_cfg >> "scopeCurator"))) then {
					_side = getnumber (_cfg >> "side");
					if (_side in [0,1,2,3]) then {

						_sideArray = RscAttributeRespawnInventory_objects select _side;

						_faction = gettext (_cfg >> "editorCategory");
						if (_faction == "") then {_faction = gettext (_cfg >> "faction");};
						_factionID = _sideArray find _faction;
						if (_factionID < 0) then {
							_factionID = count _sideArray;
							_sideArray set [_factionID,_faction];
							_sideArray set [_factionID + 1,[]];
						};
						_factionArray = _sideArray select (_factionID + 1);

						_vehicleClass = tolower gettext (_cfg >> "editorSubcategory");
						if (_vehicleClass == "") then {_vehicleClass = tolower gettext (_cfg >> "vehicleClass");};
						_vehicleClassID = _factionArray find _vehicleClass;
						if (_vehicleClassID < 0) then {
							_vehicleClassID = count _factionArray;
							_factionArray set [_vehicleClassID,_vehicleClass];
							_factionArray set [_vehicleClassID + 1,[]];
						};
						_vehicleClass = _factionArray select (_vehicleClassID + 1);

						if !(_class in _vehicleClass) then {
							_vehicleClass set [count _vehicleClass,_class];
						};
					};
				};
			};
		} foreach _curatorRegisteredObjects;

		{
			_ctrlTree = _display displayctrl (_treeIDCs select _foreachindex);
			_sideArray = RscAttributeRespawnInventory_objects select _x;
			_selected = RscAttributeRespawnInventory_selected select _x;
			for "_f" from 0 to (count _sideArray - 1) step 2 do {
				_faction = _sideArray select _f;
				_factionName = gettext (configfile >> "cfgeditorcategories" >> _faction >> "displayname");
				if (_factionName == "") then {_factionName = gettext (configfile >> "cfgfactionclasses" >> _faction >> "displayname");};
				_tvFaction = _ctrlTree tvadd [[],_factionName];
				_ctrlTree tvsetpicture [[_tvFaction],gettext (configfile >> "cfgfactionclasses" >> _faction >> "icon")];

				_factionArray = _sideArray select (_f + 1);
				for "_v" from 0 to (count _factionArray - 1) step 2 do {
					_vehicleClass = _factionArray select _v;
					_vehicleClassName = gettext (configfile >> "cfgeditorsubcategories" >> _vehicleClass >> "displayname");
					if (_vehicleClassName == "") then {_vehicleClassName = gettext (configfile >> "cfgvehicleclasses" >> _vehicleClass >> "displayname");};
					_tvVehicleClass = _ctrlTree tvadd [[_tvFaction],_vehicleClassName];

					{
						_tvClass = _ctrlTree tvadd [[_tvFaction,_tvVehicleClass],gettext (configfile >> "cfgvehicles" >> _x >> "displayname")];
						_ctrlTree tvsetdata [[_tvFaction,_tvVehicleClass,_tvClass],_x];

						_picture = _unchecked;
						_value = 0;
						if (_x in _selected) then {
							_picture = _checked;
							_value = 1;
							_ctrlTree tvexpand [_tvFaction,_tvVehicleClass];
						};
						_ctrlTree tvsetpicture [[_tvFaction,_tvVehicleClass,_tvClass],_picture];
						_ctrlTree tvsetvalue [[_tvFaction,_tvVehicleClass,_tvClass],_value];
					} foreach (_factionArray select (_v + 1));
					_ctrlTree tvsort [[_tvFaction,_tvVehicleClass],false];
				};
				_ctrlTree tvsort [[_tvFaction],false];
				_ctrlTree tvexpand [_tvFaction];
			};

			//--- Load custom Arsenal loadouts
			_arsenalData = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
			if (count _arsenalData > 0) then {
				_tvArsenal = _ctrlTree tvadd [[],"<" + localize "STR_A3_Arsenal" + ">"];
				_tvAll = _ctrlTree tvadd [[_tvArsenal],localize "STR_gear_all"];
				_ctrlTree tvsetpicture [[_tvArsenal],gettext (configfile >> "RscDisplayArsenal" >> "icon")];
				for "_i" from 0 to (count _arsenalData - 1) step 2 do {
					_name = _arsenalData select _i;
					_var = "missionnamespace:" + _name;
					_picture = _unchecked;
					_value = 0;
					if (_var in _selected) then {
						_picture = _checked;
						_value = 1;
						_ctrlTree tvexpand [_tvArsenal,_tvAll];
					};
					_tvClass = _ctrlTree tvadd [[_tvArsenal,_tvAll],_name];
					_ctrlTree tvsetdata [[_tvArsenal,_tvAll,_tvClass],_var];
					_ctrlTree tvsetvalue [[_tvArsenal,_tvAll,_tvClass],_value];
					_ctrlTree tvsetpicture [[_tvArsenal,_tvAll,_tvClass],_picture];
				};
				_ctrlTree tvsort [[_tvArsenal,_tvAll],false];
				_ctrlTree tvexpand [_tvArsenal];
			};

			_ctrlTree tvsort [[],false];
			_ctrlTree tvexpand [];
		} foreach _sideIDs;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler [
				"buttonclick",
				format ["with uinamespace do {['filterChanged',[ctrlparent (_this select 0),%1],objnull] call RscAttributeRespawnInventory;};",_foreachindex]
			];
			_side = _foreachindex call bis_fnc_sidetype;
			if (playableslotsnumber _side == 0) then {
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
				_sideIDs = _sideIDs - [_foreachindex];
			};
		} foreach _filterIDCs;

		if (count _sideIDs > 0) then {
			_cursel = if (RscAttributeRespawnInventory_tab in _sideIDs) then {RscAttributeRespawnInventory_tab} else {_sideIDs select 0};
			["filterChanged",[_display,_cursel,true],objnull] call RscAttributeRespawnInventory;

			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrladdeventhandler ["treeselchanged",{with uinamespace do {["treeSelChanged",_this,objnull] call RscAttributeRespawnInventory;};}];
			} foreach _treeIDCs;
		} else {
			_ctrlListBackground = _display displayctrl IDC_RSCATTRIBUTERESPAWNINVENTORY_LISTBACKGROUND;
			_ctrlListBackground ctrlsettext toupper localize "STR_A3_RscAttributeRespawnInventory_NoPlayers";
			_ctrlButtonCustom ctrlenable false;
		};
	};
	case "filterChanged": {
		_display = _params select 0;
		_cursel = _params select 1;
		RscAttributeRespawnInventory_tab = _cursel;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTERESPAWNINVENTORY_LIST;
		_ctrlFilterBackground = _display displayctrl IDC_RSCATTRIBUTERESPAWNINVENTORY_FILTERBACKGROUND;
		{
			_enable = _foreachindex == _cursel;
			_ctrl = _display displayctrl _x;
			_ctrl ctrlshow _enable;
			_ctrl ctrlenable _enable;
		} foreach _treeIDCs;

		//--- Update UI
		_delay = if (count _params > 2) then {0} else {0.1};
		{
			_ctrl = _display displayctrl _x;
			_color = _foreachindex call bis_fnc_sidecolor;
			_alpha = 0.5;
			_scale = 0.75;
			if (_foreachindex == _cursel) then {
				_alpha = 1;
				_scale = 1;
			};
			_ctrl ctrlsetactivecolor _color;
			_color set [3,_alpha];
			_ctrl ctrlsettextcolor _color;
			_pos = [_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;

			if (_foreachindex == _cursel) then {
				_ctrlFilterBackground ctrlsetposition _pos;
				_ctrlFilterBackground ctrlcommit 0;
			};
		} foreach _filterIDCs;
	};
	case "treeSelChanged": {
		_ctrlTree = _params select 0;
		_display = ctrlparent _ctrlTree;
		_cursel = tvcursel _ctrlTree;
		if (count _cursel == 3) then {
			_value = _ctrlTree tvvalue _cursel;
			_value = [1,0] select _value;
			_class = _ctrlTree tvdata _cursel;
			_selected = RscAttributeRespawnInventory_selected select RscAttributeRespawnInventory_tab;

			//--- Make sure at least one item is selected
			if (_value == 0 && (count _selected) <= 1) exitwith {
				[objnull,localize "STR_A3_RscAttributeRespawnInventory_NoLoadout"] call bis_fnc_showCuratorFeedbackMessage;
			};

			_picture = [_unchecked,_checked] select _value;
			_ctrlTree tvsetvalue [_cursel,_value];
			_ctrlTree tvsetpicture [_cursel,_picture];

			if (_value > 0) then {
				_selected = _selected + [_class];
			} else {
				_selected = _selected - [_class];
			};
			RscAttributeRespawnInventory_selected set [RscAttributeRespawnInventory_tab,_selected];
			
		};
	};
	case "clear": {
		_display = _params select 0;
		_ctrlTree = _display displayctrl (_treeIDCs select RscAttributeRespawnInventory_tab);
		_selected = "";
		for "_f" from 0 to ((_ctrlTree tvcount []) - 1) do {
			for "_v" from 0 to ((_ctrlTree tvcount [_f]) - 1) do {
				for "_c" from 0 to ((_ctrlTree tvcount [_f,_v]) - 1) do {
					if ((_ctrlTree tvvalue [_f,_v,_c]) > 0 && _selected == "") then {
						_selected = _ctrlTree tvdata [_f,_v,_c];
					} else {
						_ctrlTree tvsetpicture [[_f,_v,_c],_unchecked];
						_ctrlTree tvsetvalue [[_f,_v,_c],0];
					};
				};
			};
		};
		RscAttributeRespawnInventory_selected set [RscAttributeRespawnInventory_tab,[_selected]];
	};

	case "confirmed": {
		_display = _params select 0;
		_arsenalNames = [];
		{
			[_foreachindex call bis_fnc_sidetype,_x] call bis_fnc_setrespawninventory;
			{
				_xSplit = [_x,":"] call bis_fnc_splitstring;
				if (count _xSplit == 2) then {
					_name = _xSplit select 1;
					if !(_name in _arsenalNames) then {_arsenalNames set [count _arsenalNames,_name];};
				};
			} foreach _x;
		} foreach RscAttributeRespawnInventory_selected;

		_arsenalDataLocal = [];
		_arsenalData = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
		for "_i" from 0 to (count _arsenalData - 1) step 2 do {
			_name = _arsenalData select _i;
			if (_name in _arsenalNames) then {
				_arsenalDataLocal = _arsenalDataLocal + [_name,_arsenalData select (_i + 1)];
			};
		};
		missionnamespace setvariable ["bis_fnc_saveInventory_data",_arsenalDataLocal];
		publicvariable "bis_fnc_saveInventory_data";
	};
	case "onUnload": {
		//RscAttributeRespawnInventory_tab = nil;
		RscAttributeRespawnInventory_selected = nil;
	};
};