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
 * _allowedToDraw = [medic, medic, 500] call kat_circulation_fnc_canDraw;
 *
 * Public: No
 */

params ["_medic","_patient","_volume"];

/**
 * @Slatery - if you're using params, you don't need to use _this select x. It is wasted processing
 */
//_medic = _this select 0;
//_patient = _this select 1;


/**
 * @Slatery - Minimum blood volume changed from 2L to 5L. Healthy patients should not have more than ~500ml drawn, however this isn't really translatable in game too well since this is meant to be in combat, so a buffer of 1L total loss instead
 * Changing to compare what the volume would be post draw to make sure that you don't accidentally kill the patient you're drawing from
 */
private _bagItem = format ["ACE_bloodIV_%1", _volume];
private _bloodVolume = (_patient getVariable ["ace_medical_bloodVolume", 6.0]);
private _volumeChange = _volume/1000;
private _canAddItem = ((_medic canAddItemToUniform _bagItem) || (_medic canAddItemToVest _bagItem) || (_medic canAddItemToBackpack _bagItem)); // make sure the blood can actually be added to the medic, so you don't just lose blood
if (((_bloodVolume - _volumeChange) > GVAR(blood_draw_limit)) && _canAddItem) exitWith {true};
false