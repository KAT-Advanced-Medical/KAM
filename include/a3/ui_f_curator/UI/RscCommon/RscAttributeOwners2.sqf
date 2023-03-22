#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define SIDEID_IFFSET	100

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcs1 = [
	IDC_RSCATTRIBUTEOWNERS2_OPFOR1,
	IDC_RSCATTRIBUTEOWNERS2_BLUFOR1,
	IDC_RSCATTRIBUTEOWNERS2_INDEPENDENT1,
	IDC_RSCATTRIBUTEOWNERS2_CIVILIAN1
];
_idcs2 = [
	IDC_RSCATTRIBUTEOWNERS2_OPFOR2,
	IDC_RSCATTRIBUTEOWNERS2_BLUFOR2,
	IDC_RSCATTRIBUTEOWNERS2_INDEPENDENT2,
	IDC_RSCATTRIBUTEOWNERS2_CIVILIAN2
];

switch _mode do {
	case "onLoad": {

		//--- Get default / remembered sides
		_selected = +(_unit getvariable "RscAttributeOwners2");
		if (isnil "_selected") then {
			_selected = missionnamespace getvariable "RscAttributeOwners2_selected";
			if (isnil "_selected") then {[]};
		} else {
			_selectedIDs = [];
			{
				_coef = (_foreachindex * 2) - 1;
				{
					_selectedIDs set [count _selectedIDs,((_x call bis_fnc_sideID) + SIDEID_IFFSET) * _coef];
				} foreach _x;
			} foreach _selected;
			_selected = _selectedIDs;
		};
		RscAttributeOwners2_selected = [];

		//--- Add handlers to all buttons
		_display = _params select 0;

		//--- Add handlers to all buttons
		_playerside = player call bis_fnc_objectside;
		{
			_ctrl = _display displayctrl _x;
			_sideID = _foreachindex % 4;
			_side = _sideID call bis_fnc_sideType;
			if (/*playableslotsnumber _side > 0 && */[_side,_playerside] call bis_fnc_arefriendly) then {
				_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeOwners2};"];

				_color = _sideID call bis_fnc_sidecolor;
				_ctrl ctrlsetactivecolor _color;
				_color set [3,0.5];
				_ctrl ctrlsettextcolor _color;

				_sideIDAbs = _sideID + SIDEID_IFFSET;
				if (_foreachindex < 4) then {_sideIDAbs = -_sideIDAbs;};
				if (_sideIDAbs in _selected) then {
					['onButtonClick',[_ctrl,0]] call RscAttributeOwners2;
				};
			} else {
				_ctrl ctrlshow false;
			};
		} foreach (_idcs1 + _idcs2);

	};
	case "onButtonClick": {

		_ctrlSelected = _params select 0;
		_ctrlSelectedIDC = ctrlidc _ctrlSelected;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;

		_side1ID = _idcs1 find _ctrlSelectedIDC;
		_side2ID = _idcs2 find _ctrlSelectedIDC;

		_sideID = _side1ID max _side2ID;
		_side = _sideID call bis_fnc_sideType;
		_color = _sideID call bis_fnc_sidecolor;

		_sideRow = [-1,1] select (_side1ID < 0);
		_sideIDAbs = _sideID + SIDEID_IFFSET;
		_sideIDRel = _sideIDAbs * _sideRow;

		_scale = 1;
		_alpha = 0.5;
		if (_sideIDRel in RscAttributeOwners2_selected) then {
			RscAttributeOwners2_selected = RscAttributeOwners2_selected - [_sideIDRel];
		} else {
			if !(_sideIDRel in RscAttributeOwners2_selected) then {
				RscAttributeOwners2_selected = RscAttributeOwners2_selected + [_sideIDRel];
				RscAttributeOwners2_selected = RscAttributeOwners2_selected - [-_sideIDRel];
			};
			_scale = 1.2;
			_alpha = 1;
		};

		_color set [3,_alpha];
		_ctrlSelected ctrlsettextcolor _color;
		[_ctrlSelected,_scale,_delay] call bis_fnc_ctrlsetscale;


		_idcs = if (_sideRow > 0) then {_idcs1} else {_idcs2};
		_ctrlOther = _display displayctrl (_idcs select _sideID);
		_color set [3,0.5];
		_ctrlOther ctrlsettextcolor _color;
		[_ctrlOther,1,_delay] call bis_fnc_ctrlsetscale;
	};
	case "confirmed": {

		//--- Convert side IDs to sides
		_selected = +(uinamespace getvariable ["RscAttributeOwners2_selected",[]]);
		_sides1 = [];
		_sides2 = [];
		{
			_array = if (_x >= 0) then {_sides2} else {_sides1};
			_array set [count _array,(abs _x - SIDEID_IFFSET) call bis_fnc_sideType];
		} foreach _selected;
		_unit setvariable ["RscAttributeOwners2",[_sides1,_sides2],true];
		_unit setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		missionnamespace setvariable ["RscAttributeOwners2_selected",RscAttributeOwners2_selected];
		RscAttributeOwners2_selected = nil;
	};
};