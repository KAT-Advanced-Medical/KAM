#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for removing a fluid warmer
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_hypothermia_fnc_removeFluidWarmerLocal;
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

_patient setVariable [QGVAR(spaceBlanket), true, true];
if (GET_BLOOD_VOLUME_LITERS(_patient) > 4) then {
    private _impact = (_patient getVariable [QGVAR(warmingImpact), 0]);
    _patient setVariable [QGVAR(warmingImpact), _impact + 300, true];
};