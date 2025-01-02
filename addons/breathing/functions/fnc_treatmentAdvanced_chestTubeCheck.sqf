#include "..\script_component.hpp"
/*
 * Author: Mazinski, Cplhardcore
 * Local call to check if a patient has a chest Tube
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: chestTube Status <NUMBER>
 * 3: Side <NUMBER>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorObject, 3.1, 1] call kat_breathing_treatmentAdvanced_chestTubeCheck
 *
 * Public: No
 */

params ["_medic", "_patient", "_number", "_side"];
private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveChestTube = _chestTubeArray select _side;

if ((_number == 5) && (_liveChestTube == 0)) exitWith {true};
if ((_number != 5) && (_liveChestTube >= 0.1) && (_liveChestTube <= 0.7)) exitWith {true};

false
