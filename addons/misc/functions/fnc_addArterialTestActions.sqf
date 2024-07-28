#include "..\script_component.hpp"
/*
 * Author: SzwedzikPL, mharis001
 * Modified: Mazinski
 * Add arterial blood gas test action to vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Ace actions <ARRAY>
 *
 * Example:
 * [vehicle] call kat_misc_fnc_addArterialTestActions;
 *
 * Public: No
 */

params ["_player"];

private _fnc_getActions = {
    private _actions = [];
    private _cfgWeapons = configFile >> "CfgWeapons";

    {
        private _config = _cfgWeapons >> _x;
        private _idNumber = getNumber (_config >> "nameID");

        if (_idNumber > 0) then {   

            _actions pushBack [
                [
                    _x,
                    (EGVAR(circulation,bloodSampleMap) get _idNumber) select 0,
                    "",
                    {[EGVAR(circulation,bloodSampleMap),_player] call FUNC(showBloodGas)},
                    {true},
                    {},
                    _x
                ] call EFUNC(interact_menu,createAction),
                [],
                _player
            ];
        };
    } forEach ([_player, 0] call ACEFUNC(common,uniqueItems));

    _actions
};

[[], _fnc_getActions, _player, QGVAR(actionsCache), 9999, "cba_events_loadoutEvent"] call ACEFUNC(common,cachedCall);
