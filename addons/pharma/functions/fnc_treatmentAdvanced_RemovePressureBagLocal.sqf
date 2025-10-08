#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_ManualBagPressure;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _pressureBag = _patient getVariable [QGVAR(pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]];
_pressureBag set [_partIndex, 0];
_patient setVariable [QGVAR(pressureBag), _pressureBag, true];
[_medic, "kat_pressureBag"] call ACEFUNC(common,addToInventory);
