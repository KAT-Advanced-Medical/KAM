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

params ["_medic", "_patient", "_entry"];

private _cricothyrotomy = _patient getVariable [QGVAR(cricothyrotomy), 0];
private _surgeryString = "";
private _number = _entry;

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

if (_number == _cricothyrotomy) exitWith {
    switch (_entry) do {
        case (0.1):{
            _surgeryString = LSTRING(Incision);
        };
        case (0.3):{
            _surgeryString = LSTRING(PLACED);
        };
    };

    [_patient, "quick_view", LSTRING(ChestTube_log), [[_medic] call ACEFUNC(common,getName), _surgeryString, STRING_BODY_PARTS select 1]] call ACEFUNC(medical_treatment,addToLog);

    _cricothyrotomy = _cricothyrotomy + 0.2;
    _patient setVariable [QGVAR(cricothyrotomy), _cricothyrotomy, true];
};
if (_entry == 0.1) then {
    [{
    params ["_args", "_idPFH"];
    _args params ["_patient"];

    private _cricothyrotomy = _patient getVariable [QGVAR(cricothyrotomy), 0];
    private _alive = alive _patient;
    if ((!_alive) || (_cricothyrotomy == 0) || (_cricothyrotomy == 1)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    if (!(IS_UNCONSCIOUS(_patient))) exitWith {
            [_patient, "Pain", 2, 10, 120, 0.8, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
        [_patient, true] call ACEFUNC(medical,setUnconscious);
        };
    }, 5, [_patient]] call CBA_fnc_addPerFrameHandler;

if (GVAR(hardcoreCrike)) then {
    [_unit, "blockRadio", "kat_crike", true] call ACEFUNC(common,statusEffect_set);
    [_unit, "blockSpeaking", "kat_crike", true] call ACEFUNC(common,statusEffect_set);
};
};



private _output = LLSTRING(cricothyrotomy_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
