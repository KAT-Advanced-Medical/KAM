#include "..\script_component.hpp"
/*
 * Author: Blue
 * Checks if AED pads can be attached to the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: AED-X origin <INT>
 *   0: Medic
 *   1: Placed
 *   2: Vehicle
 * 3: AED classname <STRING>
 * 4: Extra Arguments <ARRAY>
 *   0: Placed AED <OBJECT>
 *
 * Return Value:
 * Can attach pads <BOOL>
 *
 * Example:
 * [player, cursorObject, 0, []] call kat_circulation_fnc_Defibrillator_Pads_CheckCondition;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_AEDOrigin", 0], ["_AEDClassname", "kat_AED"], ["_extraArgs", []]];
_extraArgs params [["_placedAED", objNull]];

private _condition = false;
private _exit = false;

switch (_AEDOrigin) do {
    case 1: {
        if (_placedAED isEqualTo objNull) then {
            private _nearbyObjects = nearestObjects [position _patient, ["kat_AEDItem"], GVAR(Defibrillator_DistanceLimit)];
            if ((_nearbyObjects findIf {typeOf _x isEqualTo (_AEDClassname + "Item")}) isEqualTo -1) exitWith {_exit = true};
            _placedAED = _nearbyObjects select 0;
        };

        _condition = ((_patient distance _placedAED) < GVAR(Defibrillator_DistanceLimit)) && (_placedAED getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull] in [objNull, _patient] || ((_patient getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [objNull, -1, -1]]) select 0) isEqualTo _placedAED);
    };
    case 2: {
        if !(isNull objectParent _patient) then {
            _condition = !((itemCargo objectParent _patient) findIf {_x isEqualTo _AEDClassname} isEqualTo -1);
        };
    };
    default {
        _condition = !(_medic getVariable [QGVAR(MedicDefibrillatorInUse), false]) && (_medic getVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), objNull] in [objNull, _patient] || ((_patient getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [objNull, -1, -1]]) select 0) isEqualTo _medic);
    };
};

if (_exit) exitWith {false};

_condition && !(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) && !(_patient getVariable [QEGVAR(airway,recovery), false]) && (objectParent _patient isEqualTo objectParent _medic) && (["",_patient] call ACEFUNC(medical_treatment,canCPR) || GVAR(AED_duringCpr));