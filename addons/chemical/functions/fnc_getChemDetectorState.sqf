#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Is On/Off <BOOL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_getChemDetectorState;
 *
 * Public: No
*/
params ["_unit", "_isOnOff"];

private _currentState = _unit getVariable [QGVAR(chemDetectorState), false];

[false, true] select ("ChemicalDetector_01_watch_F" in (assigneditems _unit) && _currentState == _isOnOff);