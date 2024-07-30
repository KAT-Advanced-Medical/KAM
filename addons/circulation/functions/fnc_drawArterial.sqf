#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka, Mazinski
 * Refactored by Slatery
 * Handles drawing of arterial blood
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, patient] call kat_circulation_fnc_drawArterial;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _bloodGas = GET_BLOOD_GAS(_patient);

GVAR(sampleCounter) = if (GVAR(sampleCounter) == 20) then { 1 } else { GVAR(sampleCounter) + 1 };
GVAR(bloodSampleMap) set [GVAR(sampleCounter), [name(_patient), _bloodGas]];

private _itemStr = format ["KAT_bloodSample_%1", GVAR(sampleCounter)];

[_medic, _itemStr, true] call CBA_fnc_addItem;