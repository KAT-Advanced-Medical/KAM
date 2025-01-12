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

params ["_this"];

if !(GVAR(enableTicketConversion)) exitWith { false };
if !(_this getVariable [QGVAR(currentConverted), false]) exitWith { false };

if !(_this call ACEFUNC(medical_treatment,isInMedicalFacility)) exitWith { false };
if !([_this] call FUNC(conversionCondition)) exitWith { false };

if (GVAR(forceVehicleConversion) && ((isNull objectParent _this) || !((objectParent _this) in GVAR(convertVehicles)))) exitWith { false };

true