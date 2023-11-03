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

private _AED = ([_AEDClassName,"Item"] joinString "") createVehicle (getPosASL _unit);

// startCarry
if (stance _unit != "STAND") then {
    _AED attachTo [_unit, [0,1.1,1]];
    [_unit, _AED] call ACEFUNC(dragging,dropObject_carry);
} else {
    _unit setVariable [QACEGVAR(dragging,isCarrying), true, true];
    [ACEFUNC(dragging,startCarryPFH), 0.2, [_unit, _AED, (CBA_missionTime + 1)]] call CBA_fnc_addPerFrameHandler;
};

private _pickUpText = LLSTRING(PickUpAED);

private _patient = _unit getVariable [QGVAR(MedicDefibrillator_Patient), objNull];

if !(_patient isEqualTo objNull) then {
    [_unit, _patient, true] call FUNC(Defibrillator_RemovePads);

    [{
        params ["_unit", "_patient", "_AEDClassName", "_AED"];

        [_unit, _patient, 1, _AEDClassName, [_AED], true] call FUNC(Defibrillator_AttachPads);
    }, [_unit, _patient, _AEDClassName, _AED], 0.1] call CBA_fnc_waitAndExecute; 
};

if (_AEDClassName == "kat_X_AED") then {
    _pickUpText = LLSTRING(PickUpAEDX);

    private _monitorPatient = _unit getVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), objNull];

    if !(_monitorPatient isEqualTo objNull) then {
        private _monitorBodyPart = ALL_BODY_PARTS select ((_monitorPatient getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [objNull, -1, 3]]) select 2);

        [_unit, _monitorPatient, true] call FUNC(AEDX_DisconnectVitalsMonitor);
        _AED setVariable [QGVAR(AED_X_VitalsMonitor_Volume), (_monitorPatient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]), true];
        
        [{
            params ["_unit", "_monitorPatient", "_AEDClassName", "_AED", "_monitorBodyPart"];
            
            [_unit, _monitorPatient, _monitorBodyPart, 1, [_AED], true] call FUNC(AEDX_ConnectVitalsMonitor);
        }, [_unit, _monitorPatient, _AEDClassName, _AED, _monitorBodyPart], 0.15] call CBA_fnc_waitAndExecute; 
    } else {
        if !(_patient isEqualTo objNull) then {
            _AED setVariable [QGVAR(AED_X_VitalsMonitor_Volume), (_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]), true];
        } else {
            _AED setVariable [QGVAR(AED_X_VitalsMonitor_Volume), (_unit getVariable [QGVAR(AED_X_VitalsMonitor_Volume), false]), true];
        };
    };
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
    if (_medic canAddItemToUniform _AEDClassName || _medic canAddItemToVest _AEDClassName || _medic canAddItemToBackpack _AEDClassName) then {
        _medic addItem _AEDClassName;
    } else {
        private _droppedAED = createVehicle ["Weapon_Empty", getPosATL _medic, [], 0, "CAN_COLLIDE"];
        _droppedAED addItemCargo [_AEDClassName, 1];
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