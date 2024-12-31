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
 * [player, cursorObject, 1] call kat_surgery_fnc_incisionLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

if (GVAR(Surgery_ConsciousnessRequirement) == 1 && !(IS_UNCONSCIOUS(_patient))) exitWith {
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveTube = _chestTubeArray select _side;

_liveTube = _liveTube + 0.1;
_chestTubeArray set [_part, _liveTube];
_patient setVariable [QGVAR(chestTube), _chestTubeArray, true];

[_patient, false] call ACEFUNC(dragging,setCarryable);
[_patient, false] call ACEFUNC(dragging,setDraggable);

[_patient, "quick_view", LSTRING(incision_log), [[_medic] call ACEFUNC(common,getName), STRING_BODY_PARTS select 1]] call ACEFUNC(medical_treatment,addToLog);

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_part"];

    private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
    private _liveTube = _chestTubeArray select _part;
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
}, 5, [_patient, _part]] call CBA_fnc_addPerFrameHandler;

