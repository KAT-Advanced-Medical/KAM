/*
 * Author: Battlekeeper, modified by YetheSamartaka
 * Condition function for the blood drawing
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, medic] call kat_circulation_fnc_canDraw;
 *
 * Public: No
 */

params ["_medic","_patient"];

_medic = _this select 0;
_patient = _this select 1;
if ((_patient getVariable ["ace_medical_bloodVolume", 6.0]) > 2.0) exitWith {true};
false