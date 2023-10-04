#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Repacks FAK Slot
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Magazine <STRING>
 * 2: Slot <NUMBER>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "kat_IFAK_Magazine", 1] call kat_misc_fnc_repackFAK;
 *
 * Public: No
 */

params ["_unit", "_mag", "_slotToRepack"];

private _removeContainer = "";
private _removeFromArray = [];
private _ammoCount = [_unit, _mag, true] call FUNC(getMagazineAmmoCounts);
private _firstSlotItem_1 = [];
private _secondSlotItem_2 = [];
private _thirdSlotItem_3 = [];
private _fourthSlotItem_4 = [];
private _fifthSlotItem_5 = [];
private _sixthSlotItem_6 = [];
private _seventhSlotIte_7 = [];
private _eighthSlotItem_8 = [];

switch (_mag) do {
    case "kat_IFAK_Magazine": { 
        //IFAK
        _firstSlotItem_1 = missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []];
        _secondSlotItem_2 = missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []];
        _thirdSlotItem_3 = missionNamespace getVariable [QGVAR(IFAKThirdtSlotItem), []];
        _fourthSlotItem_4 = missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []];
    };
    case "kat_AFAK_Magazine": { 
        //AFAK
        _firstSlotItem_1 = missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []];
        _secondSlotItem_2 = missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []];
        _thirdSlotItem_3 = missionNamespace getVariable [QGVAR(AFAKThirdtSlotItem), []];
        _fourthSlotItem_4 = missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []];
        _fifthSlotItem_5 = missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []];
        _sixthSlotItem_6 = missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []];
    };
    case "kat_MFAK_Magazine": { 
        //MFAK
        _firstSlotItem_1 = missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []];
        _secondSlotItem_2 = missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []];
        _thirdSlotItem_3 = missionNamespace getVariable [QGVAR(MFAKThirdtSlotItem), []];
        _fourthSlotItem_4 = missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []];
        _fifthSlotItem_5 = missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []];
        _sixthSlotItem_6 = missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []];
        _seventhSlotIte_7 = missionNamespace getVariable [QGVAR(MFAKSeventhSlotItem), []];
        _eighthSlotItem_8 = missionNamespace getVariable [QGVAR(MFAKEighthSlotItem), []];
    };
};

if ((count _ammoCount) > 1) then {
    {
        if [_unit, _mag, _slotToRepack, (_x select 0)] call FUNC(checkFAKSlot) then {
            _removeFromArray pushBack _x;
        };
    } forEach _ammoCount;

    _ammoCount = _ammoCount - _removeFromArray;
    _ammoCount sort true;
};

_ammoCount = _ammoCount select 0;
_removeContainer = _ammoCount select 1;
_ammoCount = _ammoCount select 0;

