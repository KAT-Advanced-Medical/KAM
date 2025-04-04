#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles the hurted eyes effect from explosions.
 *
 * Arguments:
 * 0: Enable effect <BOOL>
 * 1: Eyes state <ARRAY>
 * 2: Instant change (optional, default false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false, 0.5] call kat_feedback_fnc_effectHurtEye
 * Public: No
 */

params ["_enable", "_eyeArray", ["_instant", false]];
if (isNull findDisplay 46) exitWith {};

private _controls = uiNamespace getVariable [QGVAR(eyeControls), [controlNull, controlNull, controlNull]];
_controls params ["_eye1", "_eye2", "_wholeInjury"];

if (!_enable) exitWith {
    _eye1 ctrlSetFade 1;
    _eye2 ctrlSetFade 1;

    _eye1 ctrlCommit 0;
    _eye2 ctrlCommit 0;

    _wholeInjury ctrlSetFade 1;
    _wholeInjury ctrlCommit 0;
};

// Initialize controls
if (isNull _eye1) then {
    TRACE_1("Creating Eye Controls",_controls);
    _eye1 = findDisplay 46 ctrlCreate ["RscPicture", -1];
    _eye2 = findDisplay 46 ctrlCreate ["RscPicture", -1];
    _wholeInjury = findDisplay 46 ctrlCreate ["RscPicture", -1];

    _eye1 ctrlSetText QPATHTOF(data\RightEyeEffect.paa);
    _eye2 ctrlSetText QPATHTOF(data\LeftEyeEffect.paa);
    _wholeInjury ctrlSetText QPATHTOF(data\BlindEffect.paa);

    private _pos = [safeZoneXAbs, safeZoneY, safeZoneWAbs, safeZoneH];
    _eye1 ctrlSetPosition _pos;
    _eye2 ctrlSetPosition _pos;
    _wholeInjury ctrlSetPosition _pos;

    _eye1 ctrlSetFade 1;
    _eye2 ctrlSetFade 1;
    _wholeInjury ctrlSetFade 1;

    _eye1 ctrlCommit 0;
    _eye2 ctrlCommit 0;
    _wholeInjury ctrlCommit 0;

    uiNamespace setVariable [QGVAR(eyeControls), [_eye1, _eye2, _wholeInjury]];
};

_eyeArray params ["_rightEye", "_leftEye"];
_eye1 ctrlSetFade _rightEye;
_eye2 ctrlSetFade _leftEye;

_eye1 ctrlCommit 0;
_eye2 ctrlCommit 0;

if (_rightEye == 0 && _leftEye == 0) then {
    _eye1 ctrlSetFade 1;
    _eye2 ctrlSetFade 1;
    _eye1 ctrlCommit 0;
    _eye2 ctrlCommit 0;
    _wholeInjury ctrlSetFade 0;
    _wholeInjury ctrlCommit 0;
} else {
    _wholeInjury ctrlSetFade 1;
    _wholeInjury ctrlCommit 0;
};
