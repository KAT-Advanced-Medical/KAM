#include "..\script_component.hpp"
/*
 * Author: Katalam, edited by MiszczuZPolski
 * Called when a unit enters the unconscious state. Will add a FrameHandler for puking while unconscious.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_airway_fnc_handlePuking;
 *
 * Public: No
 */

params ["_unit"];


//Other mods can utilise KAT_Occlusion_Exclusion variable to prevent occlusions from happening
[{
    params ["_unit"];
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _alive = alive _unit;
    private _occlusion = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
    if (!_alive || _isUnconscious || ((selectMax _occlusion)  == 0)) exitWith {};
    _unit setVariable [QGVAR(occlusion), [0, 0, 0], true];
    _unit setVariable [QGVAR(hasExternallyPuked), true, true];
    [{
        params ["_unit"];
        _unit setVariable [QGVAR(hasExternallyPuked), false, true];
    }, [_unit], 60] call CBA_fnc_waitAndExecute;
    private _sound = selectRandom [
        QPATHTOF_SOUND(sounds\puking1.wav),
        QPATHTOF_SOUND(sounds\puking2.wav),
        QPATHTOF_SOUND(sounds\puking3.wav)
    ];
    TRACE_3("Puke",_sound,_unit,(getPosASL _unit));
    playSound3D [_sound, _unit, false, getPosASL _unit, 8, 1, 15];
}, [_unit], 3] call CBA_fnc_waitAndExecute;

