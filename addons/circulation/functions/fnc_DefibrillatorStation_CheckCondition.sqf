#include "script_component.hpp"
/*
 * Author: Blue
 * Checks if placed defibrillator can be used.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Defibrillator classname <STRING>
 *
 * Return Value:
 * Can use defibrillator <BOOL>
 *
 * Example:
 * [player, cursorObject,'kat_AEDItem'] call kat_circulation_fnc_DefibrillatorStation_CheckCondition
 *
 * Public: No
 */

params ["_medic", "_patient", ["_defibClassname","kat_AEDItem"]];

private _nearObjects = nearestObjects [position _patient, ["kat_AEDItem"], GVAR(Defibrillator_DistanceLimit)];
private _index = _nearObjects findIf {typeOf _x isEqualTo _defibClassname};

if (_index isEqualTo -1) exitWith {false};

private _defib = _nearObjects select _index;

!(_patient getVariable [QGVAR(DefibrillatorPads_Connected),false]) && (_defib getVariable [QGVAR(Defibrillator_Patient),objNull] isEqualTo objNull) && !(_patient getVariable [QEGVAR(airway,recovery), false]) && {["",_patient] call ACEFUNC(medical_treatment,canCPR)};