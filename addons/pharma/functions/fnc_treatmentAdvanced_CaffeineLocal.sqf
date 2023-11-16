#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_CaffeineLocal;
 *
 * Public: No
 */

params ["_patient"];

if (ACE_Player != _patient) exitWith {};

/// ACE Fatigue
if (ACEGVAR(advanced_fatigue,enabled)) then {

    [{
        params ["_patient"];
        ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) + 1500;
    },
    [_patient], 2.5] call CBA_fnc_waitAndExecute;

} else {

    [{
        params ["_patient"];
        _patient setStamina(getStamina _patient + 300);
    },
    [_patient], 2.5] call CBA_fnc_waitAndExecute;

};
