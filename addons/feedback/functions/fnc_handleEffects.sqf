#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles any visual effects of medical.
 *
 * Arguments:
 * 0: Manual, instant update (optional, default false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_feedback_fnc_handleEffects
 *
 * Public: No
 */
params [["_manualUpdate", false]];

if (ACEGVAR(common,OldIsCamera) || {!alive ACE_player}) exitWith {
    [false]    call FUNC(effectOpioid);
    [false]    call FUNC(effectLowSpO2);
    [false]    call FUNC(effectHurtEye);
    [false]    call FUNC(effectEyeInjury);
};

BEGIN_COUNTER(handleEffects);

// - Current state info -------------------------------------------------------
private _opioid          = GET_PP(ACE_player);
private _spO2             = GET_KAT_SPO2(ACE_player);
private _unconscious      = IS_UNCONSCIOUS(ACE_player);
private _wheeze = ((ACE_player getVariable [QEGVAR(breathing,pneumothorax), [0, 0]] select 0 > 0) || (ACE_player getVariable [QEGVAR(breathing,pneumothorax), [0, 0]] select 1 > 0) ||
  (ACE_player getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]] select 0) || (ACE_player getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]] select 1) ||(ACE_player getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]] select 0) || (ACE_player getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]] select 1));
private _eyeInjurySeverity        = GET_DUST_INJURY(ACE_player);
private _eyeInjuries        = GET_EYE_INJURIES(ACE_player);

private _occlusionArray = ACE_player getVariable [QEGVAR(airway,occlusion), [0, 0, 0]];
private _obstructionArray = ACE_player getVariable [QEGVAR(airway,obstruction), [0, 0, 0]];
if ((ACE_player getVariable [QEGVAR(airway,airway_item), ""]) isEqualTo "NPA") then {
    _occlusionArray = _occlusionArray select [1,2];
    _obstructionArray = _obstructionArray select [1,2];
};
private _occlusion = (_occlusionArray findIf { _x > 4 }) != -1;
private _obstruction = (_obstructionArray findIf { _x != 0 }) != -1;
private _airwayState = false;
private _catastrophicState = ACE_player getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
private _hasCatastrophicAirway = ((_catastrophicState select 0) || (_catastrophicState select 1));
private _airway = true;
private _breathing = true;
private _paralysis = ACE_player getVariable [QEGVAR(breathing,paralysis), 0] > 0.1;
if (_paralysis) then {
    _breathing = false;
};
private _noSurgicalAirway = (ACE_player getVariable [QEGVAR(airway,airway_item), ""] isNotEqualTo "Surgical_Airway");
private _noOverstretch = ACE_player getVariable [QEGVAR(airway,overstretch), false];
if (((_obstruction || _occlusion) || _hasCatastrophicAirway) && _noSurgicalAirway) then {
    _airway = false;
};
private _airwayState = ((!_airway) || (!_breathing));
// - Visual effects -----------------------------------------------------------
[!_unconscious, _opioid] call FUNC(effectOpioid);

[
    !_unconscious,
    linearConversion [90, EGVAR(breathing,SpO2_dieValue), _spO2, 0, 1, true]
] call FUNC(effectLowSpO2);
[!_unconscious, _airwayState] call FUNC(effectAirways);
private _time = ACE_player getVariable [QGVAR(airwayInjuryColorTime), 0];
private _intensity = 0;
private _timeFixed = 0;
if (_time != 0) then {
    _timeFixed = CBA_missionTime - _time;
};
[!_unconscious, _airwayState, linearConversion [0, 20, _timeFixed, 0, 1, true]] call FUNC(effectAirwaysColor);
[!_unconscious, _wheeze, ACE_player] call FUNC(effectBreathingWheeze);
[!_unconscious, _eyeInjurySeverity] call FUNC(effectEyeInjury);
[!_unconscious, _eyeInjuries, _manualUpdate] call FUNC(effectHurtEye);

END_COUNTER(handleEffects);
