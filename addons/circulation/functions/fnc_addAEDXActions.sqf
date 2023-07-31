#include "script_component.hpp"
/*
 * Author: Blue
 * Gets ACE actions for nearby units next to AEDX
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: AED <OBJECT>
 *
 * Return Value:
 * ACE actions <ARRAY>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_addAEDActions
 *
 * Public: No
 */

params ["_medic", "_AED"];

private _actions = [];

{
    if !(_x isEqualTo _medic) then {
        _actions pushBack [[format ["AEDX_ConnectMonitor_%1", _x],
        [_x, true] call ACEFUNC(common,getName),
        "",
        {
            params ["_medic", "","_args"];
            _args params ["_patient","_AED"];

            [_medic, _patient, "body", "AttachAEDXPlaced"] call ACEFUNC(medical_treatment,treatment);
        },
        {
            true;
        },
        {},
        [_x,_AED]
        ] call ACEFUNC(interact_menu,createAction),[], _medic];
    };
} forEach (_AED nearEntities ["Man", GVAR(distanceLimit_AEDX)]);

_actions;