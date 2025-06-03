#include "..\script_component.hpp"
/*
 * Author: Glowbal modified by Cplhardcore
 * Local callback for checking the blood pressure of a patient.
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
 * [player, cursorObject, "LeftArm"] call kat_circulation_fnc_checkBloodPressureLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _bloodPressure = [0, 0];
private _tourniquets = GET_TOURNIQUETS(_unit);
private _occlusionMap = [
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];
private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _idx = _occlusionMap findIf { _x#0 == _part };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _isOccluded = { _tourniquets select _x != 0 } count _result > 0;

if (alive _patient && {!(_isOccluded)}) then {
    _bloodPressure = [_patient] call FUNC(getBloodPressure);
};

private _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_6);
private _logOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_NoBloodpressure);

_bloodPressure params ["_bloodPressureLow", "_bloodPressureHigh"];

if (_bloodPressureLow > 40) then {
    if (_medic call ACEFUNC(medical_treatment,isMedic)) then {
        if (GVAR(hardcoreDiagnose)) then {
            _bloodPressureOutput = LSTRING(Check_Bloodpressure_Output_Palp);
            _logOutput = format [LLSTRING(Bloodpressure_Output_Palp), (round (_bloodPressureLow / 10) * 10) + ([10, -10] select (random 1 > 0.5))];
        } else {
            _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_1);
            _logOutput = format ["%1/%2", round _bloodPressureHigh, round _bloodPressureLow];
        }
        
    } else {
        if (_bloodPressureHigh > 20) then {
            _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_2);
            _logOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Low);

            if (_bloodPressureHigh > 80) then {
                _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_3);
                _logOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Normal);

                if (_bloodPressureHigh > 160) then {
                    _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_4);
                    _logOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_High);
                };
            };
        };
    };
};

[_patient, "quick_view", ACELSTRING(medical_treatment,Check_Bloodpressure_Log), [_medic call ACEFUNC(common,getName), _logOutput]] call ACEFUNC(medical_treatment,addToLog);

[QACEGVAR(common,displayTextStructured), [[_bloodPressureOutput, _patient call ACEFUNC(common,getName), round _bloodPressureHigh, round _bloodPressureLow], 1.75, _medic], _medic] call CBA_fnc_targetEvent;