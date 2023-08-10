#include "script_component.hpp"
/*
 * Author: Blue
 * Gets ACE actions for units next to placed defibrillator
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Defibrillator <OBJECT>
 * 2: Action type <INT>
 *
 * Return Value:
 * ACE actions <ARRAY>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_addDefibrillatorActions;
 *
 * Public: No
 */

params ["_medic", "_defibObject", ["_type", 0]];

private _actions = [];

switch (_type) do { // AED-X pads
    case 1: {
        {
            if !(_x isEqualTo _medic) then {
                _actions pushBack [[format ["AEDX_PlacePads_%1", _x],
                [_x, true] call ACEFUNC(common,getName),
                "",
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDXStationPlacePads", [_defibObject]] call FUNC(treatment);
                },
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDXStationPlacePads", [_defibObject]] call FUNC(canTreat);
                },
                {},
                [_x, _defibObject]
                ] call ACEFUNC(interact_menu,createAction),[], _medic];
            };
        } forEach (_defibObject nearEntities ["Man", GVAR(Defibrillator_DistanceLimit)]);
    };
    /*case 2: { // AED-X vitals monitoring
        {
            if !(_x isEqualTo _medic) then {
                _actions pushBack [[format ["AEDX_ConnectVitalsMonitor_%1", _x],
                [_x, true] call ACEFUNC(common,getName),
                "",
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDXStationConnectVitalsMonitor"] call ACEFUNC(medical_treatment,treatment);
                },
                {
                    true;
                },
                {},
                [_x,_defibObject]
                ] call ACEFUNC(interact_menu,createAction),[], _medic];
            };
        } forEach (_defibObject nearEntities ["Man", GVAR(Defibrillator_DistanceLimit)]);
    };*/
    default { // AED pads
        {
            if !(_x isEqualTo _medic) then {
                _actions pushBack [[format ["AED_PlacePads_%1", _x],
                [_x, true] call ACEFUNC(common,getName),
                "",
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDStationPlacePads", [_defibObject]] call FUNC(treatment);
                },
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDStationPlacePads", [_defibObject]] call FUNC(canTreat);
                },
                {},
                [_x, _defibObject]
                ] call ACEFUNC(interact_menu,createAction),[], _medic];
            };
        } forEach (_defibObject nearEntities ["Man", GVAR(Defibrillator_DistanceLimit)]);
    };
};

_actions;