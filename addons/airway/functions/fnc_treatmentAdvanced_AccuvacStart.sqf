#include "script_component.hpp"
/*
 * Author: Blue
 * Play Accuvac suction sound
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Head", "Accuvac", objNull, "kat_accuvac"] call kat_airway_fnc_treatmentAdvanced_AccuvacStart;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

if !(_patient getVariable [QGVAR(occluded), false]) exitWith {};

private _accuvacSuction = playSound3D [QPATHTOF_SOUND(sounds\suction.wav), _patient, false, getPosASL _patient, 6, 1, 15];

[{
    !dialog;
}, {
    params ["_accuvacSuction"];
    
    stopSound _accuvacSuction;
}, [_accuvacSuction], 5.7] call CBA_fnc_waitUntilAndExecute;