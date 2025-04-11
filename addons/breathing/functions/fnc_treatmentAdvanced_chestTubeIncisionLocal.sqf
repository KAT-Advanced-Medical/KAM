#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to start the surgical process for a chest tube
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 1] call kat_breathing_treatmentAdvanced_chestTubeIncisionLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

if (GVAR(SchestTube_ConsciousnessRequirement) == 1 && !(IS_UNCONSCIOUS(_patient))) exitWith {
    private _output = LLSTRING(chest_tube_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};
private _lidocaineCount = [_patient, "Lidocaine", false] call ACEFUNC(medical_status,getMedicationCount);
private _morphineCount = [_patient, "Morphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount = [_patient, "Nalbuphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount = [_patient, "Fentanyl", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount = [_patient, "Ketamine", false] call ACEFUNC(medical_status,getMedicationCount);
if ((_lidocaineCount <=  0.6 && _morphineCount <=  0.8 && _nalbuphineCount <=  0.8 && _fentanylCount <=  0.8 && _ketamineCount <=  0.8) || !IS_UNCONSCIOUS(_patient)) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] call ACEFUNC(medical_status,adjustPainLevel);
};

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveTube = _chestTubeArray select _side;

_liveTube = _liveTube + 0.1;
_chestTubeArray set [_side, _liveTube];
_patient setVariable [QGVAR(chestTube), _chestTubeArray, true];

[_patient, false] call ACEFUNC(dragging,setCarryable);
[_patient, false] call ACEFUNC(dragging,setDraggable);

[_patient, "quick_view", LSTRING(incision_log), [[_medic] call ACEFUNC(common,getName), STRING_BODY_PARTS select 1]] call ACEFUNC(medical_treatment,addToLog);

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_side"];

    private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
    private _liveTube = _chestTubeArray select _side;
    private _count = [_patient, "Etomidate", true] call ACEFUNC(medical_status,getMedicationCount);

    private _alive = alive _patient;

    if ((!_alive) || (_liveTube == 0)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable [QGVAR(etomidate_Pain), false]
    };

    if (((GVAR(ChestTube_ConsciousnessRequirement) in [0,1]) && (!(IS_UNCONSCIOUS(_patient))) && (_count <= 0.2)) || (GVAR(Surgery_ConsciousnessRequirement) == 3 && _count <= 0.2)) exitWith {
        if !(_patient getVariable [QGVAR(etomidate_Pain), false]) then {
            [_patient, "Pain", 2, 10, 120, 0.6, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
            _patient setVariable [QGVAR(etomidate_Pain), true]};
        [_patient, true] call ACEFUNC(medical,setUnconscious);
    };

    if (GVAR(ChestTube_ConsciousnessRequirement) == 2 && _count <= 0.2) then {
        if !(_patient getVariable [QGVAR(etomidate_Pain), false]) then {
            [_patient, "Pain", 2, 10, 120, 0.6, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
            _patient setVariable [QGVAR(etomidate_Pain), true]
        };
    };
}, 5, [_patient, _side]] call CBA_fnc_addPerFrameHandler;

