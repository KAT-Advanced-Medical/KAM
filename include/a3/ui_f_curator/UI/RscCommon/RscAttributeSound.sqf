#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTESOUND_VALUE;
		_ctrlValue ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',_this,objnull] call RscAttributeSound};"];

		//--- Get sound objects
		_sounds = uinamespace getvariable "RscAttributeSound_objects";
		if (isnil "_sounds") then {
			_sounds = [];
			{
				if (gettext (_x >> "sound") != "" && getnumber (_x >> "scope") > 1 && gettext (_x >> "simulation") == "") then {
					_sounds set [count _sounds,_x];
				};
			} foreach ((configfile >> "cfgvehicles") call bis_fnc_returnchildren);
			uinamespace setvariable ["RscAttributeSound_objects",_sounds];
		};

		//--- Add objects to the list
		{
			_name = gettext (_x >> "displayname");
			if (_name != "") then {
				_lbadd = _ctrlValue lbadd _name;
				_ctrlValue lbsetdata [_lbadd,configname _x];
			};
		} foreach _sounds;

		_ctrlValue lbsetcursel (uinamespace getvariable ["RscAttributeSound_selected",0]);
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTESOUND_VALUE;
		_unit setvariable ["RscAttributeSound",_ctrlValue lbdata (lbcursel _ctrlValue),true];
	};
	case "onUnload": {
		if !(isnil "RscAttributeSound_trigger") then {deletevehicle RscAttributeSound_trigger;};
		RscAttributeSound_trigger = nil;
	};
	case "lbSelChanged": {
		_ctrlValue = _params select 0;
		_cursel = _params select 1;
		_sound = _ctrlValue lbdata _cursel;
		RscAttributeSound_selected = _cursel;

		if !(isnil "RscAttributeSound_trigger") then {deletevehicle RscAttributeSound_trigger;};
		RscAttributeSound_trigger = createtrigger ["EmptyDetector",position curatorcamera];
		RscAttributeSound_trigger settriggerstatements ["true","",""];
		RscAttributeSound_trigger setpos position curatorcamera;
		RscAttributeSound_trigger setsoundeffect ["$NONE$","","",gettext (configfile >> "cfgvehicles" >> _sound >> "sound")];
	};
};