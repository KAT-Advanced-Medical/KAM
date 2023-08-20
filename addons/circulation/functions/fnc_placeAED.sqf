#include "script_component.hpp"
/*
 * Author: Tomcat, Blue
 * Place the AED/X in front of unit
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: AED Classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 'kat_AED'] call kat_circulation_fnc_placeAED;
 *
 * Public: No
 */

params ["_unit", "_AEDClassName"];

_unit removeItem _AEDClassName;

private _AED = ([_AEDClassName,"Item"] joinString "") createVehicle (position _unit);

[_AED, true] call ACEFUNC(dragging,setDraggable);
[_AED, true] call ACEFUNC(dragging,setCarryable);

[_unit, _AED] call ACEFUNC(dragging,carryObject);

private _pickUpText = LLSTRING(PickUpAED);

if (_AEDClassName == "kat_X_AED") then {
    _AED setVariable [QGVAR(AED_X_VitalsMonitor_Volume), _unit getVariable [QGVAR(AED_X_VitalsMonitor_Volume), false], true];
    _pickUpText = LLSTRING(PickUpAEDX);

    private _patient = _unit getVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), objNull];

    if !(_patient isEqualTo objNull) then {
        [_unit, _patient, true] call FUNC(AEDX_DisconnectVitalsMonitor);

        [{
            params ["_unit", "_patient", "_AEDClassName", "_AED"];

            [_unit, _patient, 1, [_AED], true] call FUNC(AEDX_ConnectVitalsMonitor);
        }, [_unit, _patient, _AEDClassName, _AED], 0.1] call CBA_fnc_waitAndExecute; 
    };
};

private _patient = _unit getVariable [QGVAR(MedicDefibrillator_Patient), objNull];

if !(_patient isEqualTo objNull) then {
    [_unit, _patient, true] call FUNC(Defibrillator_RemovePads);

    [{
        params ["_unit", "_patient", "_AEDClassName", "_AED"];

        [_unit, _patient, 1, _AEDClassName, [_AED], true] call FUNC(Defibrillator_AttachPads);
    }, [_unit, _patient, _AEDClassName, _AED], 0.1] call CBA_fnc_waitAndExecute; 
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
            [_medic, _patientMonitor, true] call FUNC(AEDX_DisconnectVitalsMonitor);

            [{
                params ["_medic", "_patientMonitor"];

                [_medic, _patientMonitor, 0, [], true] call FUNC(AEDX_ConnectVitalsMonitor);
            }, [_medic, _patientMonitor], 0.1] call CBA_fnc_waitAndExecute;  
        };
    };

    deleteVehicle _AED;
    _medic addItem _AEDClassName;
},
{
    params ["_AED", "_unit"];
    [_unit, GVAR(medLvl_AED_Station_Interact)] call ACEFUNC(medical_treatment,isMedic)
},
{},
[_AEDClassName]
] call ACEFUNC(interact_menu,createAction);
[_AED, 0, ["ACE_MainActions"], _action] call ACEFUNC(interact_menu,addActionToObject);