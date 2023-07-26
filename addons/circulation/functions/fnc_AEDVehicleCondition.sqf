#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski, Blue
 * Checks if vehicle AED can be used on the patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: AED classname <STRING>
 *
 * Return Value:
 * Can use AED
 *
 * Example:
 * [cursorObject, "kat_X_AED"] call kat_circulation_fnc_AEDVehicleCondition;
 *
 * Public: No
 */

params ["_patient", "_AEDClassname"];

private _vehicle = objectParent _patient;

if (isNull _vehicle) exitWith {false};

if((itemCargo _vehicle) findIf {_x isEqualTo _AEDClassname} isEqualTo -1) exitWith {false};

["",_patient] call ACEFUNC(medical_treatment,canCPR);