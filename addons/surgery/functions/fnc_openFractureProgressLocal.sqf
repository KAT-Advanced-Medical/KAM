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

params ["_medic", "_patient", "_bodyPart", "_entry"];

if !(IS_UNCONSCIOUS(_patient)) exitWith {
    private _output = localize LSTRING(fracture_fail);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;
private _surgeryString = "";
private _number = _entry;
private _reduce = false;
private _subReduce = false;

if (_liveFracture > 3) then {
    _liveFracture = _liveFracture - 1;
    _reduce = true;

    if (_number > 3) then {
        _number = _number - 1;
        _subReduce = true;
    };
};

if (_entry == 2.3 && _reduce) exitWith {
    private _output = localize LSTRING(fracture_fail);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

if (_number == _liveFracture) exitWith {
    switch (true) do {
        case (_entry == 2.1): {
        _surgeryString = "exposed";
        };
        case (_entry == 2.3): {
        _surgeryString = "irrigated";
        };
        case (_entry == 3.3): {
        _surgeryString = "clamped";
        };
    };

    [_patient, "quick_view", LSTRING(surgery_log), [[_medic] call ace_common_fnc_getName, _surgeryString, STRING_BODY_PARTS select _part]] call ace_medical_treatment_fnc_addToLog;  

    _liveFracture = _liveFracture + 0.2;

    if (_reduce == true) then {
        _liveFracture = _liveFracture + 1;
    };

    _fractureArray set [_part, _liveFracture];
    _patient setVariable [QGVAR(fractures), _fractureArray, true];
};

private _output = localize LSTRING(fracture_fail);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;