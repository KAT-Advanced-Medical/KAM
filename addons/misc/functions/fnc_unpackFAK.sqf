#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Gives the player the predefined Items (in CBA) for every FAK varient
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_IFAK"] call kat_misc_fnc_unpackFAK;
 *
 * Public: No
 */

params ["_unit", "_item"];

//IFAK
private _firstSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []];
private _firstSlotAmountIFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotAmount), []];
private _secondSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []];
private _secondSlotAmountIFAK = missionNamespace getVariable [QGVAR(IFAKSecondSlotAmount), []];
private _thirdSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKThirdtSlotItem), []];
private _thirdSlotAmountIFAK = missionNamespace getVariable [QGVAR(IFAKThirdSlotAmount), []];
private _fourthSlotItemIFAK = missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []];
private _fourthSlotAmountIFAK = missionNamespace getVariable [QGVAR(IFAKFourthSlotAmount), []];

//MFAK
private _firstSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []];
private _firstSlotAmountMFAK = missionNamespace getVariable [QGVAR(MFAKFirstSlotAmount), []];
private _secondSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []];
private _secondSlotAmountMFAK = missionNamespace getVariable [QGVAR(MFAKSecondSlotAmount), []];
private _thirdSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKThirdtSlotItem), []];
private _thirdSlotAmountMFAK = missionNamespace getVariable [QGVAR(MFAKThirdSlotAmount), []];
private _fourthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []];
private _fourthSlotAmountMFAK = missionNamespace getVariable [QGVAR(MFAKFourthSlotAmount), []];
private _fifthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []];
private _fifthSlotAmountMFAK = missionNamespace getVariable [QGVAR(MFAKFifthSlotAmount), []];
private _sixthSlotItemMFAK = missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []];
private _sixthSlotAmountMFAK = missionNamespace getVariable [QGVAR(MFAKSixthSlotAmount), []];

//AFAK
private _firstSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []];
private _firstSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKFirstSlotAmount), []];
private _secondSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []];
private _secondSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKSecondSlotAmount), []];
private _thirdSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKThirdtSlotItem), []];
private _thirdSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKThirdSlotAmount), []];
private _fourthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []];
private _fourthSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKFourthSlotAmount), []];
private _fifthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []];
private _fifthSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKFifthSlotAmount), []];
private _sixthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []];
private _sixthSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKSixthSlotAmount), []];
private _seventhSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKSeventhSlotItem), []];
private _seventhSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKSeventhSlotAmount), []];
private _eighthSlotItemAFAK = missionNamespace getVariable [QGVAR(AFAKEighthSlotItem), []];
private _eighthSlotAmountAFAK = missionNamespace getVariable [QGVAR(AFAKEighthSlotAmount), []];


switch (_item) do {
    case "kat_IFAK": { 

        while {_firstSlotItemIFAK isNotEqualTo ""} do {
            private _loopCount = _firstSlotAmountIFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _firstSlotItemIFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _firstSlotItemIFAK = "";
        };

        while {_secondSlotItemIFAK isNotEqualTo ""} do {
            private _loopCount = _secondSlotAmountIFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _secondSlotItemIFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _secondSlotItemIFAK = "";
        };
        
        while {_thirdSlotItemIFAK isNotEqualTo ""} do {
            private _loopCount = _thirdSlotAmountIFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _thirdSlotItemIFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _thirdSlotItemIFAK = "";
        };
        
        while {_fourthSlotItemIFAK isNotEqualTo ""} do {
            private _loopCount = _fourthSlotAmountIFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _fourthSlotItemIFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _fourthSlotItemIFAK = "";
        };
        
        _unit removeItem _item;
    };
    
    case "kat_MFAK": { 

        while {_firstSlotItemMFAK isNotEqualTo ""} do {
            private _loopCount = _firstSlotAmountMFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _firstSlotItemMFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _firstSlotItemMFAK = "";
        };

        while {_secondSlotItemMFAK isNotEqualTo ""} do {
            private _loopCount = _secondSlotAmountMFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _secondSlotItemMFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _secondSlotItemMFAK = "";
        };
        
        while {_thirdSlotItemMFAK isNotEqualTo ""} do {
            private _loopCount = _thirdSlotAmountMFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _thirdSlotItemMFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _thirdSlotItemMFAK = "";
        };
        
        while {_fourthSlotItemMFAK isNotEqualTo ""} do {
            private _loopCount = _fourthSlotAmountMFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _fourthSlotItemMFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _fourthSlotItemMFAK = "";
        };
        
        while {_fifthSlotItemMFAK isNotEqualTo ""} do {
            private _loopCount = _fifthSlotAmountMFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _fifthSlotItemMFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _fifthSlotItemMFAK = "";
        };
        
        while {_sixthSlotItemMFAK isNotEqualTo ""} do {
            private _loopCount = _sixthSlotAmountMFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _sixthSlotItemMFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _sixthSlotItemMFAK = "";
        };

        _unit removeItem _item;
    };
    
    case "kat_AFAK": { 

        while {_firstSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _firstSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _firstSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _firstSlotItemAFAK = "";
        };

        while {_secondSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _secondSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _secondSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _secondSlotItemAFAK = "";
        };
        
        while {_thirdSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _thirdSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _thirdSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _thirdSlotItemAFAK = "";
        };
        
        while {_fourthSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _fourthSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _fourthSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _fourthSlotItemAFAK = "";
        };
        
        while {_fifthSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _fifthSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _fifthSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _fifthSlotItemAFAK = "";
        };
        
        while {_sixthSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _sixthSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _sixthSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _sixthSlotItemAFAK = "";
        };

        while {_seventhSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _seventhSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _seventhSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _seventhSlotItemAFAK = "";
        };
        
        while {_eighthSlotItemAFAK isNotEqualTo ""} do {
            private _loopCount = _eighthSlotAmountAFAK; 
            private _i = 0; 
            while {_i < _loopCount} do { 
                [_unit, _eighthSlotItemAFAK] call ACEFUNC(common,addToInventory);
                _i = _i + 1; 
            };
            _eighthSlotItemAFAK = "";
        };

        _unit removeItem _item;
    };
};
