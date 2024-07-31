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

params ["_target", "_player"];

private _fnc_getActions = {
    private _actions = [];
    private _cfgWeapons = configFile >> "CfgWeapons";
    private _idNumber = 0;

    {
        private _config = _cfgWeapons >> _x;
        _idNumber = getNumber (_config >> "testID");

        if (_idNumber > 0) then {   
            private _bloodTestArray = EGVAR(circulation,resultSampleMap) get _idNumber;
            private _patient = _bloodTestArray select 0;

            _actions pushBack [
                [
                    _x,
                    format ["Apply %1 Test ", _patient],
                    "",
                    {_this call FUNC(attachBloodGas)},
                    {true},
                    {},
                    []
                ] call ACEFUNC(interact_menu,createAction),
                [],
                [_bloodTestArray, _target, _idNumber, _player]
            ];
        };
    } forEach ([_player, 0] call ACEFUNC(common,uniqueItems));

    _actions
};


[[], _fnc_getActions, _player, QGVAR(actionsCache), 9999, "cba_events_loadoutEvent"] call ACEFUNC(common,cachedCall);