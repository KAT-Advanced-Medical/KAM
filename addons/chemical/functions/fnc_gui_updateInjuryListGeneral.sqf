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

if (GVAR(rad_icReadout) && {_target getVariable [QGVAR(radCritical), false]}) then {
    private _severity = _target getVariable [QGVAR(radSeverity), 0];
    private _fragility = (((_severity - GVAR(rad_doseThreshold_moderate)) / ((GVAR(rad_doseThreshold_lethal) - GVAR(rad_doseThreshold_moderate)) max 0.1)) max 0) min 1;
    private _progress = round ((1 - _fragility) * 100);

    _entries pushBack [LLSTRING(radCriticalStatus), [0.85, 0.20, 0.20, 1]];
    _entries pushBack [format [LLSTRING(radICProgress), _progress], [0.90, 0.55, 0.10, 1]];

    private _missing = [];
    private _support = (count (_target getVariable [QACEGVAR(medical,ivBags), []]) > 0)
        || {(([_target, "Epinephrine", false] call ACEFUNC(medical_status,getMedicationCount)) select 1) > 0}
        || {(([_target, "Norepinephrine", false] call ACEFUNC(medical_status,getMedicationCount)) select 1) > 0};
    if (!_support) then { _missing pushBack LLSTRING(radIC_support); };
    if (CBA_missionTime >= (_target getVariable [QGVAR(radFilgrastimWindow), 0])) then { _missing pushBack LLSTRING(radIC_filgrastim); };
    if (CBA_missionTime >= (_target getVariable [QGVAR(radAntibioticWindow), 0])) then { _missing pushBack LLSTRING(radIC_antibiotics); };
    if (CBA_missionTime >= (_target getVariable [QGVAR(radMarrowRescueWindow), 0])) then { _missing pushBack LLSTRING(radIC_stemcells); };
    if (((_target getVariable [QGVAR(radDoseRate), 0]) >= 0.01) || {(_target getVariable [QGVAR(radInternalBurden), 0]) >= 0.001}) then { _missing pushBack LLSTRING(radIC_source); };

    if (_missing isNotEqualTo []) then {
        _entries pushBack [format [LLSTRING(radICMissing), _missing joinString ", "], [0.90, 0.70, 0.20, 1]];
    };
};

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
