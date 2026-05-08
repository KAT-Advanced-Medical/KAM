#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Updates injury list for given body part for the target.
 *
 * Arguments:
 * 0: Injury list <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part, -1 to only show overall health info <NUMBER>
 * 3: Entries <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlInjuries, _target, 0] call kat_chemical_fnc_gui_updateInjuryListGeneral
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if !(missionNamespace getVariable [QGVAR(showPoisoning), true]) exitWith {};

private _poisontype = _target getVariable [QGVAR(poisonType),""];

if (_target getVariable [QGVAR(airPoisoning),false]) then{
    _entries pushBack [LLSTRING(Intoxication), [0.4,0,0.5,1]];
};

private _nerveAgent = _target getVariable [QGVAR(nerveAgentExposure), ""];
if (_nerveAgent != "") then {
    private _name = ((GVAR(gasRegistry) getOrDefault [_nerveAgent, createHashMap]) getOrDefault ["displayName", _nerveAgent]);
    _entries pushBack [format [LLSTRING(NerveAgentExposure), _name], [0.85, 0.20, 0.20, 1]];
};

private _contam = _target getVariable [QGVAR(chemicalContamination), ""];
if (_contam != "") then {
    private _name = ((GVAR(gasRegistry) getOrDefault [_contam, createHashMap]) getOrDefault ["displayName", _contam]);
    _entries pushBack [format [LLSTRING(ChemicalContamination), _name], [0.85, 0.40, 0.10, 1]];
};
