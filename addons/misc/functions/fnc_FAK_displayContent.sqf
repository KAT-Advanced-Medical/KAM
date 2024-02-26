#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Displays FAK items to player
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: FAK Type <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0] call kat_misc_fnc_FAK_displayContent;
 *
 * Public: No
 */

params ["_unit", "_fakType"];

if (_unit != ACE_player) exitWith {};

private _fakContent = "";
private _outputString = "";
private _mainOutputString = "";
private _ultraMainOutputString = "";
private _slot = 0;
private _firstnline = "";
private _nline = "<br/>";
private _itemColor = "";
private _slotColor = "";
private _slotNameArray = missionNameSpace getVariable [QGVAR(FAKSlotNames), []];
private _slotName = "";

private _fnc_arrayToHexCode = {
    params ["_array"];

    private _return = "";
    private _hashtag = "";
    private _hexCode = "";
    private _count = 0;

    {
        _count = _count + 1;
        _x = _x * 255;
        _hexCode  = [_x] call ace_common_fnc_toHex;
        if (_count == 3) then { _hashtag = "#"; };
        _return = _hashtag + _return + _hexCode; 
    } forEach _array; //Get correct Hex color code
    
    _return
};

switch (_fakType) do {
    case 0: { 
        _fakContent = missionNameSpace getVariable [QGVAR(IFAKContents), []];
        _slotColor = [(missionNameSpace getVariable [QGVAR(IFAK_Slot_Color), []])] call _fnc_arrayToHexCode;
        _itemColor = [(missionNameSpace getVariable [QGVAR(IFAK_Item_Color), []])] call _fnc_arrayToHexCode;
    };
    case 1: { 
        _fakContent = missionNameSpace getVariable [QGVAR(AFAKContents), []];
        _slotColor = [(missionNameSpace getVariable [QGVAR(AFAK_Slot_Color), []])] call _fnc_arrayToHexCode;
        _itemColor = [(missionNameSpace getVariable [QGVAR(AFAK_Item_Color), []])] call _fnc_arrayToHexCode;
    };
    default { 
        _fakContent = missionNameSpace getVariable [QGVAR(MFAKContents), []];
        _slotColor = [(missionNameSpace getVariable [QGVAR(MFAK_Slot_Color), []])] call _fnc_arrayToHexCode;
        _itemColor = [(missionNameSpace getVariable [QGVAR(MFAK_Item_Color), []])] call _fnc_arrayToHexCode;
    };
};

{
    {
    
        private _item = _x select 0; // Item
        private _number = str (_x select 1); // Number
        private _config = _item call CBA_fnc_getItemConfig; // get item config location
        private _displayName = getText (_config >> "displayName"); // get item displayName
        if (_displayName == "") then { _displayName = _item; }; // if no entry is found display class name
        _outputString = "<t color='" + _itemColor + "'>" + _number + "x " + _displayName + " </t>";
        _mainOutputString = _mainOutputString + _nline + _outputString;
        
    } forEach _x; // for each item & number in slot x

    _slot = _slot + 1;
    switch (_slot) do {
        case 1: { _slotName = _slotNameArray select 0; };
        case 2: { _slotName = _slotNameArray select 1; };
        case 3: { _slotName = _slotNameArray select 2; };
        case 4: { _slotName = _slotNameArray select 3; };
        case 5: { _slotName = _slotNameArray select 4; };
        case 6: { _slotName = _slotNameArray select 5; };
        case 7: { _slotName = _slotNameArray select 6; };
        case 8: { _slotName = _slotNameArray select 7; };
    };

    if (_slot > 1) then {_firstnline = _nline};
    _mainOutputString = _firstnline + "<t color='" + _slotColor + "'><t size='1.5'>" + _slotName + " </t></t>" + _mainOutputString + _nline;
    _mainOutputString = format [_mainOutputString, _slot];
    _ultraMainOutputString = _ultraMainOutputString + _mainOutputString;
    _mainOutputString = "";

} forEach _fakContent; // for each slot
        
hintSilent parseText _ultraMainOutputString;
