/*
 * Author: Katalam
 * docks a pulsximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 'KAT_Pulsoxymeter'] call kat_aceBreathing_fnc_treatmentAdvanced_pulsoxymeterLocal;
 *
 * Public: No
 */

params ["_player", "_target"];

_target setVariable ["kat_aceBreathing_pulsoxymeter", true, true];

_player removeItem "KAT_Pulsoxymeter";

[{
  params ["_args", "_idPFH"];
  _args params ["_target"];
  if !(_target getVariable ["kat_aceBreathing_pulsoxymeter", false]) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
  };
  [_target, "quick_view", localize "STR_kat_aceBreathing_pulsoxy_Log", [_target getVariable ["ace_medical_heartRate", 80]]] call ace_medical_fnc_addToLog;
}, 1, [_target]] call CBA_fnc_addPerFrameHandler;

[_target, "activity", localize "STR_kat_aceBreathing_pulsoxy_Log_2", [[_player] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;
[_target, "Pulsoxymeter"] call ace_medical_fnc_addToTriageCard;
