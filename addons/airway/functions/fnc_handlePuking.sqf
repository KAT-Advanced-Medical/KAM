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
_unit setVariable ["kat_pukeActive_PFH", true];


[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _recovery = _unit getVariable [QGVAR(recovery), false];

    if ((!(alive _unit)) || !_isUnconscious) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ["kat_pukeActive_PFH", nil];
    };
    private _ondansetronCount = ([_unit, "Ondansetron", false] call ACEFUNC(medical_status,getMedicationCount)) select 1;
    if (GVAR(occlusion_cooldownPeriod) > 0 && {(_unit getVariable [QGVAR(clearedTime), 0] > 0) && ((_unit getVariable [QGVAR(clearedTime), 0]) + GVAR(occlusion_cooldownPeriod)) > CBA_missionTime && (_unit getVariable [QGVAR(airway_item), ""] isEqualTo "Larynxtubus")} && (_ondansetronCount > 0.6)) exitWith {};

    if (random(100) <= GVAR(probability_occluded)) then {
        private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
        _occlusionState set [0, ((_occlusion select 0) + floor random [1, 3, 5]) min 6];
        _occlusionState set [1, ((_occlusion select 1) + floor random [1, 3, 5]) min 6];
        _occlusionState set [2, ((_occlusion select 2) + floor random [1, 3, 5]) min 6];
        _unit setVariable [QGVAR(occlusion), _occlusionState, true];
        if (GVAR(checkbox_puking_sound)) then {
            playSound3D [selectRandom [QPATHTOF_SOUND(sounds\puking1.wav),QPATHTOF_SOUND(sounds\puking2.wav),QPATHTOF_SOUND(sounds\puking3.wav)], _unit, false, getPosASL _unit, 8, 1, 15];
        };
    };
}, GVAR(occlusion_repeatTimer), [_unit]] call CBA_fnc_addPerFrameHandler;
