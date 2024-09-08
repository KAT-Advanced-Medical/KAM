#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Modified: Mazinski
 * Triggers the fentanyl visual effect and applies the opioid factor from Fentanyl.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "LeftLeg", 1] call kat_pharma_fnc_treatmentAdvanced_FentanylLocal;
 *
 * Public: No
 */


/// ChromAberration effect
params ["_target", "_bodyPart", "_opioidRelief"];

private _opioidFactor = _target getVariable [QGVAR(opioidFactor), 1];
if (_opioidFactor == 1) then {
    _target setVariable [QGVAR(opioidFactor), _opioidRelief, true];
};