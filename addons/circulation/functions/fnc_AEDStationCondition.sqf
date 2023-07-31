#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if AED Station can be performed on the patient.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Can use AED <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_AEDStationCondition
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _canCPR = ["",_patient] call ACEFUNC(medical_treatment,canCPR);

!(nearestObjects [position _patient, ["kat_AEDItem"], GVAR(distanceLimit_AEDX)] findIf {typeOf _x in ["kat_AEDItem","Land_Defibrillator_F"]} isEqualTo -1) && {_canCPR};