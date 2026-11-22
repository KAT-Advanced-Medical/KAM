#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Sends an injury to the selected patient of a training computer. The injury itself is applied where the patient is local.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 * 1: Player <OBJECT>
 * 2: Injury type, see kat_training_fnc_addInjury <STRING>
 * 3+: Injury arguments <ANY> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player, "fracture", "leftleg", 3] call kat_training_fnc_requestInjury
 *
 * Public: No
 */

params [["_computer", objNull, [objNull]], ["_player", objNull, [objNull]], ["_type", "", [""]]];

private _patient = _computer getVariable [QGVAR(patient), objNull];

if (!alive _patient) exitWith {
    [LLSTRING(NoPatient), 1.5, _player] call ACEFUNC(common,displayTextStructured);
};

[QGVAR(addInjury), [_patient, _type, _this select [3]], _patient] call CBA_fnc_targetEvent;

[format [LLSTRING(InjuryApplied), [_patient] call ACEFUNC(common,getName)], 1.5, _player] call ACEFUNC(common,displayTextStructured);
