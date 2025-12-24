#include "..\script_component.hpp"

/*
 * Author: M3ales
 *
 * Based on https://github.com/acemod/ACE3/blob/v3.13.5/addons/medical_ai/functions/fnc_isInjured.sqf
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * If in cardiac arrest or not <BOOLEAN>
 *
 * Example:
 * [_unit] call MIRA_Vehicle_Medical_fnc_isCardiacArrest
 * Public: Yes
 */
params[
	"_patient",
	["_isMedic", false, [false]]
];

!([_patient] call FUNC(isUnstable))
	&& {
		private _bloodPressure = [_patient] call EFUNC(circulation,getBloodPressure);
		_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
		private _map = GET_MAP(_unit);
		( GVAR(Stable_TrackLowBP) && (_map < 60))
		|| { GVAR(Stable_TrackLowHR) && (GET_HEART_RATE(_patient) < 60)}
		|| { GVAR(Stable_TrackFractures) && ((selectMax GET_FRACTURES(_patient)) > 0)}
		|| { GVAR(Stable_TrackNeedsBandage) && ([_patient] call FUNC(getNumberOfWoundsToBandage)) > 0 }
		|| { GVAR(Stable_TrackTourniquets) && ((selectMax GET_TOURNIQUETS(_patient)) > 0)}
	}