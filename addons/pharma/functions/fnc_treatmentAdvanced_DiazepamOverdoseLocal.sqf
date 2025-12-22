#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Naloxone.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NaloxoneOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _diazapamMult = 1;
private _medStack = _patient call ACEFUNC(medical_status,getAllMedicationCount);
private _fentanylEffectiveness = 0;
private _nalbuphineEffectiveness = 0;
private _morphineEffectiveness = 0;
private _lorazepamEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    private _dose = _x select 1;
    if ("fentanyl" in _medName) then {
        _fentanylEffectiveness = _fentanylEffectiveness max (_dose * _effectiveness);
    };
    if ("nalbuphine" in _medName) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max (_dose * _effectiveness);
    };
    if ("morphine" in _medName) then {
        _morphineEffectiveness = _morphineEffectiveness max (_dose * _effectiveness);
    };
    if ("morphine" in _medName) then {
        _morphineEffectiveness = _morphineEffectiveness max (_dose * _effectiveness);
    };
    if ("lorazepam" in _medName) then {
        _lorazepamEffectiveness = _lorazepamEffectiveness max (_dose * _effectiveness);
    };
} forEach _medStack;
private _diazapamMult = linearConversion [0, 90, (_fentanylEffectiveness + _nalbuphineEffectiveness + _morphineEffectiveness + _lorazepamEffectiveness), 1, 3, true];
[_patient, "DiazepamOverdose", 30, 600, 0, 0, 0, 0, 0, 0, 0, -(random [0.1, 0.15, 0.3] * _diazapamMult)] call EFUNC(vitals,addMedicationAdjustment);