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
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    private _alive = alive _patient;
    if !(_alive || ((_occlusionState select _level) == 0)) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                        _patient setVariable ["kat_occlusion_PFH", nil];
                    };
}, 1, [_patient]] call CBA_fnc_addPerFrameHandler;