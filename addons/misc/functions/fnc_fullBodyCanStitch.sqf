#include "script_component.hpp"
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
 * [player, cursorTarget] call kat_misc_fnc_fullBodyCanStitch
 *
 * Public: No
 */

params ["_medic", "_patient"];


if ((GVAR(consumeSurgicalKit) == 2) call FUNC(hasItem)) exitWith { false};


count (_patient call FUNC(getFullBodyStitchableWounds)) > 0