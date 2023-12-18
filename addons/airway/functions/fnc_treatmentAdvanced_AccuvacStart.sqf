#include "..\script_component.hpp"
/*
 * Author: Blue
 * Play Suction Devices sound
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

if (_usedItem isEqualTo "kat_suction") then {
    private _suctionSound = playSound3D [QPATHTOF_SOUND(sounds\manualpump_suction.wav), _patient, false, getPosASL _patient, 6, 1, 15];

    [{
        !dialog;
    }, {
        params ["_suctionSound"];

        stopSound _suctionSound;
    }, [_suctionSound], 7.5] call CBA_fnc_waitUntilAndExecute;
} else {
    private _suctionSound = playSound3D [QPATHTOF_SOUND(sounds\accuvac_suction.wav), _patient, false, getPosASL _patient, 6, 1, 15];

    [{
        !dialog;
    }, {
        params ["_suctionSound"];

        stopSound _suctionSound;
    }, [_suctionSound], 5.7] call CBA_fnc_waitUntilAndExecute;
};
