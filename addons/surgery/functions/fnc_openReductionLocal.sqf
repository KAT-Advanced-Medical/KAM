#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to remove the fracture status from an open fracture
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_openReductionLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _activeFracture = GET_FRACTURES(_patient);
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;

if ((_liveFracture == 2.5) || (_liveFracture == 3.5)) exitWith {
    _liveFracture = 0;

    _activeFracture set [_part, _liveFracture];
    _fractureArray set [_part, _liveFracture];

    _patient setVariable [QGVAR(fractures), _fractureArray, true];
    _patient setVariable [VAR_FRACTURES, _activeFracture, true];
    _patient setVariable [QACEGVAR(medical,isLimping), false, true];
    [_patient, "blockSprint", QACEGVAR(medical,fracture), false] call ACEFUNC(common,statusEffect_set);
    [_patient] call ACEFUNC(medical_engine,updateDamageEffects);

    [_patient, true] call ACEFUNC(dragging,setCarryable);
    [_patient, true] call ACEFUNC(dragging,setDraggable);
};

private _output = LLSTRING(fracture_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
