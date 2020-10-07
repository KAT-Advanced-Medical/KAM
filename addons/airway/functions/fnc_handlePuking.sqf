#include "script_component.hpp"
/*
 * Author: Katalam
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

if !(GVAR(enable)) exitWith {};

if (_unit getVariable ["kat_pukeActive_PFH", false]) exitWith {};
_unit setVariable ["kat_pukeActive_PFH", true];


[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    private _alive = _unit getVariable ["ACE_isUnconscious", false];
    if (!_alive || (_unit getVariable [QGVAR(airway_item), ""] isEqualTo "larynx")) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
		_unit setVariable ["kat_pukeActive_PFH", nil];
    };
    if (random(100) <= GVAR(probability_occluded)) then {
        if !(_unit getVariable ["KAT_medical_airwayOccluded", false]) then {
            _unit setVariable ["KAT_medical_airwayOccluded", true, true];
            if (GVAR(checkbox_puking_sound)) then {
                playsound3D [selectRandom [QPATHTOF_SOUND(sounds\puking1.wav),QPATHTOF_SOUND(sounds\puking2.wav),QPATHTOF_SOUND(sounds\puking3.wav)], _unit, false, getPosASL _unit, 8, 1, 15];
            };
        };
    };
}, 60, [_unit]] call CBA_fnc_addPerFrameHandler;
