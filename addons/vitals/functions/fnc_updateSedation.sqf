#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Update the nauseaMult effect
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: nauseaMult Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updatenauseaMult
 *
 * Public: No
 */

params ["_unit", "_sedationAdjustment", "_deltaT", "_syncValue"];

_unit setVariable [QEGVAR(surgery,sedated), _sedationAdjustment, _syncValue];
