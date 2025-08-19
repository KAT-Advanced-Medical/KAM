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
		( GVAR(Stable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP))
		|| { GVAR(Stable_TrackLowHR) && ([_patient, _isMedic] call FUNC(hasLowHR)) }
		|| { GVAR(Stable_TrackFractures) && ([_patient] call FUNC(hasFractures)) }
		|| { GVAR(Stable_TrackStitchableWounds) && (count ([_patient] call FUNC(getStitchableWounds))) > 0 }
		|| { GVAR(Stable_TrackNeedsBandage) && ([_patient] call FUNC(getNumberOfWoundsToBandage)) > 0 }
		|| { GVAR(Stable_TrackTourniquets) && [_patient] call FUNC(hasTourniquets) }
	}