#include "script_component.hpp"
/*
 * Author: Blue
 * Add carry load ace actions to vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle] call kat_misc_fnc_addVehicleCarryLoadActions;
 *
 * Public: No
 */

params ["_vehicle"];

private _type = (typeOf _vehicle);

fnc_getFreeSeats = {
    params ["_vehicle"];
    
    // From ace_common_fnc_nearestVehiclesFreeSeat
    private _canSitInCargo = (getNumber (configOf _vehicle >> "ejectDeadCargo")) == 0;
    
    private _emptySeats = [];

    private _seats = fullCrew [_vehicle, "", true];

    {
        _x params ["_body", "_role", "_cargoIndex"];

        if((isNull _body) && {_role != "DRIVER"} && {_canSitInCargo || {_cargoIndex == -1}}) then {
            _emptySeats pushBack _cargoIndex;
        };
    } forEach _seats;

    _emptySeats;
};

private _action = [format ["KAT_MainActions_%1", _type],
ACELLSTRING(Interaction,MainAction),
"",
{},
{!((_this select 1) getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull) && {(_this select 1) getVariable [QACEGVAR(dragging,carriedObject), objNull] isKindOf 'CAManBase'}},
{
    private _loadAction = [];
    _loadAction pushBack [
        [format ["KAT_LoadCarriedPatient"],
        "Load Carried Patient",
        QACEPATHTOF(medical_gui,ui\cross.paa),
        {[((_this select 2) select 1), (((_this select 2) select 1) getVariable [QACEGVAR(dragging,carriedObject), objNull]), ((_this select 2) select 0)] call ACEFUNC(medical_treatment,loadUnit)},
        {!(([((_this select 2) select 0)] call fnc_getFreeSeats) isEqualTo [])},
        {},
        [(_this select 0),(_this select 1)]
        ] call ACEFUNC(interact_menu,createAction),
        [],
        (_this select 1)
    ];

    _loadAction;
},
[],
{call ACEFUNC(interaction,getVehiclePos)}, 4] call ACEFUNC(interact_menu,createAction);

[_type, 0, [], _action] call ACEFUNC(interact_menu,addActionToClass);