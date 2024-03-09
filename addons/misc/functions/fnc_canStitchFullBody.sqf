#include "..\script_component.hpp"
/*
 * Author: Katalam, mharis001, Brett Mayson
 * Checks if the patient can be stitched.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * ReturnValue:
 * Can Stitch <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_misc_fnc_canStitchFullBody
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(GVAR(enableStitchFullBody)) exitWith {false};
if ((ACEGVAR(medical_treatment,consumeSurgicalKit) == 2) && {!([_medic, _patient, ["ACE_Suture"]] call ACEFUNC(medical_treatment,hasItem))}) exitWith {false};


count (_patient call FUNC(getFullBodyStitchableWounds)) > 0