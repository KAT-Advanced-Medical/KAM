#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEGENERICRADIO_VALUE;
		_ctrlValue ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',_this,objnull] call RscAttributeGenericRadio};"];
		{
			_lbadd = _ctrlValue lbadd (_x select 1);
			_ctrlValue lbsetdata [_lbadd,_x select 0];
		} foreach [
			["SentGenReinforcementsConfirmed",localize "STR_A3_We_re_sending_reinforcements_"],
			["SentGenReinforcementsRejected",localize "STR_A3_Cannot_send_reinforcements_"],
			["SentGenReinforcementsArrived",localize "STR_A3_Reinforcements_have_arrived_"],
			["SentGenLeavingAO",localize "STR_A3_You_are_leaving_Area_of_Operation_"],
			["SentGenTime",localize "STR_A3_The_time_is_running_out_"],
			["SentGenLosing",localize "STR_A3_Stop_the_enemy_"],
			["SentGenLost",localize "STR_A3_Objective_failed_"],
			["SentGenComplete",localize "STR_A3_Objective_completed_"],
			["SentGenCmdSeize",localize "STR_A3_Seize_the_area_"],
			["SentGenCmdDefend",localize "STR_A3_Defend_the_location_"],
			["SentGenCmdRTB",localize "STR_A3_Return_back_to_base_"],
			["SentGenCmdTargetNeutralize",localize "STR_A3_Neutralize_the_target_"],
			["SentGenCmdTargetProtect",localize "STR_A3_Protect_the_target_"],
			["SentGenCmdTargetEscort",localize "STR_A3_Escort_the_target_"],
			["SentGenCmdTargetFind",localize "STR_A3_Find_the_target_"],
			["SentGenIncoming",localize "STR_A3_Incoming_enemy_fire_"],
			["SentGenBaseUnlockRespawn",localize "STR_A3_New_insertion_point_ready_to_use_"],
			["SentGenBaseUnlockVehicle",localize "STR_A3_New_vehicle_ready_to_use_"],
			["SentGenBaseSideFriendlyWEST",localize "STR_A3_BLUFOR_is_friendly_"],
			["SentGenBaseSideFriendlyEAST",localize "STR_A3_OPFOR_is_friendly_"],
			["SentGenBaseSideFriendlyGUER",localize "STR_A3_Independent_forces_are_friendly_"],
			["SentGenBaseSideEnemyWEST",localize "STR_A3_BLUFOR_is_enemy_"],
			["SentGenBaseSideEnemyEAST",localize "STR_A3_OPFOR_is_enemy_"],
			["SentGenBaseSideEnemyGUER",localize "STR_A3_Independent_forces_are_enemy_"]
		];
		_ctrlValue lbsetcursel (uinamespace getvariable ["RscAttributeRadio_selected",0]);
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEGENERICRADIO_VALUE;
		_unit setvariable ["RscAttributeRadio",_ctrlValue lbdata (lbcursel _ctrlValue),true];
	};
	case "onUnload": {
	};
	case "lbSelChanged": {
		_ctrlValue = _params select 0;
		_cursel = _params select 1;
		_message = _ctrlValue lbdata _cursel;

		//player globalradio _message;
		RscAttributeGenraicRadio_selected = _cursel;
	};
};