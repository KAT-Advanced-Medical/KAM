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
params ["_player", "_medicationType", "_infusionType", "_doseType"];
private _infusionClassName = format ["kat_%1Infusion", _medicationType];
private _baseInfusion = format ["ace_%1_250", _infusionType];
_player removeItem "ace_salineIV_250";
_katClassName = "kat_" + _medicationType;
_player removeItem _katClassName;
_player addItem _infusionClassName;
private _infusionDisplayName = getText (configFile >> "CfgWeapons" >> _infusionClassName >> "displayName");
hint format [LELSTRING(GUI,Prepared_Infusion), _infusionDisplayName];
[{hint ""}, [], 5] call CBA_fnc_waitAndExecute;