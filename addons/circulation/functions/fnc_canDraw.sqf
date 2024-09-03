#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka & Slatery
 * Condition function for the blood drawing
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Volume of Blood to remove (in milliliters) <NUMBER>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [medic, medic, 500] call kat_circulation_fnc_canDraw;
 *
 * Public: No
 */

params ["_medic", "_patient", "_volume"];

private _bagItem = format ["ACE_bloodIV_%1", _volume];
private _bloodVolume = GET_BLOOD_VOLUME_LITERS(_patient);
private _volumeChange = _volume/ML_TO_LITERS;
if (((_bloodVolume - _volumeChange) > GVAR(blood_draw_limit))) exitWith {true};
false
