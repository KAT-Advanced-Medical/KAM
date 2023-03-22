#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {
	case "onLoad": {

		_display = _params select 0;
		_ctrlIcon = _display displayctrl IDC_RSCCURATORPING_ICON;
		_ctrlIcon ctrlsetfade 1;
		_ctrlIcon ctrlcommit 1;

		_ctrlPlayer = _display displayctrl IDC_RSCCURATORPING_PLAYER;
		_ctrlPlayer ctrlsetfade 1;
		[_ctrlPlayer,2,0.7] call bis_fnc_ctrlSetScale;
	};
};