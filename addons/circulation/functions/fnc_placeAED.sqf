#include "..\script_component.hpp"
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

// startCarry
if (stance _unit == "STAND") then {
    [_unit, _AED] call ACEFUNC(dragging,startCarry);
} else {
    _AED attachTo [_unit, [0,1.1,0.1]];
    _unit setVariable [QACEGVAR(dragging,isCarrying), true, true];
    _unit setVariable [QACEGVAR(dragging,carriedObject), _AED, true];
    [_unit, _AED] call ACEFUNC(dragging,dropObject_carry);
};

private _patient = _unit getVariable [QGVAR(MedicDefibrillator_Patient), objNull];

if !(_patient isEqualTo objNull) then {
    [_unit, _patient, true] call FUNC(Defibrillator_RemovePads);

    [{
        params ["_unit", "_patient", "_AEDClassName", "_AED"];

        [_unit, _patient, 1, _AEDClassName, [_AED], true] call FUNC(Defibrillator_AttachPads);
    }, [_unit, _patient, _AEDClassName, _AED], 0.1] call CBA_fnc_waitAndExecute;
};

if (_AEDClassName == "kat_X_AED") then {
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

[QGVAR(placeAED_initAction), [_AED, _AEDClassName]] call CBA_fnc_globalEvent;