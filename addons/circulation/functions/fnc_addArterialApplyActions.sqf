#include "..\script_component.hpp"
/*
 * Author: SzwedzikPL, mharis001
 * Modified: Mazinski
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

private _fnc_getActions = {
    private _actions = [];
    private _cfgWeapons = configFile >> "CfgWeapons";
    private _idNumber = 0;

    {
        private _config = _cfgWeapons >> _x;
        _idNumber = getNumber (_config >> "testID");

        if (_idNumber > 0) then {   
            private _resultSampleMap = missionNamespace getVariable [QEGVAR(circulation,resultSampleMap), []];
            _resultSampleArray = _resultSampleMap get _idNumber;
            _resultSampleActual = _resultSampleArray select 1;
            private _patient = _resultSampleArray select 0;

            _actions pushBack [
                [
                    _x,
                    format [LLSTRING(Apply_Arterial_Test), _patient],
                    "",
                    {_this call FUNC(attachBloodGas)},
                    {true},
                    {},
                    []
                ] call ACEFUNC(interact_menu,createAction),
                [],
                [_resultSampleActual, _target, _idNumber, _player]
            ];
        };
    } forEach ([_player, 0] call ACEFUNC(common,uniqueItems));

    _actions
};


[[], _fnc_getActions, _player, QGVAR(actionsCache), 9999, "cba_events_loadoutEvent"] call ACEFUNC(common,cachedCall);
