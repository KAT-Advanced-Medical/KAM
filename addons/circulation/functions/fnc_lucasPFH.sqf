#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Lucas PFH
 *
 * Arguments:
 * 0: Paitent <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_LucasPFH
 *
 * Public: No
 */

params ["_unit"];
[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    playSound3D [QPATHTOF_SOUND(sounds\lucas.ogg), _unit, false, getPosASL _unit, 6, 1, 8];
    private _inVehicle =  ((IN_MED_VEHICLE(_unit)) || (IN_MED_FACILITY(_unit)));
    private _attachedLucas = _unit getVariable [QGVAR(attachedLucas), false];
    private _state = _unit getVariable [QGVAR(attachedLucasState), false];
    [_unit, _unit, "LUCAS"] call FUNC(cprLocal);
    if (!_state) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(attachedLucasState), false, true];
        _unit setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
    };
    if (!_inVehicle || !_attachedLucas) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(attachedLucas), false, true];
        _unit setVariable [QGVAR(attachedLucasState), false, true];
        _unit setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
    };
}, 0.6, [_unit]] call CBA_fnc_addPerFrameHandler;