#include "..\script_component.hpp"
/*
 * Author: Blue
 * Add carry and unload ace actions to vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Ace actions <ARRAY>
 *
 * Example:
 * [vehicle] call kat_misc_fnc_addVehicleUnloadCarryPatientActions;
 *
 * Public: No
 */

params ["_vehicle"];

private _type = (typeOf _vehicle);

private _vehicleSeats = fullCrew [_vehicle, ""];

private _actions = [];

{
    private _unit = _x select 0;
    if (IS_UNCONSCIOUS(_unit)) then {
        _actions pushBack [[format ["KAT_UnloadAndCarryPatient_%1", _unit],
        [_unit, true] call ACEFUNC(common,getName),
        "",
        {
            params ["_vehicle", "_medic", "_args"];
            _args params ["_patient"];

            [_medic, _patient] call FUNC(unloadAndCarryPatient);
        },
        {
            true;
        },
        {},
        [_unit]
        ] call ACEFUNC(interact_menu,createAction),[], _medic];
    };
} forEach (_vehicleSeats);

_actions;
