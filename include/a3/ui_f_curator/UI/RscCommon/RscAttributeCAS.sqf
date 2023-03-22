#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		_ctrlValue ctrlsetfontheight GUI_GRID_H;

		_playerSide = player call bis_fnc_objectside;
		_selected = missionnamespace getvariable ["RscATtributeCAS_selected",""];
		{
			//--- Show only friendly planes (or all when curator is virtual)
			_vehicle = gettext (_x >> "value");
			_cfg = configfile >> "cfgvehicles" >> _vehicle;
			if ([_playerSide,(getnumber (_cfg >> "side")) call bis_fnc_sidetype] call bis_fnc_arefriendly) then {
				_lnbAdd = _ctrlValue lnbaddrow ["","",gettext (_cfg >> "displayName")];
				_ctrlValue lnbsetdata [[_lnbAdd,0],_vehicle];
				_ctrlValue lnbsetpicture [[_lnbAdd,0],gettext (configfile >> "cfgfactionclasses" >> gettext (_cfg >> "faction") >> "icon")];
				_ctrlValue lnbsetpicture [[_lnbAdd,1],gettext (_cfg >> "picture")];
			};
		} foreach ((configfile >> "cfgvehicles" >> typeof _unit >> "arguments" >> "vehicle" >> "values") call bis_fnc_returnchildren);
		_ctrlValue lnbsort [2,false];
		for "_i" from 0 to ((lnbsize _ctrlValue select 0) - 1) do {
			if ((_ctrlValue lnbdata [_i,0]) == _selected) exitwith {_ctrlValue lnbsetcurselrow _i;};
		};
		if (lnbcurselrow _ctrlValue < 0) then {
			_ctrlValue lnbsetcurselrow 0;
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		_vehicle = _ctrlValue lnbdata [lnbcurselrow _ctrlValue,0];

		_unit setvariable ["vehicle",_vehicle,true];
		_unit setvariable ["BIS_fnc_curatorAttributes",[],true];
		missionnamespace setvariable ["RscATtributeCAS_selected",_vehicle];
	};
	case "onUnload": {
		if (!isnil "RscAttributePostProcess_default") then {
			[nil,0,false] call bis_fnc_setPPeffectTemplate;
		};
		RscAttributePostProcess_default = nil;
	};
};