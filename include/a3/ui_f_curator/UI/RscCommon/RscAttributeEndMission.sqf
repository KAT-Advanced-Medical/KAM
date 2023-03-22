#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEENDMISSION_VALUE;
		_type = _unit getvariable ["type",""];
		_type = missionnamespace getvariable [typeof _unit + "RscAttributeEndMission",_type]; //--- Global value (used in countdown and tickets modules)
		_lbcursel = 0;
		{
			_name = gettext (_x >> "name");
			_value = gettext (_x >> "value");
			_lbadd = _ctrlValue lbadd _name;
			_ctrlValue lbsetdata [_lbadd,_value];
			if (_value == _type) then {_lbcursel = _lbadd;};
		} foreach ((configfile >> "cfgvehicles" >> typeof _unit >> "Arguments" >> "TYpe" >> "Values") call bis_fnc_returnchildren);
		_ctrlValue lbsetcursel _lbcursel;

		_debriefing = missionnamespace getvariable [typeof _unit + "RscAttributeEndMission_debriefing",""];
		_ctrlDebriefing = _display displayctrl IDC_RSCATTRIBUTEENDMISSION_DEBRIEFING;
		_ctrlDebriefing ctrlsettext _debriefing;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEENDMISSION_VALUE;
		_type = _ctrlValue lbdata lbcursel _ctrlValue;

		_var = typeof _unit + "RscAttributeEndMission_type";
		missionnamespace setvariable [_var,_type];
		publicvariable _var;

		_ctrlDebriefing = _display displayctrl IDC_RSCATTRIBUTEENDMISSION_DEBRIEFING;	
		_debriefing = ctrltext _ctrlDebriefing;
		_var = typeof _unit + "RscAttributeEndMission_debriefing";
		missionnamespace setvariable [_var,_debriefing];
		publicvariable _var;

		_unit setvariable ["type",_type,true];
		_unit setvariable ["updated",true,true];
	};
};