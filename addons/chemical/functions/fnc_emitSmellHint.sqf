#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Emits a one-shot smell hint to the local player when first entering a cloud
 * of a specific gas. Skipped if the gas has no smell key (sarin/VX) or if the
 * unit already smelled this gas.
 *
 * Called locally on the affected unit's client.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Gas data <HASHMAP>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_gasData"];

if (_unit != ACE_player || !(GVAR(enableSmellHint))) exitWith {};

private _smellKey = _gasData get "smellHintKey";
if (_smellKey isEqualTo "") exitWith {};

private _gasId = _gasData getOrDefault ["id", ""];
private _smelled = _unit getVariable [QGVAR(smelledGases), []];
if (_gasId in _smelled) exitWith {};

_smelled pushBack _gasId;
_unit setVariable [QGVAR(smelledGases), _smelled, true];

private _text = localize _smellKey;
[_text, 1.5, _unit] call ACEFUNC(common,displayTextStructured);
