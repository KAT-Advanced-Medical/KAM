#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut, mharis001
 * Handles the surgical kit treatment by periodically closing bandaged wounds.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Medic (not used) <OBJECT>
 *   1: Patient <OBJECT>
 * 1: Elapsed Time <NUMBER>
 * 2: Total Time <NUMBER>
 *
 * Return Value:
 * Continue Treatment <BOOL>
 *
 * Example:
 * [[objNull, player], 5, 10] call kat_misc_fnc_surgicalKitProgressFullBody
 *
 * Public: No
 */

params ["_args", "_elapsedTime", "_totalTime"];
_args params ["_medic", "_patient"];

private _stitchableWounds = _patient call FUNC(getFullBodyStitchableWounds);

// Stop treatment if there are no wounds that can be stitched remaining
if (_stitchableWounds isEqualTo createHashMap) exitWith {false};

if (_totalTime - _elapsedTime > ([_patient, _patient] call FUNC(getStitchTimeFullBody)) - ACEGVAR(medical_treatment,woundStitchTime)) exitWith {true};

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);

private _bodyPart = (keys _stitchableWounds) select 0;
private _bandagedWoundsOnPart = _bandagedWounds get _bodyPart;
private _treatedWound = _bandagedWoundsOnPart select (count _bandagedWoundsOnPart - 1);
TRACE_1("trauma - test.5",_bodyPart);
[_patient, _bodyPart,_treatedWound] call FUNC(stitchWound);

false