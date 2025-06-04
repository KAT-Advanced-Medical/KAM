#include "..\script_component.hpp"
/*
 * Author: kymckay
 * Calculates the Surgical Kit treatment time based on the amount of stitchable wounds on the Full Body.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Treatment Time <NUMBER>
 *
 * Example:
 * [player, cursorObject] call kat_misc_fnc_getStitchTimeFullBody
 *
 * Public: No
 */

params ["", "_patient"];

private _amount = 0;

private _amount = _patient call FUNC(getFullBodyStitchableWoundTime);

_amount * ACEGVAR(medical_treatment,woundStitchTime);
