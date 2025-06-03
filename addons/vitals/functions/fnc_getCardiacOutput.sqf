#include "..\script_component.hpp"
/*
 * Author: Glowbal, kymckay
 * Get the cardiac output from the Heart, based on current Heart Rate and Blood Volume.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * Current cardiac output (liter per second) <NUMBER>
 *
 * Example:
 * [player] call ace_medical_status_fnc_getCardiacOutput
 *
 * Public: No
 */

params ["_unit"];
private _heartRate = GET_HEART_RATE(_unit);
private _cardiacOutput = ([_unit] call FUNC(getStrokeVolume)) * _heartRate / 60;
TRACE_1("cardicaOutput",_cardiacOutput);
0 max _cardiacOutput