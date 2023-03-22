#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTERANK_PRIVATE,
	IDC_RSCATTRIBUTERANK_CORPORAL,
	IDC_RSCATTRIBUTERANK_SERGEANT,
	IDC_RSCATTRIBUTERANK_LIEUTENANT,
	IDC_RSCATTRIBUTERANK_CAPTAIN,
	IDC_RSCATTRIBUTERANK_MAJOR,
	IDC_RSCATTRIBUTERANK_COLONEL
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeRank};"];
			_ctrl ctrlcommit 0;
		} foreach _idcs;

		//--- Select the current rank
		_rankIdc = _idcs select (rankID _unit max 0 min 6);
		['onButtonClick',[_display displayctrl _rankIdc,0]] call RscAttributeRank;
	};
	case "onButtonClick": {
		_rankCtrl = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _rankCtrl;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.5];
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;
		_rankCtrl ctrlsettextcolor [1,1,1,1];
		[_rankCtrl,1.25,_delay] call bis_fnc_ctrlsetscale;
		RscAttributeRank_rank = _idcs find (ctrlidc _rankCtrl);
	};
	case "confirmed": {
		_display = _params select 0;
		_rankID = uinamespace getvariable ["RscAttributeRank_rank",0];
		_rank = _rankID call bis_fnc_rankparams;
		_unit setrank _rank;
		false
	};
	case "onUnload": {
		RscAttributeRank_rank = nil;
	};
};