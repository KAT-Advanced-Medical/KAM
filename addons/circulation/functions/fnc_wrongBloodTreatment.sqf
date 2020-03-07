#include "script_component.hpp"
/*
 * Author: Tomcat
 * Treats wrong given Blood with Painkillers
 * And unit class.
 *
 * Arguments:
 * 0: Target/Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_wrongBloodTreatment
 *
 * Public: No
 */
params ["_patient"];

_wrongBloodHRAdjust = _patient getVariable ["KAT_medical_wrongBloodAdjust", 50];
_hradjust = +(_wrongBloodHRAdjust);

[_patient, "Painkiller", 150, 300, _hradjust, 0, -10] call ace_medical_status_fnc_addMedicationAdjustment;

_patient setVariable ["KAT_medical_wrongBloodAdjust", 50, true];
