#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if the patient has a fracture
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Number <NUMBER>
 *
 * Return Value:
 * Fracture <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "1"] call kat_surgery_fnc_fractureCheck
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
