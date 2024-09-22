#include "..\script_component.hpp"
/*
* Author: DiGii
*
* Handles the breathing sound for gasMasks
*
* Arguments:
* 0: Unit <OBJECT>
* 1: Glasses Class <STRING>
*
* Return Value:
* NONE
*
* Example:
* [player, "kat_mask_M50"] call kat_chemical_fnc_breathing;
*
* Public: No
*
*/
params ["_unit", "_glassesClass"];

if !(_glassesClass in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) exitWith {};

GVAR(soundPlaying) = false;
[
    {
        params["_args", "_handler"];
        _args params ["_unit", "_volume"];
        if (!(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) || !(alive _unit) || (_unit getVariable [QACEGVAR(medical,inCardiacArrest), false])) then {
            [_handler] call CBA_fnc_removePerFrameHandler;
        } else {
            if (!GVAR(soundPlaying)) then {
                if ((GET_PAIN_PERCEIVED(_unit) >= 0.4) || (_unit getVariable [QACEGVAR(medical,heartrate), 80] >= 105)) then {
                    playSoundUI [QPATHTOF(audio\heavyBreath.ogg), GVAR(gasMaskSoundVolume), 1];
                    GVAR(soundPlaying) = true;
                } else {
                    if (round random 1 >= 0.5) then {
                        playSoundUI [QPATHTOF(audio\breath1.ogg), GVAR(gasMaskSoundVolume), 1];
                        GVAR(soundPlaying) = true;
                    } else {
                        playSoundUI [QPATHTOF(audio\breath2.ogg), GVAR(gasMaskSoundVolume), 1];
                        GVAR(soundPlaying) = true;
                    };
                };
                [{
                    GVAR(soundPlaying) = false;
                }, [], 4] call CBA_fnc_waitAndExecute;
            };
        };
    },
    0,
    [_unit]
] call CBA_fnc_addPerFrameHandler;

