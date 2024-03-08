#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handle the IV for the patient with blood types. Have to be local to avoid effect on all clients.
 *
 * Arguments:
 * 0: Classname <STRING>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ['Blood_IV_A', cursorTarget] call kat_circulation_fnc_treatmentAdvanced_IV
 *
 * Public: No
 */

params ["_className", "_unit"];

//unit, adjustment, time
private _volume = getNumber (configFile >> "ACE_Medical_Treatment" >> "IV" >> _className >> "volume");

private _hradjust = -_volume;

[_unit, "BloodPoisoning", 150, 300, _hradjust, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);

[{
    params ["_unit"];

    if !(_unit getVariable [VAR_CRDC_ARRST, false]) then {
        private _medicationArray = _unit getVariable [QACEGVAR(medical,medications), []];
        private _index = _medicationArray findIf {(_x select 0) isEqualTo "BloodPoisoning"};

        if (_index > -1) then {
            [QGVAR(bloodPoisoning), _unit, _unit] call CBA_fnc_targetEvent;
        };
    };
    
}, [_unit], 150] call CBA_fnc_waitAndExecute;