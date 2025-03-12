#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local callback for checking ACE Fatigue values
 *
 * Arguments:
 * 0: Medic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_vitals_fnc_returnFatigueLocal
 *
 * Public: No
 */

params ["_patient"];

private _return = 0;

if (ACEGVAR(advanced_fatigue,anFatigue) isEqualTypeAny [0, 1e39]) then {
	_return = ACEGVAR(advanced_fatigue,anFatigue);
};

_return