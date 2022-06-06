#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_fractureCheck;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_number"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _activeFracture = GET_FRACTURES(_patient);

if (_number == 5 && (_activeFracture select _part) != 0) exitWith {true};

private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;

if ((_liveFracture == 1) && (_number == 1)) exitWith {true};
if ((_liveFracture == _number) || ((_liveFracture == _number + 1) && (_number != 1))) exitWith {true};

false
