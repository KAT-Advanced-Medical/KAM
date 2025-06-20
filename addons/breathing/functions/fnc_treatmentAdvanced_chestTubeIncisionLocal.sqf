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

if (GVAR(chestTube_ConsciousnessRequirement) == 1 && !(IS_UNCONSCIOUS(_patient))) exitWith {
    private _output = LLSTRING(chest_tube_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};
private _medStack = _patient call ACEFUNC(medical_treatment,getAllMedicationCount);
private _medsToCheck = ["fentanyl", "ketamine", "nalbuphine", "morphine"];
private _fentanylEffectiveness = 0;
private _ketamineEffectiveness = 0;
private _nalbuphineEffectiveness = 0;
private _morphineEffectiveness = 0;
private _localAnesthesia = (_patient getVariable [QEGVAR(pharma,localAnesthesia), [0,0,0,0,0,0,0,0,0,0,0,0]]) select 2;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("fentanyl" in _medName) then {
        _fentanylEffectiveness = _fentanylEffectiveness max _effectiveness;
    };
    if ("ketamine" in _medName) then {
        _ketamineEffectiveness = _ketamineEffectiveness max _effectiveness;
    };
    if ("nalbuphine" in _medName) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
    };
    if ("morphine" in _medName) then {
        _morphineEffectiveness = _morphineEffectiveness max _effectiveness;
    };
    } forEach _medStack;
    if (
        _fentanylEffectiveness <= 0.8 &&
        _ketamineEffectiveness <= 0.8 &&
        _nalbuphineEffectiveness <= 0.8 &&
        _morphineEffectiveness <= 0.8 &&
        (_localAnesthesia <= 0.8)
    ) then {
        [_patient, [0.7, 0.8, 0.9] select (floor random 3)] call ACEFUNC(medical_status,adjustPainLevel);
    };

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveTube = _chestTubeArray select _side;

_liveTube = _liveTube + 0.1;
_chestTubeArray set [_side, _liveTube];
_patient setVariable [QGVAR(chestTube), _chestTubeArray, true];

[_patient, false] call ACEFUNC(dragging,setCarryable);
[_patient, false] call ACEFUNC(dragging,setDraggable);

[_patient, "quick_view", LSTRING(incision_log), [[_medic] call ACEFUNC(common,getName), STRING_BODY_PARTS select 2]] call ACEFUNC(medical_treatment,addToLog);

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_side"];

    private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
    private _liveTube = _chestTubeArray select _side;
    private _count = [_patient, "Etomidate", true] call ACEFUNC(medical_status,getMedicationCount) select 1;

    private _alive = alive _patient;

    if ((!_alive) || (_liveTube == 0)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable [QGVAR(etomidate_Pain), false]
    };
    if (GVAR(AMSEnabled)) then {
        _activeLoadingDose = _patient getVariable [QEGVAR(pharma,activeEtomidateLoadingDose), false];
    } else {
        _activeLoadingDose = true;
    };

    if (((GVAR(ChestTube_ConsciousnessRequirement) in [0,1]) && (!(IS_UNCONSCIOUS(_patient))) && (_count <= 0.2) && (_activeLoadingDose)) || (GVAR(Surgery_ConsciousnessRequirement) == 3 && _count <= 0.2 && (_activeLoadingDose))) exitWith {
        if !(_patient getVariable [QGVAR(etomidate_Pain), false]) then {
            [_patient, "Pain", 2, 10, 120, 0.6, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
            _patient setVariable [QGVAR(etomidate_Pain), true]};
        [_patient, true] call ACEFUNC(medical,setUnconscious);
    };

    if (GVAR(ChestTube_ConsciousnessRequirement) == 2 && _count <= 0.2 && (_activeLoadingDose)) then {
        if !(_patient getVariable [QGVAR(etomidate_Pain), false]) then {
            [_patient, "Pain", 2, 10, 120, 0.6, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
            _patient setVariable [QGVAR(etomidate_Pain), true]
        };
    };
}, 5, [_patient, _side]] call CBA_fnc_addPerFrameHandler;

