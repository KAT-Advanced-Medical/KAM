#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR1,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR2,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR3,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR4,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR5,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR6,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR7,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR8,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR9,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR10,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR11,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR12,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR13,
	IDC_RSCATTRIBUTEMARKERCOLOR_COLOR14
];
_states = [
	"colorblack",
	"colorwhite",
	"colorred",
	"colororange",
	"coloryellow",
	"colorgreen",
	"colorblue",
	"colorblufor",
	"coloropfor",
	"colorindependent",
	"colorcivilian",
	"colorunknown",
	"",
	""
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;
		_type = markertype _entity;
		_typeTexture = _type call bis_fnc_texturemarker;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeMarkerColor};"];
			_colorClass = _states select _foreachindex;
			if (_colorClass == "") then {
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
			} else {
				_tooltip = gettext (configfile >> "cfgmarkercolors" >> _colorClass >> "name");
				_ctrl ctrlsettooltip _tooltip;
				_ctrl ctrlsettext _typeTexture;
			};
		} foreach _idcs;

		//--- Select the current state
		_selected = tolower markercolor _entity;
		_selectedIndex = _states find _selected;
		_ctrlSelected = if (_selectedIndex >= 0) then {
			_selectedIDC = _idcs select _selectedIndex;
			_display displayctrl _selectedIDC
		} else {
			_display displayctrl 1
		};
		['onButtonClick',[_ctrlSelected,0]] call RscAttributeMarkerColor;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_scale = 1;
			_colorClass = _states select _foreachindex;
			if (_colorClass != "") then {
				_color = (configfile >> "cfgmarkercolors" >> _colorClass >> "color") call bis_fnc_colorconfigtorgba;
				_ctrl ctrlsetactivecolor _color;
				if (_ctrl == _ctrlSelected) then {
					_scale = 1.25;
				} else {
					_color set [3,0.5];
				};
				_ctrl ctrlsettextcolor _color;
				[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
			};
		} foreach _idcs;
		RscAttributeMarkerColor_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeMarkerColor_selected",0];
		if (_selectedIndex >= 0) then {
			_selected = _states select _selectedIndex;
			_entity setmarkercolor _selected;

			//--- All future markers to use this color
			_curator = getassignedcuratorlogic player;
			_curator setvariable ["RscAttributeMarkerColor",_selected];
			if (isnil {_curator getvariable "RscAttributeMarkerColor_curatorMarkerPlaced"}) then {
				_curatorMarkerPlaced = _curator addeventhandler [
					"curatorMarkerPlaced",
					{
						(_this select 1) setmarkercolor ((_this select 0) getvariable ["RscAttributeMarkerColor","ColorBlack"]);
					}
				];
				_curator setvariable ["RscAttributeMarkerColor_curatorMarkerPlaced",_curatorMarkerPlaced];
			};
		};
		false
	};
	case "onUnload": {
		RscAttributeMarkerColor_selected = nil;
	};
};