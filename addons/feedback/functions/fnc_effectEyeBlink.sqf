#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles shock from explosions and covers eye injury transitions
 *
* Arguments:
 * 0: Time <NUMBER>
 * 1: Shock <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1, false] call kat_feedback_fnc_effectEyeShock;
 *
 * Public: No
 */

params ["_time", "_shock"];
if (isNull findDisplay 46) exitWith {};

private _controls = uiNamespace getVariable [QGVAR(blinkControls), [controlNull, controlNull]];
_controls params ["_upperLid", "_lowerLid"];

// Initialize controls
if (isNull _upperLid) then {
    TRACE_1("Creating Blink Controls",_controls);
    _upperLid = findDisplay 46 ctrlCreate ["RscPicture", -1];
    _lowerLid = findDisplay 46 ctrlCreate ["RscPicture", -1];

    _upperLid ctrlSetText QPATHTOF(data\UpperBlink.paa);
    _lowerLid ctrlSetText QPATHTOF(data\LowerBlink.paa);

    _upperLid ctrlSetPosition [safeZoneXAbs, (safeZoneY - safeZoneH), safeZoneWAbs, safeZoneH];
    _lowerLid ctrlSetPosition [safeZoneXAbs, (safeZoneY + safeZoneH), safeZoneWAbs, safeZoneH];

    _upperLid ctrlSetFade 0;
    _lowerLid ctrlSetFade 0;

    _upperLid ctrlCommit 0;
    _lowerLid ctrlCommit 0;

    uiNamespace setVariable [QGVAR(blinkControls), [_upperLid, _lowerLid]];
};

_upperLid ctrlSetPosition [safeZoneXAbs, safeZoneY, safeZoneWAbs, safeZoneH];
_lowerLid ctrlSetPosition [safeZoneXAbs, safeZoneY, safeZoneWAbs, safeZoneH];

_upperLid ctrlCommit 0.04;
_lowerLid ctrlCommit 0.04;

if (_shock) then {
    GVAR(ppBlurBlink) ppEffectEnable true;
    GVAR(ppBlurBlink) ppEffectAdjust [0.4];
    GVAR(ppBlurBlink) ppEffectCommit 0.04;
};

[{
    params ["_upperLid", "_lowerLid", "_shock", "_time"];
    _upperLid ctrlSetPosition [safeZoneXAbs, (safeZoneY - safeZoneH), safeZoneWAbs, safeZoneH];
    _lowerLid ctrlSetPosition [safeZoneXAbs, (safeZoneY + safeZoneH), safeZoneWAbs, safeZoneH];

    if (_shock) then {
        _upperLid ctrlCommit 0.1;
        _lowerLid ctrlCommit 0.1;

        GVAR(ppBlurBlink) ppEffectAdjust [0];
        GVAR(ppBlurBlink) ppEffectCommit (_time * 4);

        [{ GVAR(ppBlurBlink) ppEffectEnable false; }, [], (_time * 4)] call CBA_fnc_waitAndExecute;
    } else {
        _upperLid ctrlCommit 0.04;
        _lowerLid ctrlCommit 0.04;
    };
}, [_upperLid, _lowerLid, _shock, _time], _time] call CBA_fnc_waitAndExecute;