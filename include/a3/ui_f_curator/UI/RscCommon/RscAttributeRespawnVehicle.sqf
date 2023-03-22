#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTERESPAWNVEHICLE_EAST,
	IDC_RSCATTRIBUTERESPAWNVEHICLE_WEST,
	IDC_RSCATTRIBUTERESPAWNVEHICLE_GUER,
	IDC_RSCATTRIBUTERESPAWNVEHICLE_CIV,
	IDC_RSCATTRIBUTERESPAWNVEHICLE_START,
	IDC_RSCATTRIBUTERESPAWNVEHICLE_DISABLED
];
_colorsActive = [
	east call bis_fnc_sidecolor,
	west call bis_fnc_sidecolor,
	resistance call bis_fnc_sidecolor,
	civilian call bis_fnc_sidecolor,
	[1,1,1,1],
	[1,1,1,1]
];
_colorsText = +_colorsActive;
{_x set [3,0.5];} foreach _colorsText;

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		_playerside = player call bis_fnc_objectside;
		{
			_ctrl = _display displayctrl _x;
			_side = _foreachindex call bis_fnc_sideType;
			if (([_side,_playerside] call bis_fnc_arefriendly && playableslotsnumber _side > 0) || _foreachindex > 3) then {
				_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeRespawnVehicle};"];
				_ctrl ctrlsetactivecolor (_colorsActive select _foreachindex);
				_ctrl ctrlsettextcolor (_colorsText select _foreachindex);
				_ctrl ctrlcommit 0;
			} else {
				_ctrl ctrlshow false;
			};
		} foreach _idcs;

		_respawnID = [_unit,false] call bis_fnc_modulerespawnvehicle;
		_selected = switch _respawnID do {
			case 0;
			case 1;
			case 7: {4};
			case 2;
			case 3;
			case 4;
			case 5;
			case 6: {
				if (_respawnID == 2) then {_respawnID = (_unit call bis_fnc_objectside) call bis_fnc_sideID;};
				_respawnID - 3
			};
			default {5};
		};

		RscAttributeRespawnVehicle_selected = _selected;
		_selectedIdc = _idcs select _selected;
		['onButtonClick',[_display displayctrl _selectedIdc,0]] call RscAttributeRespawnVehicle;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor (_colorsText select _foreachindex);
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeRespawnVehicle_selected = _idcs find (ctrlidc _ctrlSelected);
		_ctrlSelected ctrlsettextcolor (_colorsActive select RscAttributeRespawnVehicle_selected);
		[_ctrlSelected,1.25,_delay] call bis_fnc_ctrlsetscale;
	};
	case "confirmed": {
		_display = _params select 0;
		_selected = uinamespace getvariable ["RscAttributeRespawnVehicle_selected",5];
		_respawnID = [_unit,false] call bis_fnc_modulerespawnvehicle;

		_selected = switch (_selected) do {
			case 0: {3};
			case 1: {4};
			case 2: {5};
			case 3: {6};
			case 4: {0};
			default {-1};
		};

		if (_selected != _respawnID) then {
			//--- Remove
			[[_unit,true],"bis_fnc_modulerespawnvehicle",false] call bis_fnc_mp;

			//--- Add
			if (_selected >= 0) then {
				[[_unit,nil,nil,nil,{_this call bis_fnc_curatorrespawn;},_selected],"bis_fnc_modulerespawnvehicle",false] call bis_fnc_mp;
			};
		};

		_unit setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		RscAttributeRespawnVehicle_selected = nil;
	};
};