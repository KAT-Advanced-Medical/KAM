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
 * [player, 0, 6, 1, false] call kat_vitals_fnc_handleTemperatureFunction;
 *
 * Public: No
 */

params ["_unit", "_altitudeAdjustment", "_bloodVolume", "_deltaT", "_syncValue"];

private _positionTemperature = EGVAR(hypothermia,positionTemperature);
_positionTemperature params ["_lattitude", "_projectedTemperature"];

// Diurnal Width increases as lattitudes increase, generally
private _mapTemperature = _projectedTemperature - ((linearConversion [0, 90, _lattitude, 15, 5, true]) * (linearConversion [0, 1, sunOrMoon, 1, 0, true]));

private _warmingImpact = (_unit getVariable [QEGVAR(hypothermia,warmingImpact), 0]) / ML_TO_LITERS; 
private _pointTemperature = -3.5 * (0.95 ^ _mapTemperature + _altitudeAdjustment);
private _currentTemperature = DEFAULT_TEMPERATURE min (((-0.3392 * (_bloodVolume^2)) + (6.00357 * _bloodVolume) + (13.3 + _warmingImpact - (_pointTemperature / 20))));

_unit setVariable [QEGVAR(hypothermia,unitTemperature), _currentTemperature, _syncValue];

_currentTemperature