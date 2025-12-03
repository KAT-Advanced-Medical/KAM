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
private _inVehicle = ((IN_MED_VEHICLE(_unit)) || (IN_MED_FACILITY(_unit)));
private _attachedVent = _unit getVariable [QGVAR(attachedVent), false];
if (!_inVehicle || !_attachedVent) exitWith {
    _unit setVariable [QGVAR(attachedVent), false, true];
    _unit setVariable [QGVAR(attachedVentGUI), false, true];
};
[{
    params ["_unit"];      
    playSound3D [QPATHTOF_SOUND(audio\squeeze_BVM.ogg), _unit, false, getPosASL _unit, 6, 1, 8];
    playSound3D [QPATHTOF_SOUND(audio\respiratorTone.ogg), _unit, false, getPosASL _unit, 6, 1, 8];
    _unit call FUNC(ventPFH);
}, [_unit], (_unit getVariable [QGVAR(ventRate), 2])] call CBA_fnc_waitAndExecute;
