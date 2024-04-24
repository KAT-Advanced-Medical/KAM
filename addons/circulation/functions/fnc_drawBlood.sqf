#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka
 * Refactored by Slatery
 * Handles drawing of blood into a bag
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Volume of Blood to remove (in milliliters) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, patient, 500] call kat_circulation_fnc_drawBlood;
 *
 * Public: No
 */

params ["_medic", "_patient", "_volume"];

private _modStr = "ACE_";
private _bloodtypeStr = "";
private _bagVolumeStr = format ["_%1",_volume];
private _volumeChange = _volume/1000;
private _bloodVolume = (_patient getVariable [QACEGVAR(medical,bloodVolume), 6.0]);
if (GVAR(bloodGroups)) then {
    _modStr = "kat_";
    _bloodtype = [_patient] call FUNC(bloodType);
    _bloodtypeStr = format ["_%1",_bloodtype];
};
private _itemStr = format ["%1bloodIV%2%3",_modStr,_bloodtypeStr,_bagVolumeStr];
[_medic, _itemStr] call ACEFUNC(common,addToInventory);
_patient setVariable [QACEGVAR(medical,bloodVolume), _bloodVolume - _volumeChange,true];
