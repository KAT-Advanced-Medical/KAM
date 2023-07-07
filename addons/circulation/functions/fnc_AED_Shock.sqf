#include "script_component.hpp"
/*
 * Author: Blue
 * Handles finishing AED shock procedure.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Defibrillator type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "AED"] call kat_circulation_fnc_AED_Shock
 *
 * Public: No
 */

params ["_medic", "_patient", "_defibType"];

//pain will be added to all units standing too close to caller or target.
if (vehicle _patient isEqualTo _patient) then {
    private _bystanders = ( allUnits select {_x distance _patient < 1.1} ) - [_medic];
    {
        [_x, 0.2] call ACEFUNC(medical_status,adjustPainLevel);
    } forEach _bystanders;
};

[{
    params ["_patient"];
    _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
}, [_patient], 1] call CBA_fnc_waitAndExecute;

if (alive _patient && {_patient getVariable [QACEGVAR(medical,inCardiacArrest), false]}) then {
    [QACEGVAR(medical_treatment,cprLocal), [_medic, _patient, _defibType], _patient] call CBA_fnc_targetEvent;
};
