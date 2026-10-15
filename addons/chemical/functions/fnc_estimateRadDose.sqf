#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Triage diagnostic: estimates a patient's accumulated radiation dose and
 * prognosis from their absorbed dose and the time-to-emesis biomarker, shown
 * to the examining medic. Reports the exact accumulated dose (Gy).
 *
 * Runs on the medic's machine (treatment callbackSuccess).
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _dose = _patient getVariable [QGVAR(radDoseWB), 0];

private _prognosis = switch (true) do {
    case (_dose >= GVAR(rad_doseThreshold_lethal)):   { LLSTRING(radPrognosis_lethal) };
    case (_dose >= GVAR(rad_doseThreshold_severe)):   { LLSTRING(radPrognosis_severe) };
    case (_dose >= GVAR(rad_doseThreshold_moderate)): { LLSTRING(radPrognosis_moderate) };
    case (_dose >= GVAR(rad_doseThreshold_mild)):     { LLSTRING(radPrognosis_mild) };
    default { LLSTRING(radPrognosis_none) };
};

private _vomitTime = _patient getVariable [QGVAR(radTimeToVomit), -1];
private _emesis = if (_vomitTime < 0) then {
    LLSTRING(radEmesis_none)
} else {
    format [LLSTRING(radEmesis_since), round ((CBA_missionTime - _vomitTime) / 60)]
};

private _text = format [
    "%1<br/>%2<br/>%3",
    format [LLSTRING(radEstimate_dose), _dose toFixed 2],
    _prognosis,
    _emesis
];

[_text, 2, _medic] call ACEFUNC(common,displayTextStructured);
