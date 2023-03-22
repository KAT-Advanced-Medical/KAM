#include "\a3\UI_F_Curator\UI\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		["loop",[_display],""] spawn RscVRMeta_script;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlSetText (toUpper (ctrlText _ctrl));
		} foreach [
			IDC_RSCVRMETA_TEXTLOAD,
			IDC_RSCVRMETA_TEXTFATIGUE,
			IDC_RSCVRMETA_TEXTSPEED,
			IDC_RSCVRMETA_TEXTTGT
		];
		
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
		} foreach [
			IDC_RSCVRMETA_TEXTLOAD,
			IDC_RSCVRMETA_TEXTFATIGUE,
			IDC_RSCVRMETA_TEXTSPEED,
			IDC_RSCVRMETA_TEXTTGT,
			IDC_RSCVRMETA_VALUELOAD,
			IDC_RSCVRMETA_VALUEFATIGUE,
			IDC_RSCVRMETA_VALUESPEED,
			IDC_RSCVRMETA_VALUETGT,
			IDC_RSCVRMETA_VALUETGTDMG
		];
		{
			_ctrl = _display displayctrl _x;
			_ctrlPosOrig = ctrlposition _ctrl;
			_ctrlPos = +_ctrlPosOrig;
			_ctrlPos set [2,0];
			_ctrl ctrlsetposition _ctrlPos;
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
			_ctrl ctrlsetposition _ctrlPosOrig;
			_ctrl ctrlsetfade 0;
			_ctrl ctrlcommit 0.25 + random 0.5;
		} foreach [
			IDC_RSCVRMETA_BACKGROUNDFATIGUE,
			IDC_RSCVRMETA_BACKGROUNDSPEED,
			IDC_RSCVRMETA_BACKGROUNDLOAD,
			IDC_RSCVRMETA_BACKGROUNDTGT,
			IDC_RSCVRMETA_PROGRESSLOAD,
			IDC_RSCVRMETA_PROGRESSFATIGUE,
			IDC_RSCVRMETA_PROGRESSSPEED,
			IDC_RSCVRMETA_PROGRESSTGT
		];
		[_display] spawn {
			disableserialization;
			_display = _this select 0;
			uisleep 0.75;
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlsetfade 1;
				_ctrl ctrlcommit 0;
				_ctrl ctrlsetfade 0;
				_ctrl ctrlcommit 0.1;
				_time = diag_ticktime + 0.05;
				waituntil {diag_ticktime > _time};
			} foreach [
				IDC_RSCVRMETA_TEXTLOAD,
				IDC_RSCVRMETA_TEXTFATIGUE,
				IDC_RSCVRMETA_TEXTSPEED,
				IDC_RSCVRMETA_TEXTTGT,
				IDC_RSCVRMETA_VALUELOAD,
				IDC_RSCVRMETA_VALUEFATIGUE,
				IDC_RSCVRMETA_VALUESPEED,
				IDC_RSCVRMETA_VALUETGT,
				IDC_RSCVRMETA_VALUETGTDMG
			];
		};
	};
	case "loop": {
		disableserialization;
		_display = _params select 0;

		_maxSpeed = 18;

		_ctrlVRMeta = _display displayctrl IDC_RSCVRMETA_VRMETA;

		_ctrlValueLoad = _display displayctrl IDC_RSCVRMETA_VALUELOAD;
		_ctrlProgressLoad = _display displayctrl IDC_RSCVRMETA_PROGRESSLOAD;

		_ctrlBackgroundFatigue = _display displayctrl IDC_RSCVRMETA_BACKGROUNDFATIGUE;
		_ctrlValueFatigue = _display displayctrl IDC_RSCVRMETA_VALUEFATIGUE;
		_ctrlProgressFatigue = _display displayctrl IDC_RSCVRMETA_PROGRESSFATIGUE;
		_ctrlProgressTgt = _display displayctrl IDC_RSCVRMETA_PROGRESSTGT;

		_ctrlValueSpeed = _display displayctrl IDC_RSCVRMETA_VALUESPEED;
		_ctrlProgressSpeed = _display displayctrl IDC_RSCVRMETA_PROGRESSSPEED;

		_ctrlValueTgt = _display displayctrl IDC_RSCVRMETA_VALUETGT;
		_ctrlValueTgtDmg = _display displayctrl IDC_RSCVRMETA_VALUETGTDMG;

		_locKMPH = localize "str_lib_info_unit_kilometers_per_hour";
		_locM = localize "str_a3_rscdisplayarcademap_meters";

		while {!isnull _display} do {

			if (vehicle player == player) then {
				_ctrlVRMeta ctrlshow true;
/*
				//--- Load
				_load = load player;
				_ctrlValueLoad ctrlsettext format ["%1%2",round (_load * 100),"%"];
				_ctrlProgressLoad progresssetposition _load;

				//--- Fatigue
				_fatigue = getfatigue player;
				_ctrlValueFatigue ctrlsettext format ["%1%2",round (_fatigue * 100),"%"];
				_ctrlProgressFatigue progresssetposition _fatigue;
*/
				//--- Speed
				_speed = (velocity player vectordistance [0,0,0]) * 3.6;
				_ctrlValueSpeed ctrlsettext format ["%1 %2",round _speed,_locKMPH];
				_ctrlProgressSpeed progresssetposition (_speed / _maxSpeed);

				//--- Target distance
				_dis = -1;
				if (isnull cursortarget) then {
					_pos3D = screentoworld [.5,.5];
					_pos2D = worldtoscreen _pos3D;
					_dis = if (count _pos2D > 0 && {_pos2D distance [.5,.5] > 0.01}) then {-1} else {player distance _pos3D;};
				} else {
					_dis = cursortarget distance player
				};
				_dis = if (_dis < 0) then {"---"} else {str round _dis + " " + _locM};
				_ctrlValueTgt ctrlsettext _dis;

				//--- Dir
				_damage = 1 - damage cursortarget;
				_textDamage = if (isnull cursortarget) then {_damage = 0; "---"} else {format ["%1 %2",round (_damage * 100),"%"]};
				_ctrlProgressTgt progresssetposition _damage;
				_ctrlValueTgtDmg ctrlsettext _textDamage;
			} else {
				_ctrlVRMeta ctrlshow false;
			};

			uisleep 0.01;
		};
	};
	case "onUnload": {
	};
};