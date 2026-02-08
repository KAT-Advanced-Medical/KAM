#define DEBUG_MODE_FULL
#include "..\script_component.hpp"
/*
 * Author: Katalam, modified by Cplhardcore
 * Removes a Saline Bag and a given medication and
 * returns a "crafted" Infusion with fluid 
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Class name of medication <STRING>
 * 2: infusion type <STRING>
 * 3: Dose type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "TXA", "5ml", "1"] call kat_pharma_fnc_prepareInfusion;
 *
 * Public: No
 */

params ["_player", "_medicationType", "_infusionClassName", "_size"];
TRACE_1("Size",_size);
if (_size == "100") then {
    _player removeItem "kat_salineIV100";
} else {
    _player removeItem "ace_salineIV_250";
};
private _katClassName = "kat_" + _medicationType;
_player removeItem _katClassName;
_player addItem _infusionClassName;
private _infusionDisplayName = getText (configFile >> "CfgWeapons" >> _infusionClassName >> "displayName");
private _name = format [LELSTRING(GUI,Prepared_Infusion), _infusionDisplayName];
[_name, 2, _player, 10] call ACEFUNC(common,displayTextStructured);