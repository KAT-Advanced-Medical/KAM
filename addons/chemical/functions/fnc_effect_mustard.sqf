#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Mustard / Yperite (HD). Blister agent — REQUIRES CBRN suit. Sets skin
 * contamination so the contamination tick keeps re-applying until decon kit
 * is used. Schedules delayed eye injuries and skin burns.
 *
 * Runs local to the unit's owner.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Infected source <OBJECT>
 * 2: Gas data <HASHMAP>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_infectedObject", "_gasData"];

private _firstExposure = (_unit getVariable [QGVAR(chemicalContamination), ""]) isEqualTo "";
_unit setVariable [QGVAR(chemicalContamination), "mustard", true];

[QGVAR(serverStartContaminationTick), [_unit]] call CBA_fnc_serverEvent;

if (!_firstExposure) exitWith {
    if (_infectedObject isEqualTo _unit && {_unit getVariable [QGVAR(mustardBurnActive), false]}) then {
        [_unit] call FUNC(applyMustardDamage);
    };
};

private _eyeMin = missionNamespace getVariable [QGVAR(mustard_eyeOnsetMin), 300];
private _eyeMax = missionNamespace getVariable [QGVAR(mustard_eyeOnsetMax), 600];
private _burnMin = missionNamespace getVariable [QGVAR(mustard_burnOnsetMin), 600];
private _burnMax = missionNamespace getVariable [QGVAR(mustard_burnOnsetMax), 1200];

if (EGVAR(ophthalmology,enable)) then {
    _unit setVariable [QGVAR(mustardDeadline_eye),  CBA_missionTime + _eyeMin  + random (_eyeMax  - _eyeMin),  true];
};
_unit setVariable [QGVAR(mustardDeadline_burn), CBA_missionTime + _burnMin + random (_burnMax - _burnMin), true];

[_unit] call FUNC(addToExposureWatcher);
