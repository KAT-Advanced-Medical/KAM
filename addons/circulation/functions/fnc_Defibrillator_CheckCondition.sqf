#include "..\script_component.hpp"
/*
 * Author: Blue
 * Check if defibrillator can be used on patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Allow while in use <BOOL>
 *
 * Return Value:
 * Can be used <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_Defibrillator_CheckCondition;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_allowInUse", false]];

private _defibProvider = _patient getVariable [QGVAR(Defibrillator_Provider), objNull];

if (_defibProvider isEqualTo objNull) exitWith {false};

private _condition = false;

switch (_defibProvider select 1) do {
    case 1: {
        _condition = (_patient distance (_defibProvider select 0)) <= GVAR(Defibrillator_DistanceLimit);
    };
    case 2: {
        _condition = !(isNull objectParent _patient) && (objectParent _patient isEqualTo objectParent _medic) && !((itemCargo objectParent _patient) findIf {_x isEqualTo (_defibProvider select 2)} isEqualTo -1);
    };
    default {
        _condition = [_medic, _medic, [(_defibProvider select 2)]] call ACEFUNC(medical_treatment,hasItem);
    };
};

_condition && (_allowInUse || !(_patient getVariable [QGVAR(DefibrillatorInUse), false])) && _patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && {["",_patient] call ACEFUNC(medical_treatment,canCPR)};
