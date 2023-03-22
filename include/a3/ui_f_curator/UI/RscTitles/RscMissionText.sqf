#include "\a3\UI_F_Curator\UI\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		RscMissionText_text = _display displayctrl IDC_RSCMISSIONTEXT_TEXT;
	};
	case "onUnload": {
	};
};