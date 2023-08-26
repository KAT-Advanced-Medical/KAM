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

params ["_unit", "_item", "_slotsToGive"];

private _container = "";

//IFAK
private _containerIFAK = missionnamespace getVariable [QGVAR(IFAK_Container), []];
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

switch (_containerIFAK) do {
    case 0: { _container = "uniform";};
    case 1: { _container = "vest";};
    case 2: { _container = "backpack";};
};

switch (_item) do {
    case "kat_IFAK": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_used", "", 75] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_used", "", 75] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S3_used", "", 75] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S4_used", "", 75] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };
    
    case "kat_IFAK_S1_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S3_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S4_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S2_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_used", "", 75] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S3_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S4_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S3_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S3_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S3_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S3_S4_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S4_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S4_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {

                _unit removeItem _item;
                [_unit, "kat_IFAK_S3_S4_used", "", 50] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S1_S2_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_S3_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S1_S3_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_S3_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S3_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S1_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S3_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S2_S3_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_S3_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S3_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S2_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S2_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S3_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S3_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S1_S3_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {
                
                _unit removeItem _item;
                [_unit, "kat_IFAK_S2_S3_S4_used", "", 25] call ACEFUNC(common,addToInventory);
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S1_S2_S3_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 4: {
                
                _unit removeItem _item;
                [_unit, _fourthSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S2_S3_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 1: {
                
                _unit removeItem _item;
                [_unit, _firstSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S1_S3_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 2: {
                
                _unit removeItem _item;
                [_unit, _secondSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };

    case "kat_IFAK_S1_S2_S4_used": {
        switch (_slotsToGive) do {
            case 0: {

                _unit removeItem _item;
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };

            case 3: {
                
                _unit removeItem _item;
                [_unit, _thirdSlotItemIFAK, _container] call FUNC(arrayToInvItem);
            };
        };
    };


 // ----------------------------------------- Advanced First Aid Kit ---------------------------------------

switch (_containerAFAK) do {
    case 0: { _container = "Uniform"};
    case 1: { _container = "Vest"};
    case 2: { _container = "Backpack"};
};


};
