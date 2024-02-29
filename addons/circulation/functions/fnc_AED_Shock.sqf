#include "..\script_component.hpp"
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

// Give pain to units with medical menu of patient open (except medic)
private _bystanders = allPlayers inAreaArray [ASLToAGL getPosASL _patient, ACEGVAR(medical_gui,maxDistance), ACEGVAR(medical_gui,maxDistance), 0, false, ACEGVAR(medical_gui,maxDistance)];
_bystanders = _bystanders - [_medic];
{
    [QGVAR(handleNearToAED), [_x, _patient], _x] call CBA_fnc_targetEvent;
} forEach _bystanders;

if (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] != objNull) then {
    [(_patient getVariable QACEGVAR(medical,CPR_provider)), 0.4] call ACEFUNC(medical_status,adjustPainLevel);
};

_patient setVariable [QGVAR(heartRestart), true, true];
_patient setVariable [QGVAR(RhythmAnalyzed), false, true];

[{
    params ["_patient"];

    _patient setVariable [QGVAR(heartRestart), false, true];
}, [_patient], 4] call CBA_fnc_waitAndExecute;

[{
    params ["_patient"];

    _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
}, [_patient], 1] call CBA_fnc_waitAndExecute;

_patient setVariable [QGVAR(Defibrillator_ShockAmount), (_patient getVariable [QGVAR(Defibrillator_ShockAmount), 0]) + 1, true];

if (alive _patient) then {
    if (IN_CRDC_ARRST(_patient)) then {
        [QACEGVAR(medical_treatment,cprLocal), [_medic, _patient, _defibType], _patient] call CBA_fnc_targetEvent;
    } else {
        if (GVAR(AdvRhythm) && GVAR(AdvRhythm_Hardcore_Enable)) then {
            [QGVAR(incorrectAEDUsage), _patient, _patient] call CBA_fnc_targetEvent;
        }; 
    };
};
