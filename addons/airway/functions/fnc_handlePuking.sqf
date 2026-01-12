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

if (_unit getVariable [QEGVAR(vitals,simpleMedical), false]) exitWith {};

[{
    params ["_unit"];
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];
    
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _alive = alive _unit;
    if (!_alive || !_isUnconscious || !(_unit getVariable ["kat_pukeActive_PFH", false])) exitWith {
        _unit setVariable ["kat_pukeActive_PFH", false];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _nauseaMult = _unit getVariable [QEGVAR(pharma,nauseaMult), 1];
    private _stomachVolume = _unit getVariable [QGVAR(stomachVolume), 5];
    private _nauseaMult = (_nauseaMult min 6) max 0.1;
    private _nauseaDelay = if (_nauseaMult < 1) then {_nauseaMult / 2} else {_nauseaMult};
    private _icp = _unit getVariable [QEGVAR(brain,ICP),15];
    private _icpChance = linearConversion [15, 60, _icp, 1, 2, true];
    private _nauseaChance = 1;
    if (_nauseaMult <= 1) then {
        _nauseaChance = linearConversion [1, 6, _nauseaMult, 1, 3, true];
    } else {
        _nauseaChance = linearConversion [0.1, 1, _nauseaMult, 0.001, 1, true];
    };
    if (_nauseaMult < 0.3) exitWith {};
    if (_stomachVolume <= 0) exitWith {};
    if ((CBA_missionTime - (_unit getVariable [QGVAR(clearedTime), 0])) < GVAR(cooldownTime)) exitWith {
        [_idPFH, 5] call CBA_fnc_setPerFrameHandlerDelay;
    };
    if ((random 100) <= (GVAR(airwayPukeChance) * (_nauseaChance * _icpChance))) then {
        private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
        private _volume = (_unit getVariable [QGVAR(stomachVolume), 5]) max 1;
        private _mitigation = _unit getVariable [QGVAR(occlusionMitigation), [0, 0, 0]];
        _occlusionState set [0, ((_occlusionState select 0) + floor (_volume * 1.5 * (1 - (_mitigation select 0)))) min 10];
        _occlusionState set [1, ((_occlusionState select 1) + floor (_volume * (1 - (_mitigation select 1)))) min 10];
        _occlusionState set [2, ((_occlusionState select 2) + floor (_volume * 0.7 * (1 - (_mitigation select 1)))) min 10];
        _unit setVariable [QGVAR(occlusion), _occlusionState, true];
        _unit setVariable [QGVAR(stomachVolume), (_volume - 1), true];
        _unit setVariable [QGVAR(hasPuked), true, true];
        TRACE_1("occlusion",_occlusionState);
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
        private _delay = ((GVAR(occlusion_repeatTimer) / _nauseaDelay) * random [0.8, 1, 1.3]) max GVAR(minPukeTime);
        [_unit] call FUNC(airwayDeterioration);
        [_idPFH, _delay] call CBA_fnc_setPerFrameHandlerDelay;
    }, GVAR(occlusion_repeatTimer), [_unit]] call CBA_fnc_addPerFrameHandler;


}, [_unit], (15 * random [0.7, 1, 1.5])] call CBA_fnc_waitAndExecute;


