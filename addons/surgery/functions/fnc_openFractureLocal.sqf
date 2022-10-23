#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_openFractureLocal;
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
    _patient setVariable ["ace_medical_isLimping", false, true];
    [_patient, "blockSprint", "ace_medical_fracture", false] call ace_common_fnc_statusEffect_set;
    [_patient] call ace_medical_engine_fnc_updateDamageEffects;

    [_patient, true] call ace_dragging_fnc_setCarryable;
    [_patient, true] call ace_dragging_fnc_setDraggable;
};

private _output = localize LSTRING(fracture_fail);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;

