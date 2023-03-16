#include "script_component.hpp"
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

params ["_medic","_patient","_volume"];

private _bagItem = format ["ACE_bloodIV_%1", _volume];
private _bloodVolume = (_patient getVariable [QACEGVAR(medical,bloodVolume), 6.0]);
private _volumeChange = _volume/1000;
private _canAddItem = ((_medic canAddItemToUniform _bagItem) || (_medic canAddItemToVest _bagItem) || (_medic canAddItemToBackpack _bagItem)); // make sure the blood can actually be added to the medic, so you don't just lose blood
if (((_bloodVolume - _volumeChange) > GVAR(blood_draw_limit)) && _canAddItem) exitWith {true};
false