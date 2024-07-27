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

private _mapPosition = if (count([worldName] call ACEFUNC(common,getMapData)) != 0) then { abs([worldName] call ACEFUNC(common,getMapData) select 0) } else { 25 };
// Decrease of 0.7C for each degree of lattitude gained. Middle lattitudes between 20N and 20S have average temperatures of 27C, everything decreases from there.
private _mapHighTemperature = if ((_mapPosition - 20) > 0) then { 27 + (-0.7 * (_mapPosition - 27)) } else { 27 };

// Diurnal Width increases as lattitudes increase, generally
private _mapTemperature = _mapHighTemperature - ((linearConversion[0,90, _mapPosition ,15,5, true]) * (linearConversion[0,1, sunOrMoon ,1,0, true]));

private _warmingImpact = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0]; // LOOK HERE
private _currentTemperature = DEFAULT_TEMPERATURE min ((-3.5 * (0.95 ^ _mapTemperature + _altitudeAdjustment) + (((_bloodVolume + 0.01) / 6) * (60 + (_warmingImpact * 60)))));

_unit setVariable [QEGVAR(hypothermia,temperature), _currentTemperature, _syncValue];

_currentTemperature