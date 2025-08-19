
/*
 * Author: M3ales
 * Locally defined fuction which grabs if a unit is unconscious
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * If is unconscious or not <BOOLEAN>
 *
 * Example:
 * [_unit] call MIRA_Vehicle_Medical_fnc_isUnconscious
 *
 * Public: Yes
 */
params[
	"_patient"
];

IS_UNCONSCIOUS(_patient)