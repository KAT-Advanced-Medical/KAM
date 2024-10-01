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

private _syringeType = _syringeBox lbData _syringeSelected;
private _medicationType = _medicationBox lbData _medicationSelected;
private _doseType = _doseCombo lbValue _doseSelected;

[5, [], {
	private _syringeBox = findDisplay 38580 displayCtrl 71303;
	private _medicationBox = findDisplay 38580 displayCtrl 71305;
	private _doseCombo = findDisplay 38580 displayCtrl 71307;

	private _syringeSelected = lbCurSel _syringeBox;
	private _medicationSelected = lbCurSel _medicationBox;
	private _doseSelected = lbCurSel _doseCombo;

	private _syringeType = _syringeBox lbData _syringeSelected;
	private _medicationType = _medicationBox lbData _medicationSelected;
	private _doseType = _doseCombo lbValue _doseSelected;
	

	[player, _medicationType, _syringeType, _doseType] call kat_pharma_fnc_prepareSyringe;}, {}, "Preparing Syringe..."] call ace_common_fnc_progressBar;