#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMARKERTEXT_VALUE;
		_ctrlValue ctrlsettext markertext _entity;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMARKERTEXT_VALUE;
		_text = ctrltext _ctrlValue;
		if (_text != markertext _entity) then {
			_entity setmarkertext _text;
		};
	};
	case "onUnload": {
	};
};