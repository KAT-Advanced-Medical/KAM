#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_mode","_params","_entity"];
_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTERESPAWNPOSITION_EAST,
	IDC_RSCATTRIBUTERESPAWNPOSITION_WEST,
	IDC_RSCATTRIBUTERESPAWNPOSITION_GUER,
	IDC_RSCATTRIBUTERESPAWNPOSITION_CIV,
	IDC_RSCATTRIBUTERESPAWNPOSITION_DISABLED
];
_colorsActive = [
	east call bis_fnc_sidecolor,
	west call bis_fnc_sidecolor,
	resistance call bis_fnc_sidecolor,
	civilian call bis_fnc_sidecolor,
	[1,1,1,1]
];
_colorsText = +_colorsActive;
{_x set [3,0.5];} foreach _colorsText;

switch _mode do {
	case "onLoad": {

		_display = _params select 0;
		_IDs = _entity getvariable ["RscAttributeRespawnPosition_ids",[[],[],[],[],[]]];
		if (typename _entity == typename grpnull) then {_entity = leader _entity;};

		//--- Not available for destroyed object
		if (!alive _entity || !canmove _entity) exitwith {
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
			} foreach _idcs;
			_ctrlBackground = _display displayctrl IDC_RSCATTRIBUTERESPAWNPOSITION_BACKGROUND;
			_ctrlBackground ctrlsettext localize "str_lib_info_na";
		};

		//--- Add handlers to all buttons
		_playerside = player call bis_fnc_objectside;
		_selected = 4;
		{
			_ctrl = _display displayctrl _x;
			_side = _foreachindex call bis_fnc_sideType;
			if (([_side,_playerside] call bis_fnc_arefriendly && playableslotsnumber _side > 0) || _foreachindex == 4) then {
				_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeRespawnPosition};"];
				_ctrl ctrlsetactivecolor (_colorsActive select _foreachindex);
				_ctrl ctrlsettextcolor (_colorsText select _foreachindex);
				_ctrl ctrlcommit 0;
				if (count (_IDs select _foreachindex) > 0) then {_selected = _foreachindex;};
			} else {
				_ctrl ctrlshow false;
			};
		} foreach _idcs;

		RscAttributeRespawnPosition_selected = _selected;
		_selectedIdc = _idcs select _selected;
		['onButtonClick',[_display displayctrl _selectedIdc,0]] call RscAttributeRespawnPosition;
		_selected = 4;
	};
	case "onButtonClick": {
		private ["_display"];
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor (_colorsText select _foreachindex);
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeRespawnPosition_selected = _idcs find (ctrlidc _ctrlSelected);
		_ctrlSelected ctrlsettextcolor (_colorsActive select RscAttributeRespawnPosition_selected);
		[_ctrlSelected,1.25,_delay] call bis_fnc_ctrlsetscale;
	};
	case "confirmed": {
		_display = _params select 0;
		_selected = uinamespace getvariable ["RscAttributeRespawnPosition_selected",4];
		_IDs = _entity getvariable ["RscAttributeRespawnPosition_ids",[]];

		//--- Remove
		{_x call bis_fnc_removerespawnposition;} foreach _IDs;
		_IDs = [[],[],[],[],[]];

		if (_selected != 4) then {
			//--- Add
			_side = _selected call bis_fnc_sideType;
			_respawnID = [_side,_entity] call bis_fnc_addrespawnposition;
			_IDs set [_selected,_respawnID];
			_entity setvariable ["RscAttributeRespawnPosition_ids",_IDs,true];
		} else {
			_entity setvariable ["RscAttributeRespawnPosition_ids",nil,true];
		};
		_entity setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		RscAttributeRespawnPosition_selected = nil;
	};
};