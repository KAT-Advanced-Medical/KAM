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
    _patient setVariable [QGVAR(warmingImpact), (_impact + 300), true];
};
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if (!alive _patient || (abs (speed _patient) > 9.9 && isNull objectParent _patient)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable [QGVAR(spaceBlanket), false, true];
        private _impact = (_patient getVariable [QGVAR(warmingImpact), 0]);
        _patient setVariable [QGVAR(warmingImpact), (_impact - 300), true];
        [LLSTRING(thermalBlanket_FallOff), 1.5, _patient] call ACEFUNC(common,displayTextStructured);  
        };
}, 1, [_patient]] call CBA_fnc_addPerFrameHandler;