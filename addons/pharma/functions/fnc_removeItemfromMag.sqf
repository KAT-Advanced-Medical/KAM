#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a 'bullet' from a magazine.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Magazine <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 'kat_Painkiller'] call kat_circulation_fnc_removeItemfromMag;
 *
 * Public: No
 */

params ["_player", "_mag"];

private _matchesMags = magazinesAmmo _player select {_x select 0 == _mag};
_player removeMagazineGlobal _mag;
private _oldMag = _matchesMags select 0;

if ((_oldMag select 1) > 1) then {
    _player addMagazine [_mag, (_oldMag select 1) - 1];
} else {
    [format [LLSTRING(Pain_empty), getText (configFile >> "CfgMagazines" >> _mag >> "displayName")], 2.5, _player] call ACEFUNC(common,displayTextStructured);
};

