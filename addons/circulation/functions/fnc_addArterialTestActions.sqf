#include "..\script_component.hpp"
/*
 * Author: SzwedzikPL, mharis001
 * Modified: Mazinski
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

private _fnc_getActions = {
    private _actions = [];
    private _cfgWeapons = configFile >> "CfgWeapons";
    private _idNumber = 0;

    {
        private _config = _cfgWeapons >> _x;
        _idNumber = getNumber (_config >> "nameID");

        if (_idNumber > 0) then {   
            private _bloodSampleArray = missionNamespace getVariable [QEGVAR(circulation,bloodSampleMap), []];
            _bloodSampleArray = _bloodSampleArray get _idNumber;
            private _patient = _bloodSampleArray select 0;

            _actions pushBack [
                [
                    _x,
                    format [LLSTRING(Blood_Sample_String), _patient],
                    "",
                    {_this call FUNC(showBloodGas)},
                    {true},
                    {},
                    [],
                    {[0, 0, 0]},
                    2,
                    [false,false,false,false,false]
                ] call ACEFUNC(interact_menu,createAction),
                [],
                [_bloodSampleArray, _player, _idNumber, _vehicle]
            ];
        };
    } forEach ([_vehicle, 0] call ACEFUNC(common,uniqueItems));

    _actions
};


[[], _fnc_getActions, _player, QGVAR(actionsCache), 9999, "cba_events_loadoutEvent"] call ACEFUNC(common,cachedCall);
