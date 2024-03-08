#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Deletes magazine with specific ammo count & creates a new one with provided ammo count.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Magazine <STRING>
 * 2: Container Location <STRING>
 * 3: Current Ammo Count <NUMBER>
 * 4: New Ammo Count <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_IFAK_Magazine", "vest", 10, 15] call kat_misc_fnc_switchMagItems;
 *
 * Public: No
 */

params ["_unit", "_mag", "_removeContainer", "_oldMagAmmoCount", "_newMagAmmoCout"];

switch (_removeContainer) do {
    case "Uniform": { 
        uniformContainer _unit addMagazineAmmoCargo [_mag, -1, _oldMagAmmoCount];
        uniformContainer _unit addMagazineAmmoCargo [_mag, 1, _newMagAmmoCout];
    };

    case "Vest": { 
        vestContainer _unit addMagazineAmmoCargo [_mag, -1, _oldMagAmmoCount];
        vestContainer _unit addMagazineAmmoCargo [_mag, 1, _newMagAmmoCout];
    };

    case "Backpack": { 
        backpackContainer _unit addMagazineAmmoCargo [_mag, -1, _oldMagAmmoCount];
        backpackContainer _unit addMagazineAmmoCargo [_mag, 1, _newMagAmmoCout];
    };
};