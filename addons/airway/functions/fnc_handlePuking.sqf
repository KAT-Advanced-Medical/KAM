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
if ((_unit getVariable ["kat_pukeActive_PFH", false]) || !(GVAR(enable)) || (_unit getVariable ["KAT_Occlusion_Exclusion", false])) exitWith {};
_unit setVariable ["kat_pukeActive_PFH", true];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _alive = alive _unit;
    if (!_alive || !_isUnconscious) exitWith {
        _unit setVariable ["kat_pukeActive_PFH", nil];
    };
    if (random (100) <= GVAR(airwayPukeChance)) then {
        private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
        private _usedItem = _unit getVariable [QGVAR(airway_item), ""];
        switch (true) do {
            case (_usedItem isEqualTo "Larynxtubus"): {
                _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 2, 6]) min 6];
            };
            case (_usedItem isEqualTo "IGEL"): {
                _occlusionState set [0, ((_occlusionState select 0) + floor random [1, 3, 6]) min 6];
                _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 2, 4]) min 6];
            };
            case (_usedItem isEqualTo "ETT"): {
                _occlusionState set [0, ((_occlusionState select 0) + floor random [1, 3, 6]) min 6];
                _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 2, 4]) min 6];
            };
            case (_usedItem isEqualTo "NPA"): {
                _occlusionState set [0, ((_occlusionState select 0) + floor random [1, 3, 6]) min 6];
                _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 2, 4]) min 6];
                _occlusionState set [2, ((_occlusionState select 2) + floor random [1, 1, 3]) min 6];
            };
            case (_usedItem isEqualTo "Guedeltubes"): {
                _occlusionState set [0, ((_occlusionState select 0) + floor random [1, 3, 6]) min 6];
                _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 2, 4]) min 6];
                _occlusionState set [2, ((_occlusionState select 2) + floor random [1, 1, 3]) min 6];
            };
            default {
            _occlusionState set [0, ((_occlusionState select 0) + floor random [1, 3, 6]) min 6];
            _occlusionState set [1, ((_occlusionState select 1) + floor random [1, 2, 4]) min 6];
            _occlusionState set [2, ((_occlusionState select 2) + floor random [1, 1, 3]) min 6];
            };
        };
        _unit setVariable [QGVAR(occlusion), _occlusionState, true];
        _unit setVariable [QGVAR(hasPuked), true, true];
        for "_i" from 0 to 2 do {
            [_unit, _i] call FUNC(airwayPFH);
        };
        private _nauseaMult = _unit getVariable [QEGVAR(pharma,nauseaMult), 1];
        if (_nauseaMult > 1000) then {
            _nauseaMult = 1
        };
        private _nauseaMult = (_nauseaMult min 6) max 0.1;
        private _delay = ((GVAR(occlusion_repeatTimer) / _nauseaMult) * random [0.8, 1, 1.3]) max 15;
        [_idPFH, _delay] call CBA_fnc_setPerFrameHandlerDelay;
        if (GVAR(checkbox_puking_sound)) then {
            private _sound = selectRandom [
                QPATHTOF_SOUND(sounds\puking1.wav),
                QPATHTOF_SOUND(sounds\puking2.wav),
                QPATHTOF_SOUND(sounds\puking3.wav)
            ];
            TRACE_3("Puke",_sound,_unit,(getPosASL _unit));
            playSound3D [_sound, _unit, false, getPosASL _unit, 8, 1, 15];
            };
        };
}, GVAR(occlusion_repeatTimer), [_unit]] call CBA_fnc_addPerFrameHandler;


