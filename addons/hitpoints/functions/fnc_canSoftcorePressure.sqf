#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Condition Check if you can apply Softcore or Hardcore Pressure
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_canWrapSplint
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

private _canPressure = false;
if ((GVAR(hardcorePressure)) && ([_medic, _patient, _bodyPart] call FUNC(canBandage))) then{
    if (!(GVAR(hardcorePressure)) && (_medic != _patient)) then {
        _canPressure = true;
    };
    if (GVAR(hardcorePressure)) then {
        _canPressure = true;
    };
};
_canPressure