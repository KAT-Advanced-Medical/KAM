#include "..\script_component.hpp"
/*
 * Author: Blue
 * Add pick up action to AED
 *
 * Arguments:
 * 0: AED <OBJECT>
 * 1: AED Classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, 'kat_AED'] call kat_circulation_fnc_placeAED_PickUpAction;
 *
 * Public: No
 */

params ["_AED", "_AEDClassName"];

private _pickUpText = LLSTRING(PickUpAED);

if (_AEDClassName == "kat_X_AED") then {
    _pickUpText = LLSTRING(PickUpAEDX);
};

private _action = ["AED_pickupAction",
_pickUpText,
"",
{
    params ["_AED", "_medic", "_args"];
    _args params ["_AEDClassName"];

    _AED setVariable [QGVAR(DefibrillatorInUse), false, true];

    private _patient = _AED getVariable [QGVAR(Defibrillator_Patient), objNull];


    if !(_patient isEqualTo objNull) then {
        [_medic, _patient, true] call FUNC(Defibrillator_RemovePads);

        [{
            params ["_medic", "_patient", "_AEDClassName"];

            [_medic, _patient, 0, _AEDClassName, [], true] call FUNC(Defibrillator_AttachPads);
        }, [_medic, _patient, _AEDClassName], 0.1] call CBA_fnc_waitAndExecute;
    };

    if (_AEDClassName == "kat_X_AED") then {
        _AED setVariable [QGVAR(AED_X_VitalsMonitor), false, true];
        _medic setVariable [QGVAR(AED_X_VitalsMonitor_Volume), _AED getVariable [QGVAR(AED_X_VitalsMonitor_Volume), false], true];

        private _patientMonitor = _AED getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull];

        if !(_patientMonitor isEqualTo objNull) then {
            private _monitorBodyPart = ALL_BODY_PARTS select ((_patientMonitor getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [objNull, -1, 3]]) select 2);

            [_medic, _patientMonitor, true] call FUNC(AEDX_DisconnectVitalsMonitor);

            [{
                params ["_medic", "_patientMonitor", "_monitorBodyPart"];

                [_medic, _patientMonitor, _monitorBodyPart, 0, [], true] call FUNC(AEDX_ConnectVitalsMonitor);
            }, [_medic, _patientMonitor, _monitorBodyPart], 0.15] call CBA_fnc_waitAndExecute;
        };
    };

    deleteVehicle _AED;

    private _added = (([_medic, _AEDClassName] call ACEFUNC(common,addToInventory)) select 0);

    if !(_added) then {
        [ACELLSTRING(Common,Inventory_Full), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    };
},
{
    params ["_AED", "_unit"];

    [_unit, GVAR(medLvl_AED_Station_Interact)] call ACEFUNC(medical_treatment,isMedic) && !((_AED getVariable [QGVAR(Defibrillator_Patient), objNull]) getVariable [QGVAR(DefibrillatorInUse), false]);
},
{},
[_AEDClassName]
] call ACEFUNC(interact_menu,createAction);
[_AED, 0, ["ACE_MainActions"], _action] call ACEFUNC(interact_menu,addActionToObject);
