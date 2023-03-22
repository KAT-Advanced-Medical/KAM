#include "\a3\UI_F_Curator\UI\defineResinclDesign.inc"

private ["_display", "_params", "_class"];
_mode 	= _this select 0;
_params = _this select 1;
_class 	= _this select 2;

switch _mode do {
	case "onLoad": {
		private ["_display", "_background", "_title", "_description", "_listbox", "_progressBar"];
		_display 	= _params select 0;
		_background	= _display displayCtrl IDC_RSCRECRUITSTATUS_BACKGROUND;
		_title		= _display displayCtrl IDC_RSCRECRUITSTATUS_TITLE;
		_description	= _display displayCtrl IDC_RSCRECRUITSTATUS_DESCRIPTION;
		_listbox	= _display displayCtrl IDC_RSCRECRUITSTATUS_LIST;
		_progressBar	= _display displayCtrl IDC_RSCRECRUITSTATUS_PROGRESSBAR;
		
		// Store
		uiNamespace setVariable ["RscRecruitStatus_Display", _display];
		uiNamespace setVariable ["RscRecruitStatus_Background", _background];
		uiNamespace setVariable ["RscRecruitStatus_Title", _title];
		uiNamespace setVariable ["RscRecruitStatus_Description", _description];
		uiNamespace setVariable ["RscRecruitStatus_Listbox", _listbox];
		uiNamespace setVariable ["RscRecruitStatus_ProgressBar", _progressBar];
		uiNamespace setVariable ["RscRecruitStatus_BackgroundHeight", (ctrlPosition _background) select 3];
		uiNamespace setVariable ["RscRecruitStatus_DescriptionHeight", (ctrlPosition _description) select 3];
		uiNamespace setVariable ["RscRecruitStatus_ListboxHeightPerRecruit", (ctrlPosition _listbox) select 3];
		uiNamespace setVariable ["RscRecruitStatus_ProgressBarWidth", (ctrlPosition _progressBar) select 2];
	};
	
	case "onUnload": {
		// Reset
		uiNamespace setVariable ["RscRecruitStatus_Display", nil];
		uiNamespace setVariable ["RscRecruitStatus_Background", nil];
		uiNamespace setVariable ["RscRecruitStatus_Title", nil];
		uiNamespace setVariable ["RscRecruitStatus_Description", nil];
		uiNamespace setVariable ["RscRecruitStatus_Listbox", nil];
		uiNamespace setVariable ["RscRecruitStatus_ProgressBar", nil];
		uiNamespace setVariable ["RscRecruitStatus_BackgroundHeight", nil];
		uiNamespace setVariable ["RscRecruitStatus_DescriptionHeight", nil];
		uiNamespace setVariable ["RscRecruitStatus_ListboxHeightPerRecruit", nil];
		uiNamespace setVariable ["RscRecruitStatus_ProgressBarWidth", nil];
	};
};
