#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * vent PFH
 *
 * Arguments:
 * 0: Medic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_ventPFH
 *
 * Public: No
 */

params ["_unit"];
[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    playSound3D [QPATHTOF_SOUND(audio\squeeze_BVM.ogg), _unit, false, getPosASL _unit, 8, 1, 15];
    playSound3D [QPATHTOF_SOUND(audio\respiratorTone.ogg), _unit, false, getPosASL _unit, 8, 1, 15];
    private _inVehicle =  IN_MED_VEHICLE(_unit);
    private _attachedVent = _unit getVariable [QGVAR(attachedVent), false];
    if (!_inVehicle || !_attachedVent) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(attachedVent), false, true];
    };
}, (_unit getVariable [QGVAR(ventRate), 2]), [_unit]] call CBA_fnc_addPerFrameHandler;