#include "..\script_component.hpp"
/*
 * Author: Mazinski
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
 * [player, cursorObject, 2.1, 1] call kat_surgery_fnc_chestTubeProgressLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_entry", "_side"];

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveTube = _chestTubeArray select _side;
private _surgeryString = "";
private _number = _entry;
private _reduce = false;
private _subReduce = false;

if (_number == _liveTube) exitWith {
    switch (_entry) do {
        case (2.1):{
            _surgeryString = LSTRING(EXPOSED);
        };
        case (2.3):{
            _surgeryString = LSTRING(IRRIGATED);
        };
    };

    [_patient, "quick_view", LSTRING(surgery_log), [[_medic] call ACEFUNC(common,getName), _surgeryString, STRING_BODY_PARTS select 1]] call ACEFUNC(medical_treatment,addToLog);

    _liveTube = _liveTube + 0.2;

    _chestTubeArray set [_side, _liveTube];
    _patient setVariable [QGVAR(chestTube), _chestTubeArray, true];
};

private _output = LLSTRING(fracture_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
