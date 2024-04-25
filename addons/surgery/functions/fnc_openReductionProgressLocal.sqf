#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Progresses the treatment process for a complex fracture
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Current Fracture Status <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", 2.1] call kat_surgery_fnc_openReductionProgressLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_entry"];

if (GVAR(Surgery_ConsciousnessRequirement) == 1 && !(IS_UNCONSCIOUS(_patient))) exitWith {
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
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
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

if (_number == _liveFracture) exitWith {
    switch (_entry) do {
        case (2.1):{
            _surgeryString = LSTRING(EXPOSED);
        };
        case (2.3):{
            _surgeryString = LSTRING(IRRIGATED);
        };
        case (3.3):{
            _surgeryString = LSTRING(CLAMPED);
        };
    };

    [_patient, "quick_view", LSTRING(surgery_log), [[_medic] call ACEFUNC(common,getName), _surgeryString, STRING_BODY_PARTS select _part]] call ACEFUNC(medical_treatment,addToLog);

    _liveFracture = _liveFracture + 0.2;

    if (_reduce) then {
        _liveFracture = _liveFracture + 1;
    };

    _fractureArray set [_part, _liveFracture];
    _patient setVariable [QGVAR(fractures), _fractureArray, true];
};

private _output = LLSTRING(fracture_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
