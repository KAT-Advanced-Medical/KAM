#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;
switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlGroup = _display displayctrl IDC_RSCATTRIBUTETEXT_RSCATTRIBUTETEXT;
		_ctrlTitle = _display displayctrl IDC_RSCATTRIBUTETEXT_TITLE;
		_h = ctrltextheight _ctrlTitle + 0.01;

		_ctrlTitlePos = ctrlposition _ctrlTitle;
		_ctrlTitlePos set [3,_h];
		_ctrlTitle ctrlsetposition _ctrlTitlePos;
		_ctrlTitle ctrlcommit 0;

		_ctrlGroupPos = ctrlposition _ctrlGroup;
		_ctrlGroupPos set [3,_h];
		_ctrlGroup ctrlsetposition _ctrlGroupPos;
		_ctrlGroup ctrlcommit 0;
	};
};

#undef _RESINCL_HPP
#include "RscDisplayAttributes.sqf"

