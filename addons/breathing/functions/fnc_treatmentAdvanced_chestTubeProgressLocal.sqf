#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Progresses the treatment process for a chest Tube
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Current Fracture Status <NUMBER>
 * 3: Side <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 0.1, 1] call kat_breathing_fnc_treatmentAdvanced_chestTubeProgressLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_entry", "_side"];

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveTube = _chestTubeArray select _side;
private _surgeryString = "";
private _number = _entry;

private _lidocaineCount = [_patient, "Lidocaine", false] call ACEFUNC(medical_status,getMedicationCount);
private _morphineCount = [_patient, "Morphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount = [_patient, "Nalbuphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount = [_patient, "Fentanyl", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount = [_patient, "Ketamine", false] call ACEFUNC(medical_status,getMedicationCount);
if ((_lidocaineCount <=  0.6 && _morphineCount <=  0.8 && _nalbuphineCount <=  0.8 && _fentanylCount <=  0.8 && _ketamineCount <=  0.8) || !IS_UNCONSCIOUS(_patient)) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] call ACEFUNC(medical_status,adjustPainLevel);
};

if (_number == _liveTube) exitWith {
    switch (_entry) do {
        case (0.1):{
            _surgeryString = LSTRING(SPREAD);
        };
        case (0.3):{
            _surgeryString = LSTRING(PREPARED);
        };
    };

    [_patient, "quick_view", LSTRING(ChestTube_log), [[_medic] call ACEFUNC(common,getName), _surgeryString, STRING_BODY_PARTS select 1]] call ACEFUNC(medical_treatment,addToLog);

    _liveTube = _liveTube + 0.2;

    _chestTubeArray set [_side, _liveTube];
    _patient setVariable [QGVAR(chestTube), _chestTubeArray, true];
};

private _output = LLSTRING(chest_tube_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
