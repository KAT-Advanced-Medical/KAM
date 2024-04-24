#include "..\script_component.hpp"
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

private _fnc_getFreeSeats = {
    params ["_vehicle"];

    // From ace_common_fnc_nearestVehiclesFreeSeat
    private _canSitInCargo = (getNumber (configOf _vehicle >> "ejectDeadCargo")) == 0;

    private _seatIndex = (fullCrew [_vehicle, "", true]) findIf {
        _x params ["_body", "_role", "_cargoIndex"];

        (isNull _body) && {_role != "DRIVER"} && {_canSitInCargo || {_cargoIndex == -1}}
    };

    _seatIndex;
};

private _action = [format ["KAT_MainActions_%1", _type],
ACELLSTRING(Interaction,MainAction),
"",
{},
{
    params ["_vehicle", "_medic", "_args"];

    !(_medic getVariable [QACEGVAR(dragging,carriedObject), objNull] isEqualTo objNull) && {_medic getVariable [QACEGVAR(dragging,carriedObject), objNull] isKindOf 'CAManBase'}
},
{
    params ["_vehicle", "_medic", "_args"];
    _args params ["_type", "_fnc_getFreeSeats"];

    private _loadAction = [];
    _loadAction pushBack [
        [format ["KAT_LoadCarriedPatient_%1", _type],
        ACELLSTRING(medical_gui,LoadPatient),
        QACEPATHTOF(medical_gui,ui\cross.paa),
        {
            params ["", "", "_args"];
            _args params ["_vehicle", "_medic", "_fnc_getFreeSeats"];

            [_medic, (_medic getVariable [QACEGVAR(dragging,carriedObject), objNull]), _vehicle] call ACEFUNC(medical_treatment,loadUnit);
        },
        {
            params ["", "", "_args"];
            _args params ["_vehicle", "_medic", "_fnc_getFreeSeats"];

            ([_vehicle] call _fnc_getFreeSeats) != -1;
        },
        {},
        [_vehicle, _medic, _fnc_getFreeSeats]
        ] call ACEFUNC(interact_menu,createAction),
        [],
        (_this select 1)
    ];

    _loadAction;
},
[_type, _fnc_getFreeSeats],
{call ACEFUNC(interaction,getVehiclePos)}, 4] call ACEFUNC(interact_menu,createAction);

[_type, 0, [], _action] call ACEFUNC(interact_menu,addActionToClass);
