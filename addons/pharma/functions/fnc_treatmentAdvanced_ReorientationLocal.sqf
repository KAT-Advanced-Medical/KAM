#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Local action for carbonate
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item classname <STRING>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *`
 * Example:
 * [player, "Carbonate"] call aceP_airway_fnc_treatmentAdvanced_CarbonateLocal;
 *
 * Public: No
 */

params ["_medic", "_target"];

private _bloodVolume = GET_BLOOD_VOLUME(_target);
private _pulse = GET_HEART_RATE(_target);

if (_bloodVolume > 5.1 && _pulse >= 70 && _pulse <= 100) then {
    [_target, false] call ace_medical_fnc_setUnconscious;
};

true
