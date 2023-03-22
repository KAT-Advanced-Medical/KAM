#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define VALUE_INFINITY	"\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\infinity_ca.paa"
#define VALUE_NUMBER	"#(argb,1,1,1)color(0,0,0,0)"

params["_mode","_params","_entity"];

_filterIDCs = [
	IDC_RSCATTRIBUTEINVENTORY_FILTER0,
	IDC_RSCATTRIBUTEINVENTORY_FILTER1,
	IDC_RSCATTRIBUTEINVENTORY_FILTER2,
	IDC_RSCATTRIBUTEINVENTORY_FILTER3,
	IDC_RSCATTRIBUTEINVENTORY_FILTER4,
	IDC_RSCATTRIBUTEINVENTORY_FILTER5,
	IDC_RSCATTRIBUTEINVENTORY_FILTER6,
	IDC_RSCATTRIBUTEINVENTORY_FILTER7,
	IDC_RSCATTRIBUTEINVENTORY_FILTER8,
	IDC_RSCATTRIBUTEINVENTORY_FILTER9,
	IDC_RSCATTRIBUTEINVENTORY_FILTER10,
	IDC_RSCATTRIBUTEINVENTORY_FILTER11,
	IDC_RSCATTRIBUTEINVENTORY_FILTER12
];

switch _mode do {
	case "onLoad": {

		//--- Get weapons and magazines from curator addons
		_curator = getassignedcuratorlogic player;
		_weaponAddons = missionnamespace getvariable ["RscAttrbuteInventory_weaponAddons",[]];
		_types = [
			["AssaultRifle","Shotgun","Rifle","SubmachineGun"],
			["MachineGun"],
			["SniperRifle"],
			["Launcher","MissileLauncher","RocketLauncher"],
			["Handgun"],
			["UnknownWeapon"],
			["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"],
			["Uniform"],
			["Vest"],
			["Backpack"],
			["Headgear","Glasses"],
			["Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal"]
		];
		_typeMagazine = _types find "Magazine";
		_list = [[],[],[],[],[],[],[],[],[],[],[],[]];
		_magazines = []; //--- Store magazines in an array and mark duplicates, so they don't appear in the list of all items
		{
			_addon = tolower _x;
			_addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
			_addonID = _weaponAddons find _addon;
			if (_addonID < 0) then {
				{
					_weapon = tolower _x;
					_weaponType = (_weapon call bis_fnc_itemType);
					_weaponTypeCategory = _weaponType select 0;
					_weaponTypeSpecific = _weaponType select 1;
					_weaponTypeID = -1;
					{
						if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
					} foreach _types;
					//_weaponTypeID = _types find (_weaponType select 0);
					if (_weaponTypeCategory != "VehicleWeapon" && _weaponTypeID >= 0) then {
						_weaponCfg = configfile >> "cfgweapons" >> _weapon;
						_weaponPublic = getnumber (_weaponCfg >> "scope") == 2;
						_addonListType = _addonList select _weaponTypeID;
						if (_weaponPublic) then {
							_displayName = gettext (_weaponCfg >> "displayName");
							_picture = gettext (_weaponCfg >> "picture");
							{
								_item = gettext (_x >> "item");
								_itemName = gettext (configfile >> "cfgweapons" >> _item >> "displayName");
								_displayName = _displayName + " + " + _itemName;
							} foreach ((_weaponCfg >> "linkeditems") call bis_fnc_returnchildren);
							_displayNameShort = _displayName;
							_displayNameShortArray = toarray _displayNameShort;
							if (count _displayNameShortArray > 41) then { //--- Cut when the name is too long (41 chars is approximate)
								_displayNameShortArray resize 41;
								_displayNameShort = tostring _displayNameShortArray + "...";
							};
							_type = if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) then {1} else {0};
							_addonListType pushback [_displayName,_displayNameShort,_weapon,_picture,_type,false];
						};
						//--- Add magazines compatible with the weapon
						if (_weaponPublic || _weapon in ["throw","put"]) then {
							//_addonListType = _addonList select _typeMagazine;
							{
								_muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};
								_magazinesList = getarray (_muzzle >> "magazines");
								// Add magazines from magazine wells
								{
									{
										_magazinesList append (getArray _x);
									}foreach  configproperties [configFile >> "CfgMagazineWells" >> _x,"isArray _x"];
								} foreach getArray (_muzzle >> "magazineWell");
								{
									_mag = tolower _x;
									if ({(_x select 2) == _mag} count _addonListType == 0) then {
										_magCfg = configfile >> "cfgmagazines" >> _mag;
										if (getnumber (_magCfg >> "scope") == 2) then {
											_displayName = gettext (_magCfg >> "displayName");
											_picture = gettext (_magCfg >> "picture");
											_addonListType pushback [_displayName,_displayName,_mag,_picture,2,_mag in _magazines];
											_magazines pushBackUnique _mag;
										};
									};
								} foreach _magazinesList;
							} foreach getarray (_weaponCfg >> "muzzles");
						};
					};
				} foreach getarray (configfile >> "cfgpatches" >> _x >> "weapons");
				{
					_weapon = tolower _x;
					_weaponType = _weapon call bis_fnc_itemType;
					_weaponTypeSpecific = _weaponType select 1;
					_weaponTypeID = -1;
					{
						if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
					} foreach _types;
					//_weaponTypeID = _types find (_weaponType select 0);
					if (_weaponTypeID >= 0) then {
						_weaponCfg = configfile >> "cfgvehicles" >> _weapon;
						if (getnumber (_weaponCfg >> "scope") == 2) then {
							_displayName = gettext (_weaponCfg >> "displayName");
							_picture = gettext (_weaponCfg >> "picture");
							_addonListType = _addonList select _weaponTypeID;
							_addonListType pushback [_displayName,_displayName,_weapon,_picture,3,false];
						};
					};
				} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
				_weaponAddons set [count _weaponAddons,_addon];
				_weaponAddons set [count _weaponAddons,_addonList];
			} else {
				_addonList = _weaponAddons select (_addonID + 1);
			};
			{
				_current = _list select _foreachindex;
				_list set [_foreachindex,_current + (_x - _current)];
			} foreach _addonList;
		} foreach (curatoraddons _curator);

		//--- Sort
		{_x sort true;} foreach _list;

		missionnamespace setvariable ["RscAttrbuteInventory_weaponAddons",_weaponAddons];
		RscAttributeInventory_list = _list;

		//--- Get current cargo
		_cargo = [
			getweaponcargo _entity,
			getmagazinecargo _entity,
			getitemcargo _entity,
			getbackpackcargo _entity
		];
		_virtualCargo = [
			_entity call bis_fnc_getVirtualWeaponCargo,
			_entity call bis_fnc_getVirtualMagazineCargo,
			_entity call bis_fnc_getVirtualItemCargo,
			_entity call bis_fnc_getVirtualBackpackCargo
		];
		{
			_xCargo = _cargo select _foreachindex;
			{
				_index = (_xCargo select 0) find _x;
				if (_index < 0) then {
					(_xCargo select 0) set [count (_xCargo select 0),_x];
					(_xCargo select 1) set [count (_xCargo select 1),-1];
				} else {
					(_xCargo select 1) set [_index,-1];
				};
			} foreach _x;
		} foreach _virtualCargo;
		RscAttributeInventory_cargo = [[],[]];
		{
			RscAttributeInventory_cargo set [0,(RscAttributeInventory_cargo select 0) + (_x select 0)];
			RscAttributeInventory_cargo set [1,(RscAttributeInventory_cargo select 1) + (_x select 1)];
		} foreach _cargo;

		_classes = RscAttributeInventory_cargo select 0;
		{_classes set [_foreachindex,tolower _x];} foreach _classes;

		//--- Get limits
		_cfgEntity = configfile >> "cfgvehicles" >> typeof _entity;
		_cfgTransportMaxBackpacks = getnumber (_cfgEntity >> "transportMaxBackpacks");
		_cfgTransportMaxMagazines = getnumber (_cfgEntity >> "transportMaxMagazines");
		_cfgTransportMaxWeapons = getnumber (_cfgEntity >> "transportMaxWeapons");
		RscAttributeInventory_loadBackpack = if (_cfgTransportMaxBackpacks > 0) then {1 / _cfgTransportMaxBackpacks} else {1e10};
		RscAttributeInventory_loadMagazine = if (_cfgTransportMaxMagazines > 0) then {1 / _cfgTransportMaxMagazines} else {1e10};
		RscAttributeInventory_loadWeapon = if (_cfgTransportMaxWeapons > 0) then {1 / _cfgTransportMaxWeapons} else {1e10};

		//--- Init UI
		_display = _params select 0;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler [
				"buttonclick",
				format ["with uinamespace do {['filterChanged',[ctrlparent (_this select 0),%1],objnull] call RscAttributeInventory;};",_foreachindex]
			];
		} foreach _filterIDCs;
		RscAttributeInventory_selected = 0;
		["filterChanged",[_display],objnull] call RscAttributeInventory;

		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlList ctrladdeventhandler ["lbselchanged",{with uinamespace do {["listSelect",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory;};}];
		_ctrlList ctrladdeventhandler ["lbdblclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),+1],objnull] call RscAttributeInventory;};}];

		_ctrlArrowLeft = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWLEFT;
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),-1],objnull] call RscAttributeInventory;};}];
		_ctrlArrowRight = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWRIGHT;
		_ctrlArrowRight ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),+1],objnull] call RscAttributeInventory;};}];

		_ctrlButtonCustom = _Display displayctrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;
		_ctrlButtonCustom ctrlsettext localize "str_disp_arcmap_clear";
		_ctrlButtonCustom ctrladdeventhandler ["buttonclick",{with uinamespace do {["clear",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory;};}];
	};
	case "filterChanged": {
		_display = _params select 0;
		//_ctrlFilter = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_FILTER;
		//_cursel = lbcursel _ctrlFilter;
		_cursel = if (count _params > 1) then {_params select 1} else {RscAttributeInventory_selected};
		RscAttributeInventory_selected = _cursel;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_ctrlFilterBackground = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_FILTERBACKGROUND;
		_list = uinamespace getvariable ["RscAttributeInventory_list",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		_items = [];

		if (_cursel > 0) then {
			_items = _list select (_cursel - 1);
		} else {
			{_items = _items + _x;} foreach _list;
			_items sort true;
		};

		lnbclear _ctrlList;
		{
			_types = _x;
			{
				_x params ["_displayName","_displayNameShort","_class","_picture","_type","_isDuplicate"];

				if (_type in _types && (!_isDuplicate && _cursel >= 0)) then {
					_classes = RscAttributeInventory_cargo select 0;
					_values = RscAttributeInventory_cargo select 1;
					_index = _classes find _class;
					_value = if (_index < 0) then {
						_index = count _classes;
						_classes set [_index,_class];
						_values set [_index,0];
						0
					} else {
						_values select _index
					};

					if ((_cursel == 0 && _value != 0) || (_cursel > 0)) then {
						_lnbAdd = _ctrlList lnbaddrow ["",_displayNameShort,if (_value < 0) then {""} else {str _value},""];
						_ctrlList lnbsetdata [[_lnbAdd,0],_class];
						_ctrlList lnbsetvalue [[_lnbAdd,0],_value];
						_ctrlList lnbsetvalue [[_lnbAdd,1],_type];
						_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
						_ctrlList lnbsetpicture [[_lnbAdd,3],if (_value < 0) then {VALUE_INFINITY} else {VALUE_NUMBER}];
						_alpha = if (_value != 0) then {1} else {0.5};
						_ctrlList lnbsetcolor [[_lnbAdd,1],[1,1,1,_alpha]];
						_ctrlList lnbsetcolor [[_lnbAdd,2],[1,1,1,_alpha]];
						_ctrlList lbsettooltip [_lnbAdd,_displayName];

						if (_cursel == 0 && _value != 0) then {
							_coef = switch _type do {
								case 0: {RscAttributeInventory_loadWeapon};
								case 1: {0};
								case 2: {RscAttributeInventory_loadMagazine};
								case 3: {RscAttributeInventory_loadBackpack};
								default {0};
							};
							_ctrlLoad progresssetposition (progressposition _ctrlLoad + (_value max 0) * _coef);
						};
					};
				};
			} foreach _items;
		} foreach [[0,1,3],[2]];
		_ctrlList lnbsetcurselrow 0;
		["listSelect",[_display],objnull] call RscAttributeInventory;

		//--- Update UI
		_delay = if (isnil "_curator") then {0.1} else {0};
		{
			_ctrl = _display displayctrl _x;
			_color = [1,1,1,0.5];
			_scale = 0.75;
			if (_foreachindex == _cursel) then {
				_color = [1,1,1,1];
				_scale = 1;
			};
			_ctrl ctrlsettextcolor _color;
			_pos = [_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;

			if (_foreachindex == _cursel) then {
				_ctrlFilterBackground ctrlsetposition _pos;
				_ctrlFilterBackground ctrlcommit 0;
			};
		} foreach _filterIDCs;
	};
	case "listModify": {
		_display = _params select 0;
		_add = _params select 1;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_cursel = lnbcurselrow _ctrlList;
		_class = _ctrlList lnbdata [_cursel,0];
		_value = _ctrlList lbvalue (_cursel * 4); //--- ToDo: Use lnbValue once it's fixed
		_type = _ctrlList lbvalue (_cursel * 4 + 1); //--- ToDo: Use lnbValue once it's fixed

		_classes = RscAttributeInventory_cargo select 0;
		_values = RscAttributeInventory_cargo select 1;
		_index = _classes find _class;
		if (_index >= 0) then {
			_coef = switch _type do {
				case 0: {RscAttributeInventory_loadWeapon};
				case 1: {0};
				case 2: {RscAttributeInventory_loadMagazine};
				case 3: {RscAttributeInventory_loadBackpack};
				default {0};
			};

			_value = _value + _add;
			//if (_value < 0 || (_value == 0 && _add > 0)) then {_add = -_add;};
			_load = progressposition _ctrlLoad + _add * _coef;
			if ((_load <= 1 && _value >= -1) || _value == 0) then {
				if (_value > 0 || (_value == 0 && _add < 0)) then {_ctrlLoad progresssetposition _load};
				_values set [_index,_value];
				_ctrlList lnbsetvalue [[_cursel,0],_value];
				_ctrlList lnbsettext [[_cursel,2],if (_value < 0) then {""} else {str _value}];
				_ctrlList lnbsetpicture [[_cursel,3],if (_value < 0) then {VALUE_INFINITY} else {VALUE_NUMBER}];
				_alpha = if (_value != 0) then {1} else {0.5};
				_ctrlList lnbsetcolor [[_cursel,1],[1,1,1,_alpha]];
				_ctrlList lnbsetcolor [[_cursel,2],[1,1,1,_alpha]];
				["listSelect",[_display],objnull] call RscAttributeInventory;
			};
		};
	};
	case "listSelect": {
		private ["_display","_ctrlList","_cursel","_value","_ctrlArrowLeft","_buttonText"];
		_display = _params select 0;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_cursel = lnbcurselrow _ctrlList;
		_value = _ctrlList lbvalue (_cursel * 4); //--- ToDo: Use lnbValue once it's fixed

		_ctrlArrowLeft = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWLEFT;
		_buttonText = if (_value <= 0) then {format ["<img image='%1' size='0.7' />",VALUE_INFINITY]} else {"-"};
		_ctrlArrowLeft ctrlsetstructuredtext parsetext _buttonText;
		_ctrlArrowLeft ctrlenable (_value > -1);
	};
	case "clear": {
		_values = RscAttributeInventory_cargo select 1;
		{
			_values set [_foreachindex,0];
		} foreach _values;
		["filterChanged",_params,objnull] call RscAttributeInventory;

		_display = _params select 0;
		_ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_ctrlLoad progresssetposition 0;
	};

	case "confirmed": {
		_display = _params select 0;

		clearweaponcargoglobal _entity;
		clearmagazinecargoglobal _entity;
		clearbackpackcargoglobal _entity;
		clearitemcargoglobal _entity;

		_entity call bis_fnc_removeVirtualItemCargo;
		_entity call bis_fnc_removeVirtualWeaponCargo;
		_entity call bis_fnc_removeVirtualMagazineCargo;
		_entity call bis_fnc_removeVirtualBackpackCargo;

		_classes = RscAttributeInventory_cargo select 0;
		_values = RscAttributeInventory_cargo select 1;
		_items = [];
		_weapons = [];
		_magazines = [];
		_backpacks = [];
		{
			if (_x != 0) then {
				_class = _classes select _foreachindex;
				switch true do {
					case (getnumber (configfile >> "cfgweapons" >> _class >> "type") in [4096,131072]): {
						if (_x < 0) then {
							_items set [count _items,_class];
						} else {
							_entity additemcargoglobal [_class,abs _x];
						};
					};
					case (isclass (configfile >> "cfgweapons" >> _class)): {
						if (_x < 0) then {
							_weapons set [count _weapons,_class];
						} else {
							_entity addweaponcargoglobal [_class,abs _x];
						};
					};
					case (isclass (configfile >> "cfgmagazines" >> _class)): {
						if (_x < 0) then {
							_magazines set [count _magazines,_class];
						} else {
							_entity addmagazinecargoglobal [_class,abs _x];
						};
					};
					case (isclass (configfile >> "cfgvehicles" >> _class)): {
						if (_x < 0) then {
							_backpacks set [count _backpacks,_class];
						} else {
							_entity addbackpackcargoglobal [_class,abs _x];
						};
					};
				};
			};
		} foreach _values;

		[_entity,_items,true] call bis_fnc_addVirtualItemCargo;
		[_entity,_weapons,true] call bis_fnc_addVirtualWeaponCargo;
		[_entity,_magazines,true] call bis_fnc_addVirtualMagazineCargo;
		[_entity,_backpacks,true] call bis_fnc_addVirtualBackpackCargo;
	};
	case "onUnload": {
		RscAttributeInventory_list = nil;
		RscAttributeInventory_cargo = nil;
		RscAttributeInventory_selected = nil;
		RscAttributeInventory_loadBackpack = nil;
		RscAttributeInventory_loadMagazine = nil;
		RscAttributeInventory_loadWeapon = nil;
	};
};