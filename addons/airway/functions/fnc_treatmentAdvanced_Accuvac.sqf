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

    if (_usedItem isEqualTo "kat_suction" && GVAR(Suction_reuse)) then {
        [_medic, "kat_suction"] call ACEFUNC(common,addToInventory);
    };
};

if (_usedItem isEqualTo "kat_suction" && GVAR(Suction_reuse)) then {
    [_medic, "kat_suction"] call ACEFUNC(common,addToInventory);
};

[_patient, LLSTRING(AccuvacTreatment_displayName)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", LSTRING(Suction_Log), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);
[LLSTRING(Accuvac_Success), 1.5, _medic] call ACEFUNC(common,displayTextStructured);

[QGVAR(accuvacLocal), _patient, _patient] call CBA_fnc_targetEvent;
