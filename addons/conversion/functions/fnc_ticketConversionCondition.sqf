#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if patient can be converted into respawn tickets
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_ticketConversionCondition
 *
 * Public: No
 */

params ["_patient"];

if !(GVAR(enableTicketConversion)) exitWith { false };
if !(_patient getVariable [QGVAR(currentConverted), false]) exitWith { false };

if !(_patient call ACEFUNC(medical_treatment,isInMedicalFacility)) exitWith { 
    systemChat "cantConvertFacility";
    false };
if !(_patient call EFUNC(vitals,hasStableVitals)) exitWith { 
    systemChat "cantConvertVitals";
    false };

if (GVAR(forceVehicleConversion) && ((isNull objectParent _patient) || !((objectParent _patient) in GVAR(convertVehicles)))) exitWith { 
    systemChat "cantConvertVehicle";
    false };
systemChat "canConvert";
true