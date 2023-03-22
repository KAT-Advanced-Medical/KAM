#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_mode","_params","_entity"];
_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_sizes = [50,100,250];

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEAREASIZE_VALUE;
		_ctrlValue ctrladdeventhandler ["toolboxSelChanged",{with uinamespace do {["selChanged",_this,objnull] call RscAttributeAreaSize;};}];

		_sector = _entity getvariable ["sector",objnull];
		_areas = _sector getvariable ["areas",[]];
		_size = if (count _areas > 0) then {
			triggerarea (_areas select 0) select 0
		} else {
			_sizes select 0
		};
		if !(_size in _sizes) then {_size = _sizes select 0;};
		RscAttributeAreaSize_valueCurrent = _size;
		RscAttributeAreaSize_value = _size;
		_ctrlValue lbsetcursel (_sizes find _size);

		//--- Preview marker
		_preview = "RscAttributeAreaSize";
		_preview = createmarkerlocal [_preview,position _entity];
		_preview setmarkershapelocal "ellipse";
		_preview setmarkerbrushlocal "border";
		_preview setmarkercolorlocal "colorblack";
		_preview setmarkersizelocal [_size,_size];

		//--- Preview logic
		_previewLogic = (format ["LogicSectorPreview%1m_F",_size * 2]) createvehiclelocal position _entity;
		_previewLogic attachto [_entity,[0,0,0]];
		missionnamespace setvariable ["RscAttributeAreaSize_previewLogic",_previewLogic];
	};
	case "selChanged": {
		RscAttributeAreaSize_value = (_sizes select (_params select 1));
		"RscAttributeAreaSize" setmarkersizelocal [RscAttributeAreaSize_value,RscAttributeAreaSize_value];

		_previewLogic = missionnamespace getvariable ["RscAttributeAreaSize_previewLogic",objnull];
		if (RscAttributeAreaSize_value != RscAttributeAreaSize_valueCurrent) then {
			_entity = attachedto _previewLogic;
			deletevehicle _previewLogic;
			_previewLogic = (format ["LogicSectorPreview%1m_F",RscAttributeAreaSize_value * 2]) createvehiclelocal position _entity;
			_previewLogic attachto [_entity,[0,0,0]];
			missionnamespace setvariable ["RscAttributeAreaSize_previewLogic",_previewLogic];	
		} else {
			_previewLogic hideobject true;
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_size = RscAttributeAreaSize_value;

		//--- Set desired size
		_sector = _entity getvariable ["sector",objnull];
		_areas = _sector getvariable ["areas",[]];
		_size = if (count _areas > 0) then {
			_trigger = _areas select 0;
			_trigger settriggerarea [_size,_size,0,false];
			_trigger setvariable ["pos",[0,0,0],true];
			_sector setvariable ["size",_size,true];
			[[_sector,[],true,"area"],"bis_fnc_moduleSector",_sides] call bis_fnc_mp;
		};
	};
	case "onUnload": {
		RscAttributeAreaSize_valueCurrent = nil;
		RscAttributeAreaSize_value = nil;
		_previewLogic = missionnamespace getvariable ["RscAttributeAreaSize_previewLogic",objnull];
		deletevehicle _previewLogic;
		missionnamespace setvariable ["RscAttributeAreaSize_previewLogic",nil];
		deletemarkerlocal "RscAttributeAreaSize";
	};
};