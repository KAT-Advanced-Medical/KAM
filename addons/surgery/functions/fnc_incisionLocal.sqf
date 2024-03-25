#include "..\script_component.hpp"
/*
 * Author: Mazinski
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

if (GVAR(Surgery_ConsciousnessRequirement) == 1 && !(IS_UNCONSCIOUS(_patient))) exitWith {
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
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

    if ((GVAR(Surgery_ConsciousnessRequirement) == 0 && (!(IS_UNCONSCIOUS(_patient)) || _count == 0)) || (GVAR(Surgery_ConsciousnessRequirement) == 3 && _count == 0)) exitWith {
        [_patient, "Pain", 10, 40, 200, 0, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
        [_patient, true] call ACEFUNC(medical,setUnconscious);
    };

    if (GVAR(Surgery_ConsciousnessRequirement) == 2 && _count == 0) then {
        [_patient, 0.4] call ACEFUNC(medical_status,adjustPainLevel);
        [_patient, "Pain", 10, 40, 30, 0, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
    };

}, GVAR(etomidateTime), [_patient, _part]] call CBA_fnc_addPerFrameHandler;
