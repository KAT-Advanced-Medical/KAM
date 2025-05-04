#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Callback to wrap wounds on a bodypart
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body part ("Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg") <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_wrapWound
 *
 * Public: No
 */

params ["_patient", "_bodyPart", ["_treatedWound", []]];

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];

private _bandagedIndex = (count _bandagedWoundsOnPart) - 1;
if (_treatedWound isEqualTo []) then {
    _treatedWound = _bandagedWoundsOnPart param [_bandagedIndex, _treatedWound];
} else {
    _bandagedIndex = _bandagedWoundsOnPart find _treatedWound;
};

if (_bandagedIndex == -1) exitWith {false};

private _rawBandageType = (_bandagedWoundsOnPart select _bandagedIndex) select 2;

private _excludedTypes = ["FieldDressing", "PackingBandage", "ElasticBandage", "QuikClot", "ETD", "Hemostat", "Abdominal_Pad", "Adhesive_Bandage"];
if (_rawBandageType in _excludedTypes) exitWith {false};

private _bandageType = _rawBandageType + "_wrapped";

_bandagedWoundsOnPart deleteAt _bandagedIndex;

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];

[_patient, _bodyPart, _bandageType] call EFUNC(misc,bandageLocal);

true // return