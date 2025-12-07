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

private _canStop = false;
private _partIndex = ALL_BODY_PARTS find _bodyPart;
private _oldPartArray = _medic getVariable [QGVAR(pressureApplied), [-1, objNull]];
private _oldPartIndex = _oldPartArray select 0;
private _oldPartUnit  = _oldPartArray select 1;
if ((_oldPartIndex != -1) && (_oldPartIndex == _partIndex) && (!(GVAR(hardcorePressure))) && (_patient == _oldPartUnit)) then {
    _canStop = true;
};

_canStop