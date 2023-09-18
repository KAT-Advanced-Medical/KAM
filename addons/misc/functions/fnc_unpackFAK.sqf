#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Gives the player the predefined Items (in CBA) for every FAK varient
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 * 2: Number
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_IFAK", 0] call kat_misc_fnc_unpackFAK;
 *
 * Public: No
 */

params ["_unit", "_mag", "_slotsToGive"];

private _container = "";
private _removeContainer = "";

//IFAK
private _containerIFAK = missionNamespace getVariable [QGVAR(IFAK_Container), []];
private _firstSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []];
private _secondSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []];
private _thirdSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKThirdtSlotItem), []];
private _fourthSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []];

//AFAK
private _containerAFAK = missionNamespace getVariable [QGVAR(AFAK_Container), []];
private _firstSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []];
private _secondSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []];
private _thirdSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKThirdtSlotItem), []];
private _fourthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []];
private _fifthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []];
private _sixthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []];

//MFAK
private _containerMFAK = missionNamespace getVariable [QGVAR(MFAK_Container), []];
private _firstSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []];
private _secondSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []];
private _thirdSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKThirdtSlotItem), []];
private _fourthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []];
private _fifthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []];
private _sixthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []];
private _seventhSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSeventhSlotItem), []];
private _eighthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKEighthSlotItem), []];

// ----- Handeling for default item -----

