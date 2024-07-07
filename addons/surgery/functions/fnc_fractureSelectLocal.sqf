#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to select the patient's fracture state
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_fractureSelectLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;
private _fractureString = "";

if (_liveFracture != 0) exitWith {

    if (_liveFracture >= 3) then  {
        _fractureString = LSTRING(COMMINUTED_FRACTURE);
    };

    if (_liveFracture >= 2 && _liveFracture < 3) then {
        _fractureString = LSTRING(COMPOUND_FRACTURE);
    };

    if (_liveFracture == 1) then {
        _fractureString = LSTRING(SIMPLE_FRACTURE);
    };
    [_patient, "quick_view", LSTRING(fracture_log), [_fractureString, STRING_BODY_PARTS select _part]] call ACEFUNC(medical_treatment,addToLog);
};

if (random 100 <= GVAR(simpleChance)) then {
    _liveFracture = 1;
    _fractureString = LSTRING(SIMPLE_FRACTURE);
} else {
    if (random 100 <= GVAR(compoundChance)) then {
        _liveFracture = 2;
        _fractureString = LSTRING(COMPOUND_FRACTURE);
    } else {
        _liveFracture = 3;
        _fractureString = LSTRING(COMMINUTED_FRACTURE);
    };
};

[_patient, "quick_view", LSTRING(fracture_log), [_fractureString, STRING_BODY_PARTS select _part]] call ACEFUNC(medical_treatment,addToLog);
_fractureArray set [_part, _liveFracture];

_patient setVariable [QGVAR(fractures), _fractureArray, true];
