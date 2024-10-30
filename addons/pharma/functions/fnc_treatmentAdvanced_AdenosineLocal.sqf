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
 * [cursorTarget, "ACE_adenosine"] call kat_pharma_fnc_treatmentAdvanced_AmiodaroneLocal;
 *
 * Public: No
 */
params ["_patient", "_classname"];
if (_classname isEqualTo "ACE_adenosine") exitWith {};
private _cardiacRhythm = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0];
_patient setVariable [QEGVAR(circulation,cardiacArrestType), 1];
[{ 
    params ["_patient", "_cardiacRhythm"];
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _cardiacRhythm];
}, [_patient, _cardiacRhythm], random(8) + 8] call CBA_fnc_waitAndExecute;