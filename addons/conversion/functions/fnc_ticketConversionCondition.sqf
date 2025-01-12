#include "..\script_component.hpp"
/*
 * Author: mharis001
 * Condition for going into cardiac arrest upon receiving a fatal injury.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_statemachine_fnc_conditionSecondChance
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