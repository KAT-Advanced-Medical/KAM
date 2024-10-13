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

private _sampleCounter = missionNamespace getVariable [QEGVAR(circulation,sampleCounter), 0];
private _bloodSampleMap = missionNamespace getVariable [QEGVAR(circulation,bloodSampleMap), []];

_sampleCounter = [_sampleCounter +1, 1] select (_sampleCounter == 20);
missionNamespace setVariable [QEGVAR(circulation,sampleCounter), _sampleCounter, true];

_bloodSampleMap set [_sampleCounter, [name(_patient), _bloodGas]];
missionNamespace setVariable [QEGVAR(circulation,bloodSampleMap), _bloodSampleMap, true];

private _itemStr = format ["KAT_bloodSample_%1", _sampleCounter];

[_medic, _itemStr, true] call CBA_fnc_addItem;