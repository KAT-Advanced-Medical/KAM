#include "..\script_component.hpp"
/*
 * Author: Mazinski, Cplhardcore
 * Local call to check if a patient has a active crike
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

params ["_medic", "_patient", "_number"];
private _cricothyrotomy = _patient getVariable [QGVAR(cricothyrotomy), 0];
if ((_number == 5) && (_cricothyrotomy == 0)) exitWith {true};
if ((_number != 5) && (_cricothyrotomy >= 0.1) && (_cricothyrotomy <= 0.7)) exitWith {true};

false
