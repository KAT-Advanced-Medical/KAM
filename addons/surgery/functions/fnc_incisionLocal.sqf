#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Local call to start the surgical process for a fracture
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_incisionLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (GVAR(uncon_requieredForAction)) then {
    if !(IS_UNCONSCIOUS(_patient)) exitWith {
        private _output = LLSTRING(fracture_fail);
        [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    };
};


private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;

_liveFracture = _liveFracture + 0.1;
_fractureArray set [_part, _liveFracture];
_patient setVariable [QGVAR(fractures), _fractureArray, true];

[_patient, false] call ACEFUNC(dragging,setCarryable);
[_patient, false] call ACEFUNC(dragging,setDraggable);

[_patient, "quick_view", LSTRING(incision_log), [[_medic] call ACEFUNC(common,getName), STRING_BODY_PARTS select _part]] call ACEFUNC(medical_treatment,addToLog);  

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_part"];

    private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
    private _liveFracture = _fractureArray select _part;
    private _count = [_patient, "Etomidate"] call ACEFUNC(medical_status,getMedicationCount);

    private _alive = alive _patient;

    if ((!_alive) || (_liveFracture == 0)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (_count == 0 || !(IS_UNCONSCIOUS(_patient))) then {
        [_patient, "Pain", 10, 40, 200, 0, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
        [_target, true] call ACEFUNC(medical,setUnconscious);
    };

}, GVAR(etomidateTime), [_patient, _part]] call CBA_fnc_addPerFrameHandler;