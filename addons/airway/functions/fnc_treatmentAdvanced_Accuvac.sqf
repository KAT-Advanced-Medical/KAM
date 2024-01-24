#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Head", "Accuvac", objNull, "kat_accuvac"] call kat_airway_fnc_treatmentAdvanced_accuvac;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

if !(_patient getVariable [QGVAR(occluded), false]) exitWith {
    private _output = LLSTRING(Accuvac_NA);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);

    if (_usedItem isEqualTo "kat_suction") then {
        if(GVAR(Suction_reuse)) then {
            _medic addItem "kat_suction";
        };
    };
};

if (_usedItem isEqualTo "kat_suction") then {
    if(GVAR(Suction_reuse)) then {
        _medic addItem "kat_suction";
    };
};

private _treatmentName = LLSTRING(AccuvacTreatment_displayName); //test, comment will be remove after test.
[_patient, _treatmentName] call ACEFUNC(medical_treatment,addToTriageCard);
//[_patient, "Airway Suction"] call ACEFUNC(medical_treatment,addToTriageCard);

private _outputSuccess = LLSTRING(Accuvac_Success);
[_outputSuccess, 1.5, _medic] call ACEFUNC(common,displayTextStructured);

[QGVAR(accuvacLocal), _patient, _patient] call CBA_fnc_targetEvent;
