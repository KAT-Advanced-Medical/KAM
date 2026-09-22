#include "..\script_component.hpp"
/*
 * Author: SzwedzikPL, mharis001
 * Modified: Mazinski
 * Reworked by Claude to read the server-synced sample map directly instead of
 * a shared cachedCall (it collided with fnc_addArterialApplyActions.sqf) and to
 * drop the fetch (the map is small and local, no longer worth caching)
 * Add arterial blood gas test action to vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Medic <OBJECT>
 *
 * Return Value:
 * Ace actions <ARRAY>
 *
 * Example:
 * [vehicle, medic] call kat_circulation_fnc_addArterialTestActions;
 *
 * Public: No
 */

params ["_vehicle", "_player"];

private _actions = [];
private _cfgWeapons = configFile >> "CfgWeapons";
private _bloodSampleMap = missionNamespace getVariable QGVAR(bloodSampleMap);

if (isNil "_bloodSampleMap") exitWith {_actions};

{
    private _idNumber = getNumber (_cfgWeapons >> _x >> "nameID");
    private _entry = _bloodSampleMap get _idNumber;

    // idNumber unset (0), or a stale item classname with no matching entry
    // (already tested/expired) - skip it
    if (_idNumber > 0 && {!isNil "_entry"}) then {
        private _patient = _entry get "patient";

        _actions pushBack [
            [
                _x,
                format [LLSTRING(Blood_Sample_String), _patient],
                "",
                {call FUNC(requestTestSample)},
                {true},
                {},
                [],
                {[0, 0, 0]},
                2,
                [false,false,false,false,false]
            ] call ACEFUNC(interact_menu,createAction),
            [],
            [_player, _idNumber, _vehicle]
        ];
    };
} forEach ([_vehicle, 0] call ACEFUNC(common,uniqueItems));

_actions
