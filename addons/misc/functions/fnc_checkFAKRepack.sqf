#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Checks if unit has required items to refill a FAK slot.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 * 2: Number
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "kat_IFAK_Magazine", 1] call kat_misc_fnc_checkFAKRepack;
 *
 * Public: No
 */

params ["_unit", "_mag", "_slotToCheck"];

private _return = false;

if (([_unit, _mag] call ACEFUNC(common,hasMagazine)) != true) exitWith { _return };

//IFAK
private _firstSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []];
private _secondSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []];
private _thirdSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKThirdtSlotItem), []];
private _fourthSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []];

//AFAK
private _firstSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []];
private _secondSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []];
private _thirdSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKThirdtSlotItem), []];
private _fourthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []];
private _fifthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []];
private _sixthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []];

//MFAK
private _firstSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []];
private _secondSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []];
private _thirdSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKThirdtSlotItem), []];
private _fourthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []];
private _fifthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []];
private _sixthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []];
private _seventhSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSeventhSlotItem), []];
private _eighthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKEighthSlotItem), []];

private _itemToCheckFor = [];
private _itemList = [];
private _hasTrueValue = [];
private _inventory = items _unit;
private _invMags = magazines _unit;

switch (_mag) do {
	case "kat_IFAK_Magazine": { 
		switch (_slotToCheck) do {
			case 1: { _itemToCheckFor = _firstSlotItemIFAK };
			case 2: { _itemToCheckFor = _secondSlotItemIFAK};
			case 3: { _itemToCheckFor = _thirdSlotItemIFAK };
			case 4: { _itemToCheckFor = _fourthSlotItemIFAK};
		};
	};
	case "kat_AFAK_Magazine": { 
		switch (_slotToCheck) do {
			case 1: { _itemToCheckFor = _firstSlotItemAFAK };
			case 2: { _itemToCheckFor = _secondSlotItemAFAK};
			case 3: { _itemToCheckFor = _thirdSlotItemAFAK };
			case 4: { _itemToCheckFor = _fourthSlotItemAFAK};
			case 5: { _itemToCheckFor = _fifthSlotItemAFAK };
			case 6: { _itemToCheckFor = _sixthSlotItemAFAK };
		};
	};
	case "kat_MFAK_Magazine": { 
		switch (_slotToCheck) do {
			case 1: { _itemToCheckFor = _firstSlotItemMFAK  };
			case 2: { _itemToCheckFor = _secondSlotItemMFAK };
			case 3: { _itemToCheckFor = _thirdSlotItemMFAK  };
			case 4: { _itemToCheckFor = _fourthSlotItemMFAK };
			case 5: { _itemToCheckFor = _fifthSlotItemMFAK  };
			case 6: { _itemToCheckFor = _sixthSlotItemMFAK  };
			case 7: { _itemToCheckFor = _seventhSlotItemMFAK};
			case 8: { _itemToCheckFor = _eighthSlotItemMFAK };
		};
	};
};

{
	_inventory pushBack _x;
} forEach _invMags;

{
	private _iTCF = _x select 0;
	
	{
		if (_x == _iTCF) then {
			_itemList pushBack _x;
		};
	} forEach _inventory;

	if ((count _itemList) >= (_x select 1)) then {
		_hasTrueValue pushback true;
	};

	_itemList = [];

} forEach _itemToCheckFor;

if ((count _hasTrueValue) == (count _itemToCheckFor)) exitwith {
	_return = true;
	_return
};

_return
