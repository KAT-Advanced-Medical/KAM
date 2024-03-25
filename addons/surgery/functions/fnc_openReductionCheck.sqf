#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to check if a patient has a complex fracture
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Fracture Status <NUMBER>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorObject, "LeftLeg", 3.1] call kat_surgery_fnc_openFractureCheck
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_number"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;

if (_liveFracture > 3) then {
    _liveFracture = _liveFracture - 1;
};

if ((_number == 5) && (_liveFracture == 2 || _liveFracture == 3)) exitWith {true};
if ((_number != 5) && (_liveFracture >= 2.1) && (_liveFracture <= 2.7)) exitWith {true};

false
