#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Self-action implementation for the M8/M9 detection paper. Wipes the paper
 * across nearby contamination, then displays the visual result on a paper-style
 * RscTitle. Realistic — only nerve and blister agents register; choking
 * agents (chlorine, phosgene, CS) read NEGATIVE.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_player"];

private _duration = missionNamespace getVariable [QGVAR(m8PaperActionTime), 3];

[
    _duration,
    [_player],
    {
        params ["_args"];
        _args params ["_player"];

        [_player, "kat_m8paper"] call ACEFUNC(common,useItem);

        // Determine result from the unit's most recent cloud exposure within
        // the configured memory window.
        private _gasId = _player getVariable [QGVAR(currentCloudGasId), ""];
        private _last  = _player getVariable [QGVAR(lastCloudExposure), -1e9];
        private _memWindow = missionNamespace getVariable [QGVAR(cloudIdMemoryTime), 30];

        if (CBA_missionTime - _last > _memWindow) then {
            _gasId = "";
        };

        private _m8Color = "";
        if (_gasId != "") then {
            private _gasData = GVAR(gasRegistry) getOrDefault [_gasId, createHashMap];
            _m8Color = _gasData getOrDefault ["m8Color", ""];
        };

        // Stain tint. Alpha 0 = invisible (negative test, paper looks clean —
        // the player reads "No mark = Clean" off the on-paper legend).
        private _stainColor = [1, 1, 1, 0];
        switch (_m8Color) do {
            case "yellow": { _stainColor = [0.95, 0.85, 0.15, 1]; };
            case "green":  { _stainColor = [0.20, 0.40, 0.15, 1]; };
            case "red":    { _stainColor = [0.70, 0.10, 0.10, 1]; };
        };

        "KAT_M8Paper" cutRsc ["KAT_M8Paper", "PLAIN", 0.3, true];
        private _display = uiNamespace getVariable ["KAT_M8Paper", displayNull];
        if (isNull _display) exitWith {};

        (_display displayCtrl 18843) ctrlSetTextColor _stainColor;

        // Auto-fade after configured display time. UI-only timer; safe locally.
        private _displayTime = missionNamespace getVariable [QGVAR(m8PaperDisplayTime), 8];
        [{ "KAT_M8Paper" cutFadeOut 1; }, [], _displayTime] call CBA_fnc_waitAndExecute;
    },
    {},
    LLSTRING(UseM8Paper_Progress),
    {
        params ["_args"];
        _args params ["_player"];
        [_player, _player, ["kat_m8paper"]] call ACEFUNC(medical_treatment,hasItem)
    },
    ["isNotInside"]
] call ACEFUNC(common,progressBar);
