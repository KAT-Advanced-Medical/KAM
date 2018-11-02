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

params ["_player", "_target", "_className"];

diag_log "Local";
/*
_target getVariable ["kat_aceBreathing_pulsoxymeter", true, true];

if (_target getVariable ["kat_aceBreathing_pulsoxymeter", false]) exitWith {
  _output = localize "STR_kat_aceBreathing_pulsoxy_NA";
  [_output, 2, _caller] call ace_common_fnc_displayTextStructured;
  false;
};
/*
Here come the ability to use the pulsoxymeter from the patient. findDisplay or some shit in this direction
*
[{
  params ["_args", "_idPFH"];
  _args params ["_target"];
  if !(_target getVariable ["kat_aceBreathing_pulsoxymeter", false]) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
  };
  [_target, "quick_view", localize "STR_kat_aceBreathing_pulsoxy_Log", [_target getVariable ["ace_medical_heartRate", 80]]] call ace_medical_fnc_addToLog;
}, 1, [_target]] call CBA_fnc_addPerFrameHandler;

[_target, "activity", localize "STR_kat_aceBreathing_pulsoxy_Log_2", [[_player] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;
[_target, _Item] call ace_medical_fnc_addToTriageCard;
*/
