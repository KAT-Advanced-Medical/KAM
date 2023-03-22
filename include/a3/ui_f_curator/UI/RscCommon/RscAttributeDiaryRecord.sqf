#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableserialization;
_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

if (isnil "RscAttributeDiaryRecord_templatesVar") then {RscAttributeDiaryRecord_templatesVar = "RscAttributeDiaryRecord" + typeof _unit;};
_templates = profilenamespace getvariable [RscAttributeDiaryRecord_templatesVar,[]];

_display = _params select 0;
_ctrlTemplate = _display displayctrl IDC_RSCATTRIBUTEDIARYRECORD_TEMPLATELIST;
_ctrlTitle = _display displayctrl IDC_RSCATTRIBUTEDIARYRECORD_TITLEEDIT;
_ctrlDescription = _display displayctrl IDC_RSCATTRIBUTEDIARYRECORD_DESCRIPTIONEDIT;
_ctrlImagePreview = _display displayctrl IDC_RSCATTRIBUTEDIARYRECORD_IMAGEPREVIEW;
_ctrlImageTree = _display displayctrl IDC_RSCATTRIBUTEDIARYRECORD_IMAGETREE;

switch _mode do {
	case "onLoad": {
		["onLoadScheduled",_params,_unit] spawn RscAttributeDiaryRecord;
	};
	case "onLoadScheduled": {
		{_x ctrlenable false; _x ctrlsettext localize "str_network_receive";} foreach [_ctrlTitle,_ctrlDescription,_ctrlImageTree];

		_titleDefault = if (side _unit == sidelogic) then {""} else {gettext (configfile >> "cfgvehicles" >> typeof _unit >> "displayname")};
		_data = [_unit,"RscAttributeDiaryRecord",[_titleDefault,"","",true]] call bis_fnc_getServerVariable;
		_title = _data select 0;
		_text = _data select 1;
		_textureCursel = _unit getvariable ["RscAttributeDiaryRecord_textureCursel",[0,0]];
		RscAttributeDiaryRecord_default = [_title,_text,_textureCursel];

		_ctrlTitle ctrlsettext _title;
		_ctrlDescription ctrlsettext _text;
		_ctrlImageTree ctrladdeventhandler ["treeselchanged","with uinamespace do {['treeSelChanged',[ctrlparent (_this select 0)],objnull] call RscAttributeDiaryRecord;};"];
		{
			_sourceID = _foreachindex;
			{
				_xDisplayName = gettext (_x >> "displayName");
				_tvCategory = _ctrlImageTree tvadd [[],_xDisplayName];
				_ctrlImageTree tvsetvalue [[_tvCategory],_sourceID];
				_ctrlImageTree tvsetdata [[_tvCategory],configname _x];
				{
					_xDisplayName = gettext (_x >> "displayName");
					_xTexture = gettext (_x >> "texture");
					_tvPicture = _ctrlImageTree tvadd [[_tvCategory],_xDisplayName];
					_ctrlImageTree tvsetpicture [[_tvCategory,_tvPicture],_xTexture];
					_ctrlImageTree tvsetdata [[_tvCategory,_tvPicture],_xTexture];
				} foreach (_x call bis_fnc_returnchildren);

			} foreach ((_x >> "CfgDiaryPictures") call bis_fnc_returnchildren);
		} foreach [missionconfigfile,campaignconfigfile,configfile];

		_ctrlImageTree tvsetcursel _textureCursel;

		//--- Load current template
		_lbAdd = _ctrlTemplate lbadd localize "STR_A3_RscAttributeDiaryRecord_new";
		_ctrlTemplate lbsetvalue [_lbAdd,-1];

		//--- Load previous templates
		{
			_lbAdd = _ctrlTemplate lbadd (_x select 0);
			_ctrlTemplate lbsetvalue [_lbAdd,_foreachindex];
		} foreach _templates;
		_ctrlTemplate lbsetcursel 0;
		_ctrlTemplate ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',[ctrlparent (_this select 0)],objnull] call RscAttributeDiaryRecord;};"];

		{_x ctrlenable true} foreach [_ctrlTitle,_ctrlDescription,_ctrlImageTree,_ctrlImageTree];
	};
	case "confirmed": {
		_newTitle = ctrltext _ctrlTitle;
		_newText = ctrltext _ctrlDescription;
		if ((_newText find "<execute") > 0) then {_newText = "";}; //--- Prevent code execution
		_newTexture = ctrltext _ctrlImagePreview;
		_diaryData = [_newTitle,_newText,_newTexture,tvcursel _ctrlImageTree];
		["confirmedScheduled",_params + _diaryData,_unit] spawn RscAttributeDiaryRecord;

		//--- Save into recent templates
		if ({str _diaryData == str _x} count _templates == 0) then {
			_templates = [_diaryData] + _templates;
			_templates resize (count _templates min 10);
			profilenamespace setvariable [RscAttributeDiaryRecord_templatesVar,_templates];
			saveprofilenamespace;
		};
	};
	case "confirmedScheduled": {
		_data = [_unit,"RscAttributeDiaryRecord",["","",""]] call bis_fnc_getServerVariable;
		_title = _data select 0;
		_text = _data select 1;
		_cursel = _unit getvariable ["RscAttributeDiaryRecord_textureCursel",[-1,-1]];

		_newTitle = _params select 1;
		_newText = _params select 2;
		_newTexture = _params select 3;
		_newCursel = _params select 4;
		_updated = false;

		//--- Description updated
		if (_newTitle != _title || _newText != _text) then {
			[_unit,"RscAttributeDiaryRecord",[_newTitle,_newText]] call bis_fnc_setServerVariable;
			_updated = "true";
		};

		//--- Texture updated (stored independently for easier access)
		if (count _newCursel == 2 && count _cursel == 2) then {
			if (_newCursel distance _cursel > 0) then {
				_unit setvariable ["RscAttributeDiaryRecord_texture",_newTexture,true];
				_unit setvariable ["RscAttributeDiaryRecord_textureCursel",_newCursel,true];
				if (side _unit != sidelogic) then {_unit setobjecttextureglobal [0,_newTexture];};
				_updated = "true";
			};
			if (_updated) then {
				_unit setvariable ["RscAttributeDiaryRecord_updated",true,true];
			};
		};
	};
	case "onUnload": {
		RscAttributeDiaryRecord_templatesVar = nil;
		RscAttributeDiaryRecord_default = nil;
	};
	case "treeSelChanged": {
		_cursel = tvcursel _ctrlImageTree;
		if (count _cursel == 2) then {
			_texture = _ctrlImageTree tvdata _cursel;
			_ctrlImagePreview ctrlsettext _texture;
		} else {
			_ctrlImagePreview ctrlsettext "#(argb,8,8,3)color(0,0,0,0)";
		};
	};
	case "lbSelChanged": {
		_templateID = _ctrlTemplate lbvalue lbcursel _ctrlTemplate;
		if (_templateID < 0) then {
			_data = RscAttributeDiaryRecord_default;
			_ctrlTitle ctrlsettext "";
			_ctrlDescription ctrlsettext "";
			_ctrlImageTree tvsetcursel (_data select 2);
		} else {
			_template = _templates select _templateID;

			_ctrlTitle ctrlsettext (_template select 0);
			_ctrlDescription ctrlsettext (_template select 1);
			_ctrlImageTree tvsetcursel (_template select 3);
		};
	};
};
