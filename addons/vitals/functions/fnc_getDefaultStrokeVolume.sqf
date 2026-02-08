#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Calculate stroke volume of a single heart beat.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 *    stroke volume (ml) <NUMBER>
 *
 * Example:
 * [player] call kat_vitals_fnc_getStrokeVolume
 *
 * Public: No
 */

params ["_unit"];
private _defaultCVP = 6;
private _strokeVolume = 0.095;

private _fillPortion = 1 - exp (-3 * 1);
private _edv = _fillPortion * _defaultCVP * 0.25 * _strokeVolume;

private _esv = (0.5 * _strokeVolume);

private _strokeVol = (_edv - _esv) max 0;

_strokeVol
