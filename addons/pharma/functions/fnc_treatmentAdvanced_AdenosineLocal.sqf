#include "..\script_component.hpp"
/*
 * Author:Cplhardcore
 * Does the AV block effect of adenosine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "ACE_adenosine"] call kat_pharma_fnc_treatmentAdvanced_AdenosineLocal;
 *
 * Public: No
 */
params ["_patient", "_classname"];
if (_classname isEqualTo "ACE_adenosine") exitWith {};
private _cardiacRhythm = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0];
_patient setVariable [QEGVAR(circulation,cardiacArrestType), 1];
private _medStack = _patient call ACEFUNC(medical_treatment,getAllMedicationCount);
private _medsToCheck = ["amiodarone"];
private _amiodaroneEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("amiodarone" in _medName) then {
        _amiodaroneEffectiveness = _amiodaroneEffectiveness max _effectiveness;
    };
} forEach _medStack;
if (_amiodaroneEffectiveness > 0.2) then {
    _time = random(16) + 16
} else {
    _time = random(8) + 8
};

[{ 
    params ["_patient", "_cardiacRhythm"];
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _cardiacRhythm];
}, [_patient, _cardiacRhythm], _time] call CBA_fnc_waitAndExecute;