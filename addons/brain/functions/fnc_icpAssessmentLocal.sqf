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
 * [player, cursorObject, "Head"] call kat_circulation_fnc_icpAssesment
 *
 * Public: No
 */

params ["_medic", "_patient"];
private _icp = GET_ICP(_patient);
private _icpMM = 4;
if (_icp > 20) then {
    _icp = _icp + (floor random [-5, 0, 10]);
    _icpMM = linearConversion [15, 50, _icp, 4, 6.5, true];
    _icpMM = round (_icpMM * 10) / 10;
};
private _ICPOutput = LSTRING(Check_ICP_OutputMod);

[_patient, "quick_view", LSTRING(Check_ICP_Output), [_medic call ACEFUNC(common,getName), _icpMM]] call ACEFUNC(medical_treatment,addToLog);
[QACEGVAR(common,displayTextStructured), [[_ICPOutput, _patient call ACEFUNC(common,getName), _icpMM], 1.5, _medic], _medic] call CBA_fnc_targetEvent;