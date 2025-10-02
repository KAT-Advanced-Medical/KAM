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
private _medStack = _patient call ACEFUNC(medical_status,getAllMedicationCount);
private _medsToCheck = ["Amiodarone"];
private _amiodaroneEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("amiodarone" in _medName) then {
        _amiodaroneEffectiveness = _amiodaroneEffectiveness max _effectiveness;
    };
} forEach _medStack;
_time = 1;
if (_amiodaroneEffectiveness > 0.2) then {
    _time = random(12) + 12
} else {
    _time = random(6) + 6
};

[{ 
    params ["_patient", "_cardiacRhythm"];
    if (((random 1000) < 1) && (_cardiacRhythm > 2))  then {
        _patient setVariable [QEGVAR(circulation,cardiacArrestType), 0, true];
    } else {
        _patient setVariable [QEGVAR(circulation,cardiacArrestType), _cardiacRhythm, true];
    };
}, [_patient, _cardiacRhythm], _time] call CBA_fnc_waitAndExecute;