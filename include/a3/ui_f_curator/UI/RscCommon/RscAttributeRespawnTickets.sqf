#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_sliderIDCs = [
	IDC_RSCATTRIBUTERESPAWNTICKETS_EASTVALUE,
	IDC_RSCATTRIBUTERESPAWNTICKETS_WESTVALUE,
	IDC_RSCATTRIBUTERESPAWNTICKETS_GUERVALUE,
	IDC_RSCATTRIBUTERESPAWNTICKETS_CIVVALUE
];
_textIDCs = [
	IDC_RSCATTRIBUTERESPAWNTICKETS_EASTTEXT,
	IDC_RSCATTRIBUTERESPAWNTICKETS_WESTTEXT,
	IDC_RSCATTRIBUTERESPAWNTICKETS_GUERTEXT,
	IDC_RSCATTRIBUTERESPAWNTICKETS_CIVTEXT
];
_iconIDCs = [
	IDC_RSCATTRIBUTERESPAWNTICKETS_EAST,
	IDC_RSCATTRIBUTERESPAWNTICKETS_WEST,
	IDC_RSCATTRIBUTERESPAWNTICKETS_GUER,
	IDC_RSCATTRIBUTERESPAWNTICKETS_CIV
];

_maxTickets = 500;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;

		{
			_ctrlSlider = _display displayctrl _x;
			_ctrlIcon = _display displayctrl (_iconIDCs select _foreachindex);
			_ctrlText = _display displayctrl (_textIDCs select _foreachindex);
			_side = _foreachindex call bis_fnc_sideType;
			if (playableslotsnumber _side > 0) then {
				_tickets = _side call bis_fnc_respawnTickets;
				_minTickets = if (_tickets < 0) then {-1} else {0};

				_ctrlSlider slidersetrange [_minTickets,_maxTickets];
				_ctrlSlider slidersetposition _tickets;
				_ctrlSlider ctrladdeventhandler ["sliderPosChanged","with uinamespace do {['sliderPosChanged',_this,objnull] call RscAttributeRespawnTickets};"];

				if (playableslotsnumber _side > 0) then {
					['sliderPosChanged',[_ctrlSlider,_tickets],objnull] call RscAttributeRespawnTickets;
				} else {
					_ctrlSlider ctrlenable false;
				};
			} else {
				_ctrlSlider ctrlenable false;
				_ctrlIcon ctrlsetfade 0.75;
				_ctrlIcon ctrlcommit 0;
				_ctrlText ctrlsetposition ctrlposition _ctrlSlider;
				_ctrlText ctrlsetfade 0.75;
				_ctrlText ctrlcommit 0;
			};
		} foreach _sliderIDCs;

		RscAttributeRespawnTickets_value = [0,1] select (missionnamespace getvariable ["bis_fnc_bleedTickets_enabled",false]);
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTERESPAWNTICKETS_VALUE;
		_ctrlValue ctrladdeventhandler ["toolboxSelChanged",{with uinamespace do {["selChanged",_this,objnull] call RscAttributeRespawnTickets;};}];
		_ctrlValue lbsetcursel RscAttributeRespawnTickets_value;
	};
	case "sliderPosChanged": {
		_ctrlSlider = _params select 0;
		_sliderPos = _params select 1;
		_sliderText = if (_sliderPos < 0) then {"-"} else {str round _sliderPos};

		_display = ctrlparent _ctrlSlider;
		_ctrlTextIDC = _textIDCs select (_sliderIDCs find (ctrlidc _ctrlSlider));
		_ctrlText = _display displayctrl _ctrlTextIDC;
		_ctrlText ctrlsettext _sliderText;
	};
	case "selChanged": {
		RscAttributeRespawnTickets_value = _params select 1;
	};
	case "confirmed": {
		_display = _params select 0;
		_sides = [];
		{
			_side = _foreachindex call bis_fnc_sideType;
			_ctrlSlider = _display displayctrl _x;
			_sliderPos = sliderposition _ctrlSlider;
			if (_sliderPos >= 0) then {
				_ticketsCurrent = (_side call bis_fnc_respawnTickets) max 0;
				[_side,_sliderPos - _ticketsCurrent] call bis_fnc_respawnTickets;
			};
			if (ctrlenabled _ctrlSlider) then {
				_sides set [count _sides,_side];
			};
		} foreach _sliderIDCs;
		_unit setvariable ["updated",true,true];

		_bleedParams = if (RscAttributeRespawnTickets_value > 0) then {[_sides]} else {[[]]};
		[_bleedParams,"bis_fnc_bleedTickets",false] call bis_fnc_mp;
	};
	case "onUnload": {
		RscAttributeRespawnTickets_value = nil;
	};
};