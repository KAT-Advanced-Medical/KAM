#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Server-side per-unit PFH that re-applies the gas effect at a fixed interval
 * while the unit has skin contamination set (mustard or VX). Self-terminates
 * once the contamination is cleared (e.g. by the decontamination kit).
 *
 * Arguments:
 * 0: [_unit, _intervalCounter] <ARRAY>
 * 1: PFH handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_args", "_pfhHandle"];
_args params ["_unit"];

if (isNull _unit || {!alive _unit}) exitWith {
    _pfhHandle call CBA_fnc_removePerFrameHandler;
    _unit setVariable [QGVAR(contaminationPFHActive), false, true];
};

private _gasId = _unit getVariable [QGVAR(chemicalContamination), ""];
if (_gasId isEqualTo "") exitWith {
    _pfhHandle call CBA_fnc_removePerFrameHandler;
    _unit setVariable [QGVAR(contaminationPFHActive), false, true];
};

private _interval = missionNamespace getVariable [QGVAR(contaminationTickInterval), 60];
private _last = _args param [1, CBA_missionTime];
if (CBA_missionTime - _last < _interval) exitWith {};
_args set [1, CBA_missionTime];

private _gasData = (GVAR(gasRegistry) getOrDefault [_gasId, createHashMap]);
private _effectFunc = _gasData getOrDefault ["effectFunc", {}];
if (_effectFunc isEqualTo {}) exitWith {};

[QGVAR(poison), [_unit, _gasData get "toxicLvL", _unit], _unit] call CBA_fnc_targetEvent;
