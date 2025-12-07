#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Local callback for checking the pulse or heart rate of a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Head"] call kat_circulation_fnc_checkPulseLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _neckOutput = LSTRING(Check_Neck_Output_3);
private _logNeckOutput = LSTRING(Check_Neck_Output_3_log);
private _tptx = _patient getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]];
private _hptx = _patient getVariable [QEGVAR(breathing,hemopneumothorax), [0, 0]];
private _ptx = _patient getVariable [QEGVAR(breathing,pneumothorax), [0, 0]];
private _trali = _patient getVariable [QEGVAR(breathing,TRALI), 0];
private _effusion = _patient getVariable [QEGVAR(circulation,effusion), 0];

if ((_trali > 5) || (_effusion > 0) || ((_ptx select 0 > 2) || (_ptx select 1 > 2) || (_tptx select 0) || (_tptx select 1) || ((_hptx select 0) > 0.3) || ((_hptx select 1) > 0.3))) then {
    if ((_trali > 15) || (_effusion > 2) || ((_ptx select 0 > 6) || (_ptx select 1 > 6) || (_tptx select 0) || (_tptx select 1) || ((_hptx select 0) > 0.6) || ((_hptx select 1) > 0.6))) then{
        _neckOutput = LSTRING(Check_Neck_Output_2);
        _logNeckOutput = LSTRING(Check_Neck_Output_2_log);
    } else {
        _neckOutput = LSTRING(Check_Neck_Output_1);
        _logNeckOutput = LSTRING(Check_Neck_Output_1_log);
    };
};
[_patient, "quick_view", LSTRING(Check_Neck_Output), [_medic call ACEFUNC(common,getName), _logNeckOutput]] call ACEFUNC(medical_treatment,addToLog);
[QACEGVAR(common,displayTextStructured), [[_neckOutput, _patient call ACEFUNC(common,getName)], 1.5, _medic], _medic] call CBA_fnc_targetEvent;