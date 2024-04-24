#include "..\script_component.hpp"
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
 * [player, cursorObject, 0] call kat_circulation_fnc_addDefibrillatorActions;
 *
 * Public: No
 */

params ["_medic", "_defibObject", ["_type", 0]];

private _actions = [];

switch (_type) do { // AED-X pads
    case 1: {
        {
            if !(_x isEqualTo _medic) then {
                _actions pushBack [[format ["KAT_AEDX_PlacePads_%1", _x],
                [_x, true] call ACEFUNC(common,getName),
                "",
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDXStationPlacePads", [_defibObject]] call EFUNC(misc,treatment);
                },
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDXStationPlacePads", [_defibObject]] call ACEFUNC(medical_treatment,canTreat);
                },
                {},
                [_x, _defibObject]
                ] call ACEFUNC(interact_menu,createAction),[], _medic];
            };
        } forEach (_defibObject nearEntities ["Man", GVAR(Defibrillator_DistanceLimit)]);
    };
    case 2: { // AED-X vitals monitoring (to)
        {
            if !(_x isEqualTo _medic) then {
                _actions pushBack [[format ["KAT_AEDX_ConnectVitalsMonitorTo_%1", _x],
                [_x, true] call ACEFUNC(common,getName),
                "",
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "rightarm", "AEDXStationConnectVitalsMonitor", [_defibObject]] call EFUNC(misc,treatment);
                },
                {
                    [_medic, _patient, "rightarm", "AEDXStationConnectVitalsMonitor", [_defibObject]] call ACEFUNC(medical_treatment,canTreat);
                },
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    private _loadAction = [
                    [
                        [format ["KAT_AEDX_ConnectVitalsMonitorTo_LeftArm_%1", _patient],
                        "Left Arm",
                        "",
                        {
                            params ["_medic", "", "_args"];
                            _args params ["_patient", "_defibObject"];

                            [_medic, _patient, "leftarm", "AEDXStationConnectVitalsMonitor", [_defibObject]] call EFUNC(misc,treatment);
                        },
                        {
                            true
                        },
                        {},
                        [_patient, _defibObject]
                        ] call ACEFUNC(interact_menu,createAction),
                        [],
                        (_this select 1)
                    ],
                    [
                        [format ["KAT_AEDX_ConnectVitalsMonitorTo_RightArm_%1", _patient],
                        "Right Arm",
                        "",
                        {
                            params ["_medic", "", "_args"];
                            _args params ["_patient", "_defibObject"];

                            [_medic, _patient, "rightarm", "AEDXStationConnectVitalsMonitor", [_defibObject]] call EFUNC(misc,treatment);
                        },
                        {
                            true
                        },
                        {},
                        [_patient, _defibObject]
                        ] call ACEFUNC(interact_menu,createAction),
                        [],
                        (_this select 1)
                    ]
                    ];

                    _loadAction;
                },
                [_x,_defibObject]
                ] call ACEFUNC(interact_menu,createAction),[], _medic];
            };
        } forEach (_defibObject nearEntities ["Man", GVAR(Defibrillator_DistanceLimit)]);
    };
    case 3: { // AED-X vitals monitoring
        private _patient = _defibObject getVariable [QGVAR(Defibrillator_Patient), objNull];

        _actions pushBack [[format ["KAT_AEDX_ConnectVitalsMonitor_LeftArm_%1", _patient],
        "Left Arm",
        "",
        {
            params ["_medic", "", "_args"];
            _args params ["_patient", "_defibObject"];

            [_medic, _patient, "leftarm", "AEDXStationConnectVitalsMonitor", [_defibObject]] call EFUNC(misc,treatment);
        },
        {
            true
        },
        {},
        [_patient,_defibObject]
        ] call ACEFUNC(interact_menu,createAction),[], _medic];
        _actions pushBack [[format ["KAT_AEDX_ConnectVitalsMonitor_RightArm_%1", _patient],
        "Right Arm",
        "",
        {
            params ["_medic", "", "_args"];
            _args params ["_patient", "_defibObject"];

            [_medic, _patient, "rightarm", "AEDXStationConnectVitalsMonitor", [_defibObject]] call EFUNC(misc,treatment);
        },
        {
            true
        },
        {},
        [_patient, _defibObject]
        ] call ACEFUNC(interact_menu,createAction),[], _medic];
    };
    default { // AED pads
        {
            if !(_x isEqualTo _medic) then {
                _actions pushBack [[format ["KAT_AED_PlacePads_%1", _x],
                [_x, true] call ACEFUNC(common,getName),
                "",
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDStationPlacePads", [_defibObject]] call EFUNC(misc,treatment);
                },
                {
                    params ["_medic", "", "_args"];
                    _args params ["_patient", "_defibObject"];

                    [_medic, _patient, "body", "AEDStationPlacePads", [_defibObject]] call ACEFUNC(medical_treatment,canTreat);
                },
                {},
                [_x, _defibObject]
                ] call ACEFUNC(interact_menu,createAction),[], _medic];
            };
        } forEach (_defibObject nearEntities ["Man", GVAR(Defibrillator_DistanceLimit)]);
    };
};

_actions;
