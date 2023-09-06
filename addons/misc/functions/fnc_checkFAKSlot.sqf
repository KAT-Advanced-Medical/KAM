#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Checks which slots are free to use in an FAK
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
 * [player, "kat_IFAK_Magazine", 0] call kat_misc_fnc_checkFAKSlot;
 *
 * Public: No
 */

params ["_unit", "_mag", "_slot"];

private _hasTrueValue = [];
private _return = false;
private _itemType = _mag call BIS_fnc_itemType;
_itemType = _itemType select 0;

if (_itemType == "Item") exitWith { 
    if (_mag == "kat_IFAK" || _mag == "kat_AFAK" || _mag == "kat_MFAK") then {
        _return = true;
        _return
    }; 
};

if (_itemType != "Magazine") exitWith {	_return };

private _ammoCount = [_unit, _mag] call FUNC(getMagazineAmmoCounts);

{
    switch (_slot) do {
        case 0: { 
            switch (_x) do {
                case 0: { _hasTrueValue pushback false; };
                default { _hasTrueValue pushback true; };
            };
        };

        case 1: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback true; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback true; };
                        case Slot_1_3: { _hasTrueValue pushback true; };
                        case Slot_1_4: { _hasTrueValue pushback true; };
                        case Slot_1_5: { _hasTrueValue pushback true; };
                        case Slot_1_6: { _hasTrueValue pushback true; };
                        case Slot_1_7: { _hasTrueValue pushback true; };
                        case Slot_1_8: { _hasTrueValue pushback true; };
                        case Slot_2_3: { _hasTrueValue pushback false; };
                        case Slot_2_4: { _hasTrueValue pushback false; };
                        case Slot_2_5: { _hasTrueValue pushback false; };
                        case Slot_2_6: { _hasTrueValue pushback false; };
                        case Slot_2_7: { _hasTrueValue pushback false; };
                        case Slot_2_8: { _hasTrueValue pushback false; };
                        case Slot_3_4: { _hasTrueValue pushback false; };
                        case Slot_3_5: { _hasTrueValue pushback false; };
                        case Slot_3_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback false; };
                        case Slot_3_8: { _hasTrueValue pushback false; };
                        case Slot_4_5: { _hasTrueValue pushback false; };
                        case Slot_4_6: { _hasTrueValue pushback false; };
                        case Slot_4_7: { _hasTrueValue pushback false; };
                        case Slot_4_8: { _hasTrueValue pushback false; };
                        case Slot_5_6: { _hasTrueValue pushback false; };
                        case Slot_5_7: { _hasTrueValue pushback false; };
                        case Slot_5_8: { _hasTrueValue pushback false; };
                        case Slot_6_7: { _hasTrueValue pushback false; };
                        case Slot_6_8: { _hasTrueValue pushback false; };
                        case Slot_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback true; };
                        case Slot_1_2_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback false; };
                };
            };
        };



        case 2: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback true; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback true; };
                        case Slot_1_3: { _hasTrueValue pushback false; };
                        case Slot_1_4: { _hasTrueValue pushback false; };
                        case Slot_1_5: { _hasTrueValue pushback false; };
                        case Slot_1_6: { _hasTrueValue pushback false; };
                        case Slot_1_7: { _hasTrueValue pushback false; };
                        case Slot_1_8: { _hasTrueValue pushback false; };
                        case Slot_2_3: { _hasTrueValue pushback true; };
                        case Slot_2_4: { _hasTrueValue pushback true; };
                        case Slot_2_5: { _hasTrueValue pushback true; };
                        case Slot_2_6: { _hasTrueValue pushback true; };
                        case Slot_2_7: { _hasTrueValue pushback true; };
                        case Slot_2_8: { _hasTrueValue pushback true; };
                        case Slot_3_4: { _hasTrueValue pushback false; };
                        case Slot_3_5: { _hasTrueValue pushback false; };
                        case Slot_3_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback false; };
                        case Slot_3_8: { _hasTrueValue pushback false; };
                        case Slot_4_5: { _hasTrueValue pushback false; };
                        case Slot_4_6: { _hasTrueValue pushback false; };
                        case Slot_4_7: { _hasTrueValue pushback false; };
                        case Slot_4_8: { _hasTrueValue pushback false; };
                        case Slot_5_6: { _hasTrueValue pushback false; };
                        case Slot_5_7: { _hasTrueValue pushback false; };
                        case Slot_5_8: { _hasTrueValue pushback false; };
                        case Slot_6_7: { _hasTrueValue pushback false; };
                        case Slot_6_8: { _hasTrueValue pushback false; };
                        case Slot_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback true; };
                        case Slot_1_2_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback false; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };



        case 3: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback true; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback false; };
                        case Slot_1_3: { _hasTrueValue pushback true; };
                        case Slot_1_4: { _hasTrueValue pushback false; };
                        case Slot_1_5: { _hasTrueValue pushback false; };
                        case Slot_1_6: { _hasTrueValue pushback false; };
                        case Slot_1_7: { _hasTrueValue pushback false; };
                        case Slot_1_8: { _hasTrueValue pushback false; };
                        case Slot_2_3: { _hasTrueValue pushback true; };
                        case Slot_2_4: { _hasTrueValue pushback false; };
                        case Slot_2_5: { _hasTrueValue pushback false; };
                        case Slot_2_6: { _hasTrueValue pushback false; };
                        case Slot_2_7: { _hasTrueValue pushback false; };
                        case Slot_2_8: { _hasTrueValue pushback false; };
                        case Slot_3_4: { _hasTrueValue pushback true; };
                        case Slot_3_5: { _hasTrueValue pushback true; };
                        case Slot_3_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback true; };
                        case Slot_3_8: { _hasTrueValue pushback true; };
                        case Slot_4_5: { _hasTrueValue pushback false; };
                        case Slot_4_6: { _hasTrueValue pushback false; };
                        case Slot_4_7: { _hasTrueValue pushback false; };
                        case Slot_4_8: { _hasTrueValue pushback false; };
                        case Slot_5_6: { _hasTrueValue pushback false; };
                        case Slot_5_7: { _hasTrueValue pushback false; };
                        case Slot_5_8: { _hasTrueValue pushback false; };
                        case Slot_6_7: { _hasTrueValue pushback false; };
                        case Slot_6_8: { _hasTrueValue pushback false; };
                        case Slot_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback true; };
                        case Slot_1_2_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback false; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };



        case 4: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback true; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback false; };
                        case Slot_1_3: { _hasTrueValue pushback false; };
                        case Slot_1_4: { _hasTrueValue pushback true; };
                        case Slot_1_5: { _hasTrueValue pushback false; };
                        case Slot_1_6: { _hasTrueValue pushback false; };
                        case Slot_1_7: { _hasTrueValue pushback false; };
                        case Slot_1_8: { _hasTrueValue pushback false; };
                        case Slot_2_3: { _hasTrueValue pushback false; };
                        case Slot_2_4: { _hasTrueValue pushback true; };
                        case Slot_2_5: { _hasTrueValue pushback false; };
                        case Slot_2_6: { _hasTrueValue pushback false; };
                        case Slot_2_7: { _hasTrueValue pushback false; };
                        case Slot_2_8: { _hasTrueValue pushback false; };
                        case Slot_3_4: { _hasTrueValue pushback true; };
                        case Slot_3_5: { _hasTrueValue pushback false; };
                        case Slot_3_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback false; };
                        case Slot_3_8: { _hasTrueValue pushback false; };
                        case Slot_4_5: { _hasTrueValue pushback true; };
                        case Slot_4_6: { _hasTrueValue pushback true; };
                        case Slot_4_7: { _hasTrueValue pushback true; };
                        case Slot_4_8: { _hasTrueValue pushback true; };
                        case Slot_5_6: { _hasTrueValue pushback false; };
                        case Slot_5_7: { _hasTrueValue pushback false; };
                        case Slot_5_8: { _hasTrueValue pushback false; };
                        case Slot_6_7: { _hasTrueValue pushback false; };
                        case Slot_6_8: { _hasTrueValue pushback false; };
                        case Slot_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback false; };
                        case Slot_1_2_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback false; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };


        
        case 5: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback true; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback false; };
                        case Slot_1_3: { _hasTrueValue pushback false; };
                        case Slot_1_4: { _hasTrueValue pushback false; };
                        case Slot_1_5: { _hasTrueValue pushback true; };
                        case Slot_1_6: { _hasTrueValue pushback false; };
                        case Slot_1_7: { _hasTrueValue pushback false; };
                        case Slot_1_8: { _hasTrueValue pushback false; };
                        case Slot_2_3: { _hasTrueValue pushback false; };
                        case Slot_2_4: { _hasTrueValue pushback false; };
                        case Slot_2_5: { _hasTrueValue pushback true; };
                        case Slot_2_6: { _hasTrueValue pushback false; };
                        case Slot_2_7: { _hasTrueValue pushback false; };
                        case Slot_2_8: { _hasTrueValue pushback false; };
                        case Slot_3_4: { _hasTrueValue pushback false; };
                        case Slot_3_5: { _hasTrueValue pushback true; };
                        case Slot_3_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback false; };
                        case Slot_3_8: { _hasTrueValue pushback false; };
                        case Slot_4_5: { _hasTrueValue pushback true; };
                        case Slot_4_6: { _hasTrueValue pushback false; };
                        case Slot_4_7: { _hasTrueValue pushback false; };
                        case Slot_4_8: { _hasTrueValue pushback false; };
                        case Slot_5_6: { _hasTrueValue pushback true; };
                        case Slot_5_7: { _hasTrueValue pushback true; };
                        case Slot_5_8: { _hasTrueValue pushback true; };
                        case Slot_6_7: { _hasTrueValue pushback false; };
                        case Slot_6_8: { _hasTrueValue pushback false; };
                        case Slot_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback false; };
                        case Slot_1_2_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback false; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };



        case 6: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback true; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback false; };
                        case Slot_1_3: { _hasTrueValue pushback false; };
                        case Slot_1_4: { _hasTrueValue pushback false; };
                        case Slot_1_5: { _hasTrueValue pushback false; };
                        case Slot_1_6: { _hasTrueValue pushback true; };
                        case Slot_1_7: { _hasTrueValue pushback false; };
                        case Slot_1_8: { _hasTrueValue pushback false; };
                        case Slot_2_3: { _hasTrueValue pushback false; };
                        case Slot_2_4: { _hasTrueValue pushback false; };
                        case Slot_2_5: { _hasTrueValue pushback false; };
                        case Slot_2_6: { _hasTrueValue pushback true; };
                        case Slot_2_7: { _hasTrueValue pushback false; };
                        case Slot_2_8: { _hasTrueValue pushback false; };
                        case Slot_3_4: { _hasTrueValue pushback false; };
                        case Slot_3_5: { _hasTrueValue pushback false; };
                        case Slot_3_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback false; };
                        case Slot_3_8: { _hasTrueValue pushback false; };
                        case Slot_4_5: { _hasTrueValue pushback false; };
                        case Slot_4_6: { _hasTrueValue pushback true; };
                        case Slot_4_7: { _hasTrueValue pushback false; };
                        case Slot_4_8: { _hasTrueValue pushback false; };
                        case Slot_5_6: { _hasTrueValue pushback true; };
                        case Slot_5_7: { _hasTrueValue pushback false; };
                        case Slot_5_8: { _hasTrueValue pushback false; };
                        case Slot_6_7: { _hasTrueValue pushback true; };
                        case Slot_6_8: { _hasTrueValue pushback true; };
                        case Slot_7_8: { _hasTrueValue pushback false; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback false; };
                        case Slot_1_2_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_7_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback false; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };



        case 7: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback true; };
                    case Slot_8: { _hasTrueValue pushback false; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback false; };
                        case Slot_1_3: { _hasTrueValue pushback false; };
                        case Slot_1_4: { _hasTrueValue pushback false; };
                        case Slot_1_5: { _hasTrueValue pushback false; };
                        case Slot_1_6: { _hasTrueValue pushback false; };
                        case Slot_1_7: { _hasTrueValue pushback true; };
                        case Slot_1_8: { _hasTrueValue pushback false; };
                        case Slot_2_3: { _hasTrueValue pushback false; };
                        case Slot_2_4: { _hasTrueValue pushback false; };
                        case Slot_2_5: { _hasTrueValue pushback false; };
                        case Slot_2_6: { _hasTrueValue pushback false; };
                        case Slot_2_7: { _hasTrueValue pushback true; };
                        case Slot_2_8: { _hasTrueValue pushback false; };
                        case Slot_3_4: { _hasTrueValue pushback false; };
                        case Slot_3_5: { _hasTrueValue pushback false; };
                        case Slot_3_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback true; };
                        case Slot_3_8: { _hasTrueValue pushback false; };
                        case Slot_4_5: { _hasTrueValue pushback false; };
                        case Slot_4_6: { _hasTrueValue pushback false; };
                        case Slot_4_7: { _hasTrueValue pushback true; };
                        case Slot_4_8: { _hasTrueValue pushback false; };
                        case Slot_5_6: { _hasTrueValue pushback false; };
                        case Slot_5_7: { _hasTrueValue pushback true; };
                        case Slot_5_8: { _hasTrueValue pushback false; };
                        case Slot_6_7: { _hasTrueValue pushback true; };
                        case Slot_6_8: { _hasTrueValue pushback false; };
                        case Slot_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback false; };
                        case Slot_1_2_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_7_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_6: { _hasTrueValue pushback true; };
                        case Slot_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_7_8: { _hasTrueValue pushback false; };
                        case Slot_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_5_7_8: { _hasTrueValue pushback false; };
                        case Slot_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback false; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };



        case 8: { 

            // 1 Slot left
            if (_x >= SlotsLeft_1D_Min && _x <= SlotsLeft_1D_Max) then { 
                switch (_x) do {
                    case Slot_1: { _hasTrueValue pushback false; };
                    case Slot_2: { _hasTrueValue pushback false; };
                    case Slot_3: { _hasTrueValue pushback false; };
                    case Slot_4: { _hasTrueValue pushback false; };
                    case Slot_5: { _hasTrueValue pushback false; };
                    case Slot_6: { _hasTrueValue pushback false; };
                    case Slot_7: { _hasTrueValue pushback false; };
                    case Slot_8: { _hasTrueValue pushback true; };
                };
            };

            // 2 Slots left
            if (_x >= SlotsLeft_2D_Min && _x <= SlotsLeft_2D_Max) then { 

                if (_x >= SlotsLeft_2D_1Min && _x <= SlotsLeft_2D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2: { _hasTrueValue pushback false; };
                        case Slot_1_3: { _hasTrueValue pushback false; };
                        case Slot_1_4: { _hasTrueValue pushback false; };
                        case Slot_1_5: { _hasTrueValue pushback false; };
                        case Slot_1_6: { _hasTrueValue pushback false; };
                        case Slot_1_7: { _hasTrueValue pushback false; };
                        case Slot_1_8: { _hasTrueValue pushback true; };
                        case Slot_2_3: { _hasTrueValue pushback false; };
                        case Slot_2_4: { _hasTrueValue pushback false; };
                        case Slot_2_5: { _hasTrueValue pushback false; };
                        case Slot_2_6: { _hasTrueValue pushback false; };
                        case Slot_2_7: { _hasTrueValue pushback false; };
                        case Slot_2_8: { _hasTrueValue pushback true; };
                        case Slot_3_4: { _hasTrueValue pushback false; };
                        case Slot_3_5: { _hasTrueValue pushback false; };
                        case Slot_3_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_2D_2Min && _x <= SlotsLeft_2D_2Max) then {
                    switch (_x) do {
                        case Slot_3_7: { _hasTrueValue pushback false; };
                        case Slot_3_8: { _hasTrueValue pushback true; };
                        case Slot_4_5: { _hasTrueValue pushback false; };
                        case Slot_4_6: { _hasTrueValue pushback false; };
                        case Slot_4_7: { _hasTrueValue pushback false; };
                        case Slot_4_8: { _hasTrueValue pushback true; };
                        case Slot_5_6: { _hasTrueValue pushback false; };
                        case Slot_5_7: { _hasTrueValue pushback false; };
                        case Slot_5_8: { _hasTrueValue pushback true; };
                        case Slot_6_7: { _hasTrueValue pushback false; };
                        case Slot_6_8: { _hasTrueValue pushback true; };
                        case Slot_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 3 Slots left
            if (_x >= SlotsLeft_3D_Min && _x <= SlotsLeft_3D_Max) then { 

                if (_x >= SlotsLeft_3D_1Min && _x <= SlotsLeft_3D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3: { _hasTrueValue pushback false; };
                        case Slot_1_2_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_3D_2Min && _x <= SlotsLeft_3D_2Max) then {
                    switch (_x) do {
                        case Slot_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_3D_3Min && _x <= SlotsLeft_3D_3Max) then {
                    switch (_x) do {
                        case Slot_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 4 Slots left 
            if (_x >= SlotsLeft_4D_Min && _x <= SlotsLeft_4D_Max) then { 

                if (_x >= SlotsLeft_4D_1Min && _x <= SlotsLeft_4D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_4D_2Min && _x <= SlotsLeft_4D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_5_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_3Min && _x <= SlotsLeft_4D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_4D_4Min && _x <= SlotsLeft_4D_4Max) then {
                    switch (_x) do {
                        case Slot_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 5 Slots left
            if (_x >= SlotsLeft_5D_Min && _x <= SlotsLeft_5D_Max) then { 

                if (_x >= SlotsLeft_5D_1Min && _x <= SlotsLeft_5D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_5D_2Min && _x <= SlotsLeft_5D_2Max) then {
                    switch (_x) do {
                        case Slot_1_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7: { _hasTrueValue pushback false; };
                    };
                };

                if (_x >= SlotsLeft_5D_3Min && _x <= SlotsLeft_5D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };
            
            // 6 Slot left
            if (_x >= SlotsLeft_6D_Min && _x <= SlotsLeft_6D_Max) then { 

                if (_x >= SlotsLeft_6D_1Min && _x <= SlotsLeft_6D_1Max) then {
                    switch (_x) do {
                        case Slot_1_2_3_4_5_6: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_5_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_5_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_4_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_4_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_3_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_3_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_2_4_5_6_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_2Min && _x <= SlotsLeft_6D_2Max) then {
                    switch (_x) do {
                        case Slot_1_2_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_2_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_1_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_1_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };

                if (_x >= SlotsLeft_6D_3Min && _x <= SlotsLeft_6D_3Max) then {
                    switch (_x) do {
                        case Slot_2_3_4_5_6_7: { _hasTrueValue pushback false; };
                        case Slot_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                        case Slot_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    };
                };
            };

            // 7 Slots left
            if (_x >= SlotsLeft_7D_Min && _x <= SlotsLeft_7D_Max) then { 

                switch (_x) do {
                    case Slot_1_2_3_4_5_6_7: { _hasTrueValue pushback false; };
                    case Slot_1_2_3_4_5_6_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_5_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_4_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_3_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_2_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_1_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                    case Slot_2_3_4_5_6_7_8: { _hasTrueValue pushback true; };
                };
            };
        };
    };

} forEach _ammoCount;

{
    if (_x == true) exitWith {
        _return = true;
        _return
    };
} forEach _hasTrueValue;

_return
