#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks the medications in the players inventory and then populates the listbox with the medications,
 *
 * Arguments:
 * none
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_medical_gui_fnc_prepSyringe;
 *
 * Public: No
 */
private _playerMedicalLevel = [_player] call ace_medical_fnc_getMedicLevel;
private _requiredMedicalLevel = GVAR(medLvl_PrepSyringe);
if (_playerMedicalLevel < _requiredMedicalLevel) exitWith {};
private _syringeBox = findDisplay 38580 displayCtrl 71303;
private _medicationBox = findDisplay 38580 displayCtrl 71305;
private _doseCombo = findDisplay 38580 displayCtrl 71307;
private _syringeSelected = lbCurSel _syringeBox;
private _medicationSelected = lbCurSel _medicationBox;
private _doseSelected = lbCurSel _doseCombo;
if (_syringeSelected < 0 || _medicationSelected < 0 || _doseSelected < 0) exitWith {
    hint str LLSTRING(Make_All_Selections);
    [{hint ""}, [], 5] call CBA_fnc_waitAndExecute;
};
private _syringeType = _syringeBox lbData _syringeSelected;
private _medicationType = _medicationBox lbData _medicationSelected;
private _doseType = _doseCombo lbValue _doseSelected;
if (_doseType != 4) then {
    private _syringeClassName = format ["kat_syringe_%1_%2_%3", _medicationType, _syringeType, _doseType];
    private _syringeDisplayName = getText (configFile >> "CfgWeapons" >> _syringeClassName >> "displayName");
    private _hasSyringe = isClass (configFile >> "CfgWeapons" >> _syringeClassName);
    if (!_hasSyringe) exitWith {
        hint format [LLSTRING(No_Syringe_Available), _medicationType, _syringeType, _doseType];
        [{hint ""}, [], 5] call CBA_fnc_waitAndExecute;
    };
    [EGVAR(pharma,prepTime_PrepSyringe), 
        [_medicationType, _syringeType, _doseType],
        {
            params["_args"];
            _args params ["_medicationType", "_syringeType", "_doseType"];
            [_player, _medicationType, _syringeType, _doseType] call EFUNC(pharma,prepareSyringe);
            }, 
            {}, format [LLSTRING(Preparing_Syringe), _syringeDisplayName] ] call ACEFUNC(common,progressBar);
} else {
    private _syringeClassName = format ["kat_%1Infusion", _medicationType];
    private _syringeDisplayName = getText (configFile >> "CfgWeapons" >> _syringeClassName >> "displayName");
    private _hasSyringe = isClass (configFile >> "CfgWeapons" >> _syringeClassName);
    if (!_hasSyringe) exitWith {
        hint format [LLSTRING(No_Syringe_Available), _medicationType, _syringeType, _doseType];
        [{hint ""}, [], 5] call CBA_fnc_waitAndExecute;
    };
    [EGVAR(pharma,prepTime_PrepInfusion), 
        [_medicationType, _syringeType, _doseType],
        {
            params["_args"];
            _args params ["_medicationType", "_syringeType", "_doseType"];
            [_player, _medicationType, _syringeType, _doseType] call EFUNC(pharma,prepareInfusion);
            }, 
            {}, format [LLSTRING(Preparing_Syringe), _syringeDisplayName] ] call ACEFUNC(common,progressBar);
}
