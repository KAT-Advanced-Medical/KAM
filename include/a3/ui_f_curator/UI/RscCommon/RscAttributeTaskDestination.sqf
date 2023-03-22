#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTELOCK_LOCKED,
	IDC_RSCATTRIBUTELOCK_UNLOCKED,
	IDC_RSCATTRIBUTELOCK_UNLOCKED
];
_states = [2,1,0];

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_value = _display displayctrl IDC_RSCATTRIBUTETASKDESTINATION_VALUE;
		_value lbsetcursel (_entity getvariable ["RscAttributeTaskDestination",0]);
		_value ctrladdeventhandler ["toolboxSelChanged",{with uinamespace do {RscAttributeTaskDestination_value = _this select 1;};}];
	};
	case "confirmed": {
		_entity setvariable ["RscAttributeTaskDestination",uinamespace getvariable ["RscAttributeTaskDestination_value",0],true];
		_entity setvariable ["updated",true,true];
	};
	case "onUnload": {
		RscAttributeTaskDestination_value = nil;
	};
};