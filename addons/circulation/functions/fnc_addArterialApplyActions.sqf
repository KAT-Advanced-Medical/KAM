#include "..\script_component.hpp"
/*
 * Author: SzwedzikPL, mharis001
 * Modified: Mazinski
 * Reworked by Claude to read the server-synced result map directly instead of
 * a shared cachedCall (it collided with fnc_addArterialTestActions.sqf) and to
 * drop the fetch (the map is small and local, no longer worth caching)
 * Apply arterial blood gas test to patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Medic <OBJECT>
 *
 * Return Value:
 * Ace actions <ARRAY>
 *
 * Example:
 * [patient, medic] call kat_circulation_fnc_addArterialApplyActions;
 *
 * Public: No
 */

params ["_target", "_player"];

private _actions = [];
private _cfgWeapons = configFile >> "CfgWeapons";
private _resultSampleMap = missionNamespace getVariable QGVAR(resultSampleMap);

if (isNil "_resultSampleMap") exitWith {_actions};

{
    private _idNumber = getNumber (_cfgWeapons >> _x >> "testID");
    private _entry = _resultSampleMap get _idNumber;

    // idNumber unset (0), or a stale item classname with no matching entry
    // (already applied/expired) - skip it
    if (_idNumber > 0 && {!isNil "_entry"}) then {
        private _patient = _entry get "patient";

        _actions pushBack [
            [
                _x,
                format [LLSTRING(Apply_Arterial_Test), _patient],
                "",
                {call FUNC(requestApplyResult)},
                {true},
                {},
                []
            ] call ACEFUNC(interact_menu,createAction),
            [],
            [_target, _idNumber, _player]
        ];
    };
} forEach ([_player, 0] call ACEFUNC(common,uniqueItems));

_actions
