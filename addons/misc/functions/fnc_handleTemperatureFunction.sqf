#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Update the temperature of the patient
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Temperature Adjustments <NUMBER>
 * 2: Blood Volume <NUMBER>
 * 3: Time since last update <NUMBER>
 * 4: Sync value? <BOOL>
 *
 * ReturnValue:
 * Current Temperature <NUMBER>
 *
 * Example:
 * [player, 0, 6, 1, false] call kat_misc_fnc_handleTemperatureFunction;
 *
 * Public: No
 */

params ["_unit", "_altitudeAdjustment", "_bloodVolume", "_deltaT", "_syncValue"];

// 0 is Map Position in Lattitude, 1 is Projected High Temperature for map position at said Lattitude
private _positionTemperature = EGVAR(hypothermia,positionTemperature);

// Diurnal Width increases as lattitudes increase, generally
private _mapTemperature = (_positionTemperature select 1) - ((linearConversion[0,90, (_positionTemperature select 0) ,15,5, true]) * (linearConversion[0,1, sunOrMoon ,1,0, true]));

private _warmingImpact = (_unit getVariable [QEGVAR(hypothermia,warmingImpact), 0]) / ML_TO_LITERS; 
private _currentTemperature = DEFAULT_TEMPERATURE min ((-3.5 * (0.95 ^ _mapTemperature + _altitudeAdjustment) + (((_bloodVolume + 0.01) / 6) * (60 + (_warmingImpact * 60)))));

_unit setVariable [QEGVAR(hypothermia,unitTemperature), _currentTemperature, _syncValue];

_currentTemperature