switch (_slotToRepack) do {

    case 1: { 

        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_2: {
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_7] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_8] call FUNC(switchMagItems);
                };
            };
        };

        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3] call FUNC(switchMagItems);
                    };
                    case Slot_2_4: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4] call FUNC(switchMagItems);
                    };
                    case Slot_2_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_3_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_3_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_4_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_6D_3Min && _ammoCount <= SlotsLeft_6D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4_5_6_7: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_6_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_7_8: { 
                        [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };

        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 

            switch (_ammoCount) do {
                case Slot_2_3_4_5_6_7_8: {  
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: {
                    [_unit, _firstSlotItem_1] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1] call FUNC(switchMagItems);
                };
            };
        };
    };



    case 2: { 

        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount,Slot_2_3] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_7] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_8] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3] call FUNC(switchMagItems);
                    };
                    case Slot_1_4: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_3_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_3_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_4_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_4_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_4_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_6: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_4_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_6D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_6D_2Min && _ammoCount <= SlotsLeft_6D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_6_7: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_6_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_7_8: { 
                        [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };

        if (_ammoCount >= SlotsLeft_7D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 

            switch (_ammoCount) do {
                case Slot_1_3_4_5_6_7_8: { 
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: {
                    [_unit, _secondSlotItem_2] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2] call FUNC(switchMagItems);
                };
            };
        };
    };



    case 3: { 

        
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith {
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3] call FUNC(switchMagItems);
                };
                case Slot_2: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_3] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_3] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_6_3] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_7_3] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_8_3] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3] call FUNC(switchMagItems);
                    };
                    case Slot_1_4: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_2_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_4_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_4_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_4: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_4_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_4_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_4_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_4_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_4_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_4_5_6: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_4_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_4_5_6_7: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_7_8: { 
                        [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1_2_4_5_6_7: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_5_6_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_5_7_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_6_7_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_5_6_7_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_4_5_6_7_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_3_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_2_4_5_6_7_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_3_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_5_6_7_8: { 
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: {
                    [_unit, _thirdSlotItem_3] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_3] call FUNC(switchMagItems);
                };
            };
        };
    };



    case 4: { 

        
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4] call FUNC(switchMagItems);
                };
                case Slot_2: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount,Slot_4_5] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_7] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_8] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_3: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_2_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_3_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_5: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_5_6: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6_7: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7_8: { 
                        [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 

            switch (_ammoCount) do {
                case Slot_1_2_3_5_6_7: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_5_6_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_5_7_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_6_7_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_5_6_7_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_3_5_6_7_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_2_3_5_6_7_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_5_6_7_8: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: { 
                    [_unit, _fourthSlotItem_4] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4] call FUNC(switchMagItems);
                };
            };
        };
    };


    
    case 5: { 

        
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5] call FUNC(switchMagItems);
                };
                case Slot_2: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_7] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_8] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_3: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_3_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_6: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_6_7: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_6_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_6_7_8: { 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_empty:{ 
                        [_unit, _fifthSlotItem_5] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5] call FUNC(switchMagItems);
                    };
                };
        };
    };



    case 6: { 

        
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6] call FUNC(switchMagItems);
                };
                case Slot_2: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_6_7] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_6_8] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_4Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_7: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7_8: { 
                        [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_7: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_5_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_7_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_5_7_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_5_7_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_3_4_5_7_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_2_3_4_5_7_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_5_7_8: { 
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: {
                    [_unit, _sixthSlotItem_6] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_6] call FUNC(switchMagItems);
                };
            };
        };
    };



    case 7: { 

        
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_7] call FUNC(switchMagItems);
                };
                case Slot_2: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_7] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_3_7] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_7] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_7] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_6_7] call FUNC(switchMagItems);
                };
                case Slot_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_7_8] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_6: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_8: { 
                        [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_5_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_6_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_5_6_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_5_6_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_3_4_5_6_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_2_3_4_5_6_8: { 
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_5_6_8: {  
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: {
                    [_unit, _seventhSlotIte_7] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_7] call FUNC(switchMagItems);
                };
            };
        };
    };



    case 8: { 

        
        if (_ammoCount >= SlotsLeft_1D_Min && _ammoCount <= SlotsLeft_1D_Max) exitWith { 
            switch (_ammoCount) do {
                case Slot_1: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_8] call FUNC(switchMagItems);
                };
                case Slot_2: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_8] call FUNC(switchMagItems);
                };
                case Slot_3: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_3_8] call FUNC(switchMagItems);
                };
                case Slot_4: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_4_8] call FUNC(switchMagItems);
                };
                case Slot_5: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_5_8] call FUNC(switchMagItems);
                };
                case Slot_6: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_6_8] call FUNC(switchMagItems);
                };
                case Slot_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_7_8] call FUNC(switchMagItems);
                };
            };
        };

        
        if (_ammoCount >= SlotsLeft_2D_Min && _ammoCount <= SlotsLeft_2D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_2D_1Min && _ammoCount <= SlotsLeft_2D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_2D_2Min && _ammoCount <= SlotsLeft_2D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_3D_Min && _ammoCount <= SlotsLeft_3D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_3D_1Min && _ammoCount <= SlotsLeft_3D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_2Min && _ammoCount <= SlotsLeft_3D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_3D_3Min && _ammoCount <= SlotsLeft_3D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_3_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_4D_Min && _ammoCount <= SlotsLeft_4D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_4D_1Min && _ammoCount <= SlotsLeft_4D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_2Min && _ammoCount <= SlotsLeft_4D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_4D_3Min && _ammoCount <= SlotsLeft_4D_4Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_3_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_4_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_5D_Min && _ammoCount <= SlotsLeft_5D_Max) exitWith { 

            if (_ammoCount >= SlotsLeft_5D_1Min && _ammoCount <= SlotsLeft_5D_1Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_2_3_4_5: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_4_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_3_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_2_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_2Min && _ammoCount <= SlotsLeft_5D_2Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_1_3_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_3_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_1_4_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_1_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_6: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_5_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_4_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_2_3_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };

            if (_ammoCount >= SlotsLeft_5D_3Min && _ammoCount <= SlotsLeft_5D_3Max) exitWith {
                switch (_ammoCount) do {
                    case Slot_2_4_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_2_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                    case Slot_3_4_5_6_7: { 
                        [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                        [_unit, _mag, _removeContainer, _ammoCount, Slot_3_4_5_6_7_8] call FUNC(switchMagItems);
                    };
                };
            };
        };
        
        
        if (_ammoCount >= SlotsLeft_6D_Min && _ammoCount <= SlotsLeft_7D_Max) exitWith { 

            switch (_ammoCount) do {
                case Slot_1_2_3_4_5_6: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_5_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_6_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_5_6_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_4_5_6_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_3_4_5_6_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_2_3_4_5_6_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_1_2_3_4_5_6_7: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_1_2_3_4_5_6_7_8] call FUNC(switchMagItems);
                };
                case Slot_empty: { 
                    [_unit, _eighthSlotItem_8] call FUNC(arrayToRemoveInvItem);
                    [_unit, _mag, _removeContainer, _ammoCount, Slot_8] call FUNC(switchMagItems);
                };
            };
        };
    };
};

