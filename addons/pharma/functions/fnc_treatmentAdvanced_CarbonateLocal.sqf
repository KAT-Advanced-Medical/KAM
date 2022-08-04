#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Checks for Carbonate Wakeup values to restore consciousness
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_CarbonateLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _bloodVolume = GET_BLOOD_VOLUME(_patient);
private _pulse = GET_HEART_RATE(_patient);

if (_bloodVolume > 4.2 && _pulse >= 60 && _pulse <= 120 && (random 100 <= GVAR(carbonateChance))) then {
    [_patient, false] call ace_medical_fnc_setUnconscious;
    _output = LLSTRING(CarbonateSuccess);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
} else {
    _output = LLSTRING(Carbonate_Info);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};