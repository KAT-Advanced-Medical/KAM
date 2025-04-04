#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Triggers eye injury effect from dust and rotor wash.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 1: Severity <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectEyeInjury;
 *
 * Public: No
 */

params ["_enable", "_injurySeverity"];

if (isNull findDisplay 46) exitWith {};

private _controls = uiNamespace getVariable [QGVAR(eyeInjuryControls), [controlNull, controlNull]];
_controls params ["_upperLidShutter", "_lowerLidShutter"];

// Initialize controls
if (isNull _upperLidShutter) then {
    TRACE_1("Creating Eye Injury Controls",_controls);
    _upperLidShutter = findDisplay 46 ctrlCreate ["RscPicture", -1];
    _lowerLidShutter = findDisplay 46 ctrlCreate ["RscPicture", -1];

    _upperLidShutter ctrlSetText QPATHTOF(data\UpperBlink.paa);
    _lowerLidShutter ctrlSetText QPATHTOF(data\LowerBlink.paa);

    _upperLidShutter ctrlSetPosition [safeZoneXAbs, (safeZoneY - safeZoneH), safeZoneWAbs, safeZoneH];
    _lowerLidShutter ctrlSetPosition [safeZoneXAbs, (safeZoneY + safeZoneH), safeZoneWAbs, safeZoneH];

    _upperLidShutter ctrlSetFade 0;
    _lowerLidShutter ctrlSetFade 0;

    _upperLidShutter ctrlCommit 0;
    _lowerLidShutter ctrlCommit 0;

    uiNamespace setVariable [QGVAR(eyeInjuryControls), [_upperLidShutter, _lowerLidShutter]];
};

if (_enable) then {
    _upperLidShutter ctrlSetPosition [safeZoneXAbs, ((safeZoneY - safeZoneH) + ((safeZoneH / 5) * _injurySeverity)), safeZoneWAbs, safeZoneH];
    _lowerLidShutter ctrlSetPosition [safeZoneXAbs, ((safeZoneY + safeZoneH) - ((safeZoneH / 5) * _injurySeverity)), safeZoneWAbs, safeZoneH];

    _upperLidShutter ctrlCommit 0.05;
    _lowerLidShutter ctrlCommit 0.05;
} else {
    _upperLidShutter ctrlSetPosition [safeZoneXAbs, (safeZoneY - safeZoneH), safeZoneWAbs, safeZoneH];
    _lowerLidShutter ctrlSetPosition [safeZoneXAbs, (safeZoneY + safeZoneH), safeZoneWAbs, safeZoneH];

    _upperLidShutter ctrlCommit 0;
    _lowerLidShutter ctrlCommit 0;
};
