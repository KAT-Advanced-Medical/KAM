/*
 * Author: Katalam
 * Handle the X Series Defi for the patient.
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_aceCirculation_fnc_treatmentAdvanced_X
 *
 * Public: No
 */

params ["_player", "_target"];

private _string = "HR: %1 BP: %2/%3";
/*
if (kat_aceBreathing_enable && kat_aceExposure_enable) then {
	_string = "HR: %1 BP: %2/%3 SpO2: %4 T: %5";
};
*/

if (_target getVariable ["kat_aceCirculation_X", false]) exitWith {
  private _output = localize "STR_KAT_aceCirculation_X_already";
  [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
};

_target setVariable ["kat_aceCirculation_X", true, true];
_player setVariable ["kat_aceCirculation_use", true, true];

[{
  params ["_args", "_idPFH"];
  _args params ["_string", "_target"];
	if !(_target getVariable ["kat_aceCirculation_X", false]) exitWith {
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};
	[_target, "quick_view", _string, [_target getVariable ["ace_medical_heartRate", 80], (_target getVariable ["ace_medical_bloodPressure", [80,120]] select 1), (_target getVariable ["ace_medical_bloodPressure", [80,120]] select 0)]] call ace_medical_fnc_addToLog;
}, 1, [_string, _target]] call CBA_fnc_addPerFrameHandler;
