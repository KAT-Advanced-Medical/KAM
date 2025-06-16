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
if ((_unit getVariable ["kat_pukeActive_PFH", false]) || !(GVAR(enable))) exitWith {};
    
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _alive = alive _unit;
    if !(_alive && _isUnconscious) exitWith {
        _unit setVariable ["kat_pukeActive_PFH", nil];
    };
    
    private _nauseaMult = _unit getVariable [QEGVAR(pharma,nauseaMult), 1];
    if (_unit getVariable [QGVAR(airway_item), ""] isEqualTo "Larynxtubus") then {
        _nauseaMult = _nauseaMult * 4
    };

    if (random (100) <= GVAR(airwayPukeChance)) then {
        private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
        _occlusionState set [0, ((_occlusionState select 0) + floor random [1, 3, 6]) min 6];
        _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 3, 6]) min 6];
        _occlusionState set [2, ((_occlusionState select 2) + floor random [1, 3, 6]) min 6];

        for "_i" from 0 to 2 do {
            [_unit, _i] call FUNC(airwayPFH);
        };

        _unit setVariable [QGVAR(occlusion), _occlusionState, true];

        if (GVAR(checkbox_puking_sound)) then {
            private _sound = selectRandom [
                QPATHTOF_SOUND(sounds\puking1.wav),
                QPATHTOF_SOUND(sounds\puking2.wav),
                QPATHTOF_SOUND(sounds\puking3.wav)
            ];
            playSound3D [_sound, _unit, false, getPosASL _unit, 8, 1, 15];
        };
    };
    [{[_unit] call FUNC(handlePuking); }, [_unit], (GVAR(occlusion_repeatTimer) * _nauseaMult * random [0.8, 1, 1.3])] call CBA_fnc_waitAndExecute;


