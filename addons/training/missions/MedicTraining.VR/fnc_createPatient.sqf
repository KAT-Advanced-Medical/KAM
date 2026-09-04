#include "script_component.hpp"
/*
 * Author: kolmipilot
 * mission patient handiling
 *
 * Arguments:
 * 0: Mode (damaged = 1, not = 0)<Number>
 *
 * Return Value:
 * Can use NPWT <BOOLEAN>
 *
 * Example:
 * [1] call kat_training_fnc_createPatient
 *
 * Public: No
 */

params ["_mode"];
private _pos = getPos hspawn;
private _group = createGroup [civilian, true];
private _patient = _group createUnit ["B_Soldier_F", _pos, [], 0, "NONE"];

_patient disableAI "MOVE";
_patient disableAI "FSM";
missionNamespace setVariable ["kat_training_lastPatient", _patient, true];
spawned = true;
publicVariable "spawned";
if (_mode == 1) then {
    [_patient, true] call ace_medical_fnc_setUnconscious;
    private _selections = ["body", "head", "hand_r", "hand_l", "leg_r", "leg_l"];
    for "_i" from 1 to 4 do {
        private _sel = selectRandom _selections;
        [_patient, 0.8, _sel, "bullet"] call ace_medical_fnc_addDamageToUnit;
    };
};
