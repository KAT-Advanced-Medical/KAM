#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableserialization;
_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

if (isnil "RscAttributeTaskDescription_templatesVar") then {RscAttributeTaskDescription_templatesVar = "RscAttributeTaskDescription" + typeof _unit;};
_templates = profilenamespace getvariable [RscAttributeTaskDescription_templatesVar,[]];

_display = _params select 0;
_ctrlTemplate = _display displayctrl IDC_RSCATTRIBUTETASKDESCRIPTION_EDITTEMPLATE;
_ctrlTitle = _display displayctrl IDC_RSCATTRIBUTETASKDESCRIPTION_EDITTITLE;
_ctrlDescription = _display displayctrl IDC_RSCATTRIBUTETASKDESCRIPTION_EDITDESCRIPTION;
_ctrlMarker = _display displayctrl IDC_RSCATTRIBUTETASKDESCRIPTION_EDITMARKER;

switch _mode do {
	case "onLoad": {
		["onLoadScheduled",_params,_unit] spawn RscAttributeTaskDescription;
	};
	case "onLoadScheduled": {
		_descriptionDefault = [ctrltext _ctrlDescription,ctrltext _ctrlTitle,ctrltext _ctrlMarker,false];
		{_x ctrlenable false; _x ctrlsettext localize "str_network_receive"} foreach [_ctrlTemplate,_ctrlDescription,_ctrlTitle,_ctrlMarker];
		_description = [_unit,"RscAttributeTaskDescription",_descriptionDefault] call bis_fnc_getServerVariable;
		_ctrlDescription ctrlsettext (_description select 0);
		_ctrlTitle ctrlsettext (_description select 1);
		_ctrlMarker ctrlsettext (_description select 2);
		RscAttributeTaskDescription_default = _description;

		//--- Load current template
		_ctrlTemplate ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',[ctrlparent (_this select 0)],objnull] call RscAttributeTaskDescription;};"];
		_templateDefault = if (count _description == 4) then {localize "STR_A3_RscAttributeTaskDescription_New"} else {localize "STR_A3_RscAttributeTaskDescription_Current"};
		_lbAdd = _ctrlTemplate lbadd _templateDefault;
		_ctrlTemplate lbsetvalue [_lbAdd,-1];

		//--- Load previous templates
		{
			_lbAdd = _ctrlTemplate lbadd (_x select 1);
			_ctrlTemplate lbsetvalue [_lbAdd,_foreachindex];
		} foreach _templates;
		_ctrlTemplate lbsetcursel 0;

		{_x ctrlenable true;} foreach [_ctrlTemplate,_ctrlDescription,_ctrlTitle,_ctrlMarker];
	};
	case "confirmed": {
		private _description = ctrltext _ctrlDescription;
		if ((_description find "<execute") > 0) then {_description = "";}; //--- Prevent code execution
		_taskTexts = [_description,ctrltext _ctrlTitle,ctrltext _ctrlMarker];
		[_unit,"RscAttributeTaskDescription",_taskTexts] call bis_fnc_setServerVariable;
		_unit setvariable ["updated",true,true];
		_unit setname format [ctrltext _ctrlTitle];

		//--- Save into recent templates
		if ({str _taskTexts == str _x} count _templates == 0) then {
			_templates = [_taskTexts] + _templates;
			_templates resize (count _templates min 20);
			profilenamespace setvariable [RscAttributeTaskDescription_templatesVar,_templates];
			saveprofilenamespace;
		};
	};
	case "onUnload": {
		RscAttributeTaskDescription_templatesVar = nil;
		RscAttributeTaskDescription_default = nil;
	};
	case "lbSelChanged": {
		_templateID = _ctrlTemplate lbvalue lbcursel _ctrlTemplate;
		if (_templateID < 0) then {
			_description = RscAttributeTaskDescription_default;
			_ctrlDescription ctrlsettext (_description select 0);
			_ctrlTitle ctrlsettext (_description select 1);
			_ctrlMarker ctrlsettext (_description select 2);
		} else {
			_template = _templates select _templateID;

			_ctrlDescription ctrlsettext (_template select 0);
			_ctrlTitle ctrlsettext (_template select 1);
			_ctrlMarker ctrlsettext (_template select 2);
		};
	};
};