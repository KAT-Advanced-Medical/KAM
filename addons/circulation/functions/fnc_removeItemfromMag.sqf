#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a 'bullet' from a magazine.
 *
 * Arguments:
 * 0: Magazine <STRING>
 * 1: Medic <OBJECT>
 * 2: Patient <OBJECT>
 * 3: Selection <STRING>
 * 4: Classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ['kat_Painkiller', player, cursorTarget, 'head', 'Painkillers'] call kat_circulation_fnc_removeItemfromMag;
 *
 * Public: No
 */

params ["_mag", "_player", "_target", "_selectionName", "_className"];

private _matchesMags = magazinesAmmo _player select {_x select 0 == _mag};
_player removeMagazineGlobal _mag;
private _oldMag = _matchesMags select 0;

if ((_oldMag select 1) > 1) then {
    _player addMagazine [_mag, (_oldMag select 1) - 1];
} else {
    [format [localize LSTRING(Pain_empty), getText (configFile >> "CfgMagazines" >> _mag >> "displayName")], 2.5, _player] call ace_common_fnc_displayTextStructured;
};

playsound3D [QPATHTOF_SOUND(sounds\take_painkillers.wav), _player, false, getPosASL _player, 8, 1, 15];

if (isText (configFile >> "ACE_Medical_Advanced" >> "Treatment" >> "Medication" >> _className >> "itemClassName")) then {
    _mag = getText (configFile >> "ACE_Medical_Advanced" >> "Treatment" >> "Medication" >> _className >> "itemClassName");
};

[_player, _target, _selectionName, _className, "", _mag] call ace_medical_treatment_fnc_medication;
