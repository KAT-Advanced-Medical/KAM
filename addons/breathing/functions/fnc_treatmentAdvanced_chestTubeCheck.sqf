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
 * [player, cursorObject, 3.1, 1] call kat_surgery_fnc_openchestTubeCheck
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveChestTube = _chestTubeArray select _side;


if ((_number == 5) && (_liveChestTube == 2)) exitWith {true};
if ((_number != 5) && (_liveChestTube >= 2.1) && (_liveChestTube <= 2.7)) exitWith {true};

false
