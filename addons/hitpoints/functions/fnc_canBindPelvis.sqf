#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Condition Check if you can wrap a splint on a limb
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_canWrapSplint
 *
 * Public: No
 */

params ["", "_patient"];
if (_patient call ACEFUNC(common,isSwimming)) exitWith {false};
private _canBindPelvis = false;
private _pelvicFracture = _unit getVariable [QGVAR(pelvicFracture), 0];
if (_pelvicFracture > 0) then {
    _canBindPelvis = true;
};
_canBindPelvis