private _itemType = _mag call BIS_fnc_itemType;
_itemType = _itemType select 0;
if (_itemType == "Item") exitWith {
    if (_mag == "kat_IFAK") exitWith {

        switch (_containerIFAK) do {
            case 0: { _container = "uniform";};
            case 1: { _container = "vest";};
            case 2: { _container = "backpack";};
        };

        switch (_slotsToGive) do {
            case 0: { 
                _unit removeItem _mag;
                [_unit, "kat_IFAK_Magazine", "", 0] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
            case 1: { 
                _unit removeItem _mag;
                [_unit, "kat_IFAK_Magazine", "", Slot_2_3_4] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
            case 2: { 
                _unit removeItem _mag;
                [_unit, "kat_IFAK_Magazine", "", Slot_1_3_4] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
            case 3: { 
                _unit removeItem _mag;
                [_unit, "kat_IFAK_Magazine", "", Slot_1_2_4] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
            case 4: { 
                _unit removeItem _mag;
                [_unit, "kat_IFAK_Magazine", "", Slot_1_2_3] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    if (_mag == "kat_AFAK") exitWith {

        switch (_containerAFAK) do {
            case 0: { _container = "uniform";};
            case 1: { _container = "vest";};
            case 2: { _container = "backpack";};
        };

        switch (_slotsToGive) do {
            case 0: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", 0] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemAFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemAFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemAFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemAFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fifthSlotItemAFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _sixthSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
            case 1: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", Slot_2_3_4_5_6] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
            case 2: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", Slot_1_3_4_5_6] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
            case 3: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", Slot_1_2_4_5_6] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
            case 4: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", Slot_1_2_3_5_6] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
            case 5: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", Slot_1_2_3_4_6] call ACEFUNC(common,addToInventory);
                [_unit, _fifthSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
            case 6: { 
                _unit removeItem _mag;
                [_unit, "kat_AFAK_Magazine", "", Slot_1_2_3_4_5] call ACEFUNC(common,addToInventory);
                [_unit, _sixthSlotItemAFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    if (_mag == "kat_MFAK") exitWith {

        switch (_containerMFAK) do {
            case 0: { _container = "uniform";};
            case 1: { _container = "vest";};
            case 2: { _container = "backpack";};
        };

        switch (_slotsToGive) do {
            case 0: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", 0] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fifthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _sixthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _seventhSlotItemMFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _eighthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 1: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_2_3_4_5_6_7_8] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 2: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_3_4_5_6_7_8] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 3: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_2_4_5_6_7_8] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 4: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_2_3_5_6_7_8] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 5: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_2_3_4_6_7_8] call ACEFUNC(common,addToInventory);
                [_unit, _fifthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 6: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_2_3_4_5_7_8] call ACEFUNC(common,addToInventory);
                [_unit, _sixthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 7: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_2_3_4_5_6_8] call ACEFUNC(common,addToInventory);
                [_unit, _sixthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
            case 8: { 
                _unit removeItem _mag;
                [_unit, "kat_MFAK_Magazine", "", Slot_1_2_3_4_5_6_7] call ACEFUNC(common,addToInventory);
                [_unit, _sixthSlotItemMFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };
};

// ----- Handeling for magazine -----

private _ammoCount = [_unit, _mag, true] call FUNC(getMagazineAmmoCounts);
private _removeFromArray = [];
private _firstSlotItem_1 = "";
private _secondSlotItem_2 = "";
private _thirdSlotItem_3 = "";
private _fourthSlotItem_4 = "";
private _fifthSlotItem_5 = "";
private _sixthSlotItem_6 = "";
private _seventhSlotIte_7 = "";
private _eighthSlotItem_8 = "";

switch (_mag) do {
    case "kat_IFAK_Magazine": { 
        _firstSlotItem_1 = _firstSlotItemIFAK;
        _secondSlotItem_2 = _secondSlotItemIFAK;
        _thirdSlotItem_3 = _thirdSlotItemIFAK;
        _fourthSlotItem_4 = _fourthSlotItemIFAK;

        switch (_containerIFAK) do {
            case 0: { _container = "uniform";};
            case 1: { _container = "vest";};
            case 2: { _container = "backpack";};
        };
    };

    case "kat_AFAK_Magazine": { 
        _firstSlotItem_1 = _firstSlotItemAFAK;
        _secondSlotItem_2 = _secondSlotItemAFAK;
        _thirdSlotItem_3 = _thirdSlotItemAFAK;
        _fourthSlotItem_4 = _fourthSlotItemAFAK;
        _fifthSlotItem_5 = _fifthSlotItemAFAK;
        _sixthSlotItem_6 = _sixthSlotItemAFAK;

        switch (_containerAFAK) do {
            case 0: { _container = "uniform";};
            case 1: { _container = "vest";};
            case 2: { _container = "backpack";};
        };
    };

    case "kat_MFAK_Magazine": { 
        _firstSlotItem_1 = _firstSlotItemMFAK;
        _secondSlotItem_2 = _secondSlotItemMFAK;
        _thirdSlotItem_3 = _thirdSlotItemMFAK;
        _fourthSlotItem_4 = _fourthSlotItemMFAK;
        _fifthSlotItem_5 = _fifthSlotItemMFAK;
        _sixthSlotItem_6 = _sixthSlotItemMFAK;
        _seventhSlotIte_7 = _seventhSlotItemMFAK;
        _eighthSlotItem_8 = _eighthSlotItemMFAK;

        switch (_containerMFAK) do {
            case 0: { _container = "uniform";};
            case 1: { _container = "vest";};
            case 2: { _container = "backpack";};
        };
    };
};

// Deletes the false ammo values out of ammo count 

if ((count _ammoCount) > 1) then {
    {
        if !([_unit, _mag, _slotsToGive, (_x select 0)] call FUNC(checkFAKSlot)) then {
            _removeFromArray pushBack _x;
        };
    } forEach _ammoCount;

    _ammoCount = _ammoCount - _removeFromArray;
    _ammoCount sort true;
};

_ammoCount = _ammoCount select 0;
_removeContainer = _ammoCount select 1;
_ammoCount = _ammoCount select 0;

switch (_slotsToGive) do {
    
    case 0: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                };
                case Slot_2: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                };
                case Slot_3: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                };
                case Slot_4: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                };
                case Slot_5: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                };
                case Slot_6: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                };
                case Slot_7: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                };
                case Slot_8: { 
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                    [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                    };
                    case Slot_1_3: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_1_4: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_1_5: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_1_6: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_1_7: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_1_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _firstSlotItem_1, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_2_3: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_2_4: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_2_5: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_2_6: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_2_7: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_2_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _secondSlotItem_2, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_3_4: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_3_5: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_3_6: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                     };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_3_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _thirdSlotItem_3, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_4_5: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_4_6: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_4_7: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_4_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fourthSlotItem_4, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_5_6: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_5_7: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_5_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _fifthSlotItem_5, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_6_7: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_6_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _sixthSlotItem_6, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                    case Slot_7_8: { 
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_empty] call FUNC(switchMagItems);
                        [_unit, _seventhSlotIte_7, _container] call FUNC(arrayToInvItem);
                        [_unit, _eighthSlotItem_8, _container] call FUNC(arrayToInvItem);
                     };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };

    case 1: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };



    case 2: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };



    case 3: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };



    case 4: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };


    
    case 5: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };



    case 6: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };



    case 7: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };



    case 8: { 

        // 1 Slot left
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) then { 
            switch (_ammoCount) do {
                case Slot_1: {  };
                case Slot_2: {  };
                case Slot_3: {  };
                case Slot_4: {  };
                case Slot_5: {  };
                case Slot_6: {  };
                case Slot_7: {  };
                case Slot_8: {  };
            };
        };

        // 2 Slots left
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) then { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2: {  };
                    case Slot_1_3: {  };
                    case Slot_1_4: {  };
                    case Slot_1_5: {  };
                    case Slot_1_6: {  };
                    case Slot_1_7: {  };
                    case Slot_1_8: {  };
                    case Slot_2_3: {  };
                    case Slot_2_4: {  };
                    case Slot_2_5: {  };
                    case Slot_2_6: {  };
                    case Slot_2_7: {  };
                    case Slot_2_8: {  };
                    case Slot_3_4: {  };
                    case Slot_3_5: {  };
                    case Slot_3_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_3_7: {  };
                    case Slot_3_8: {  };
                    case Slot_4_5: {  };
                    case Slot_4_6: {  };
                    case Slot_4_7: {  };
                    case Slot_4_8: {  };
                    case Slot_5_6: {  };
                    case Slot_5_7: {  };
                    case Slot_5_8: {  };
                    case Slot_6_7: {  };
                    case Slot_6_8: {  };
                    case Slot_7_8: {  };
                };
            };
        };
        
        // 3 Slots left
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) then { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3: {  };
                    case Slot_1_2_4: {  };
                    case Slot_1_2_5: {  };
                    case Slot_1_2_6: {  };
                    case Slot_1_2_7: {  };
                    case Slot_1_2_8: {  };
                    case Slot_1_3_4: {  };
                    case Slot_1_3_5: {  };
                    case Slot_1_3_6: {  };
                    case Slot_1_3_7: {  };
                    case Slot_1_3_8: {  };
                    case Slot_1_4_5: {  };
                    case Slot_1_4_6: {  };
                    case Slot_1_4_7: {  };
                    case Slot_1_4_8: {  };
                    case Slot_1_5_6: {  };
                    case Slot_1_5_7: {  };
                    case Slot_1_5_8: {  };
                    case Slot_1_6_7: {  };
                    case Slot_1_6_8: {  };
                    case Slot_1_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4: {  };
                    case Slot_2_3_5: {  };
                    case Slot_2_3_6: {  };
                    case Slot_2_3_7: {  };
                    case Slot_2_3_8: {  };
                    case Slot_2_4_5: {  };
                    case Slot_2_4_6: {  };
                    case Slot_2_4_7: {  };
                    case Slot_2_4_8: {  };
                    case Slot_2_5_6: {  };
                    case Slot_2_5_7: {  };
                    case Slot_2_5_8: {  };
                    case Slot_2_6_7: {  };
                    case Slot_2_6_8: {  };
                    case Slot_2_7_8: {  };
                    case Slot_3_4_5: {  };
                    case Slot_3_4_6: {  };
                    case Slot_3_4_7: {  };
                    case Slot_3_4_8: {  };
                    case Slot_3_5_6: {  };
                    case Slot_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_8: {  };
                    case Slot_3_6_7: {  };
                    case Slot_3_6_8: {  };
                    case Slot_3_7_8: {  };
                    case Slot_4_5_6: {  };
                    case Slot_4_5_7: {  };
                    case Slot_4_5_8: {  };
                    case Slot_4_6_7: {  };
                    case Slot_4_6_8: {  };
                    case Slot_4_7_8: {  };
                    case Slot_5_6_7: {  };
                    case Slot_5_6_8: {  };
                    case Slot_5_7_8: {  };
                    case Slot_6_7_8: {  };
                };
            };
        };
        
        // 4 Slots left 
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) then { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: {  };
                    case Slot_1_2_3_5: {  };
                    case Slot_1_2_3_6: {  };
                    case Slot_1_2_3_7: {  };
                    case Slot_1_2_3_8: {  };
                    case Slot_1_2_4_5: {  };
                    case Slot_1_2_4_6: {  };
                    case Slot_1_2_4_7: {  };
                    case Slot_1_2_4_8: {  };
                    case Slot_1_2_5_6: {  };
                    case Slot_1_2_5_7: {  };
                    case Slot_1_2_5_8: {  };
                    case Slot_1_2_6_7: {  };
                    case Slot_1_2_6_8: {  };
                    case Slot_1_2_7_8: {  };
                    case Slot_1_3_4_5: {  };
                    case Slot_1_3_4_6: {  };
                    case Slot_1_3_4_7: {  };
                    case Slot_1_3_4_8: {  };
                    case Slot_1_3_5_6: {  };
                    case Slot_1_3_5_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: {  };
                    case Slot_1_3_6_7: {  };
                    case Slot_1_3_6_8: {  };
                    case Slot_1_3_7_8: {  };
                    case Slot_1_4_5_6: {  };
                    case Slot_1_4_5_7: {  };
                    case Slot_1_4_5_8: {  };
                    case Slot_1_4_6_7: {  };
                    case Slot_1_4_6_8: {  };
                    case Slot_1_4_7_8: {  };
                    case Slot_1_5_6_7: {  };
                    case Slot_1_5_6_8: {  };
                    case Slot_1_5_7_8: {  };
                    case Slot_1_6_7_8: {  };
                    case Slot_2_3_4_5: {  };
                    case Slot_2_3_4_6: {  };
                    case Slot_2_3_4_7: {  };
                    case Slot_2_3_4_8: {  };
                    case Slot_2_3_5_6: {  };
                    case Slot_2_3_5_7: {  };
                    case Slot_2_3_5_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: {  };
                    case Slot_2_3_6_8: {  };
                    case Slot_2_3_7_8: {  };
                    case Slot_2_4_5_6: {  };
                    case Slot_2_4_5_7: {  };
                    case Slot_2_4_5_8: {  };
                    case Slot_2_4_6_7: {  };
                    case Slot_2_4_6_8: {  };
                    case Slot_2_4_7_8: {  };
                    case Slot_2_5_6_7: {  };
                    case Slot_2_5_6_8: {  };
                    case Slot_2_5_7_8: {  };
                    case Slot_2_6_7_8: {  };
                    case Slot_3_4_5_6: {  };
                    case Slot_3_4_5_7: {  };
                    case Slot_3_4_5_8: {  };
                    case Slot_3_4_6_7: {  };
                    case Slot_3_4_6_8: {  };
                    case Slot_3_4_7_8: {  };
                    case Slot_3_5_6_7: {  };
                    case Slot_3_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) then {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: {  };
                    case Slot_3_6_7_8: {  };
                    case Slot_4_5_6_7: {  };
                    case Slot_4_5_6_8: {  };
                    case Slot_4_5_7_8: {  };
                    case Slot_4_6_7_8: {  };
                    case Slot_5_6_7_8: {  };
                };
            };
        };
        
        // 5 Slots left
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) then { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: {  };
                    case Slot_1_2_3_4_6: {  };
                    case Slot_1_2_3_4_7: {  };
                    case Slot_1_2_3_4_8: {  };
                    case Slot_1_2_3_5_6: {  };
                    case Slot_1_2_3_5_7: {  };
                    case Slot_1_2_3_5_8: {  };
                    case Slot_1_2_3_6_7: {  };
                    case Slot_1_2_3_6_8: {  };
                    case Slot_1_2_3_7_8: {  };
                    case Slot_1_2_4_5_6: {  };
                    case Slot_1_2_4_5_7: {  };
                    case Slot_1_2_4_5_8: {  };
                    case Slot_1_2_4_6_7: {  };
                    case Slot_1_2_4_6_8: {  };
                    case Slot_1_2_4_7_8: {  };
                    case Slot_1_2_5_6_7: {  };
                    case Slot_1_2_5_6_8: {  };
                    case Slot_1_2_5_7_8: {  };
                    case Slot_1_2_6_7_8: {  };
                    case Slot_1_3_4_5_6: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: {  };
                    case Slot_1_3_4_5_8: {  };
                    case Slot_1_3_4_6_7: {  };
                    case Slot_1_3_4_6_8: {  };
                    case Slot_1_3_4_7_8: {  };
                    case Slot_1_3_5_6_7: {  };
                    case Slot_1_3_5_6_8: {  };
                    case Slot_1_3_5_7_8: {  };
                    case Slot_1_3_6_7_8: {  };
                    case Slot_1_4_5_6_7: {  };
                    case Slot_1_4_5_6_8: {  };
                    case Slot_1_4_5_7_8: {  };
                    case Slot_1_4_6_7_8: {  };
                    case Slot_1_5_6_7_8: {  };
                    case Slot_2_3_4_5_6: {  };
                    case Slot_2_3_4_5_7: {  };
                    case Slot_2_3_4_5_8: {  };
                    case Slot_2_3_4_6_7: {  };
                    case Slot_2_3_4_6_8: {  };
                    case Slot_2_3_4_7_8: {  };
                    case Slot_2_3_5_6_7: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: {  };
                    case Slot_2_3_5_7_8: {  };
                    case Slot_2_3_6_7_8: {  };
                    case Slot_2_4_5_6_7: {  };
                    case Slot_2_4_5_6_8: {  };
                    case Slot_2_4_5_7_8: {  };
                    case Slot_2_4_6_7_8: {  };
                    case Slot_2_5_6_7_8: {  };
                    case Slot_3_4_5_6_7: {  };
                    case Slot_3_4_5_6_8: {  };
                    case Slot_3_4_5_7_8: {  };
                    case Slot_3_4_6_7_8: {  };
                    case Slot_3_5_6_7_8: {  };
                    case Slot_4_5_6_7_8: {  };
                };
            };
        };
        
        // 6 Slot left
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) then { 

            if (_ammoCount >= SlotsLeft_6D_1Min && _ammoCount <= SlotsLeft_6D_1Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5_6: {  };
                    case Slot_1_2_3_4_5_7: {  };
                    case Slot_1_2_3_4_5_8: {  };
                    case Slot_1_2_3_4_6_7: {  };
                    case Slot_1_2_3_4_6_8: {  };
                    case Slot_1_2_3_4_7_8: {  };
                    case Slot_1_2_3_5_6_7: {  };
                    case Slot_1_2_3_5_6_8: {  };
                    case Slot_1_2_3_5_7_8: {  };
                    case Slot_1_2_3_6_7_8: {  };
                    case Slot_1_2_4_5_6_7: {  };
                    case Slot_1_2_4_5_6_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_2Max) then {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_7_8: {  };
                    case Slot_1_2_4_6_7_8: {  };
                    case Slot_1_2_5_6_7_8: {  };
                    case Slot_1_3_4_5_6_7: {  };
                    case Slot_1_3_4_5_6_8: {  };
                    case Slot_1_3_4_5_7_8: {  };
                    case Slot_1_3_4_6_7_8: {  };
                    case Slot_1_3_5_6_7_8: {  };
                    case Slot_1_4_5_6_7_8: {  };
                };
            };

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) then {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: {  };
                    case Slot_2_3_4_5_6_8: {  };
                    case Slot_2_3_4_5_7_8: {  };
                    case Slot_2_3_4_6_7_8: {  };
                    case Slot_2_3_5_6_7_8: {  };
                    case Slot_2_4_5_6_7_8: {  };
                    case Slot_3_4_5_6_7_8: {  };
                };
            };
        };

        // 7 Slots left
        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) then { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6_7: {  };
                case Slot_1_2_3_4_5_6_8: {  };
                case Slot_1_2_3_4_5_7_8: {  };
                case Slot_1_2_3_4_6_7_8: {  };
                case Slot_1_2_3_5_6_7_8: {  };
                case Slot_1_2_4_5_6_7_8: {  };
                case Slot_1_3_4_5_6_7_8: {  };
                case Slot_2_3_4_5_6_7_8: {  };
            };
        };
    };
};
