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
    [false]    call FUNC(effectLossCMR);
};

BEGIN_COUNTER(handleEffects);

// - Current state info -------------------------------------------------------
private _opioid          = GET_PP(ACE_player);
private _spO2             = GET_KAT_SPO2(ACE_player);
private _unconscious      = IS_UNCONSCIOUS(ACE_player);
private _pneumo          = ACE_player getVariable [QEGVAR(breathing,pneumothorax), [0,0]];
private _tensionPneumo   = ACE_player getVariable [QEGVAR(breathing,tensionpneumothorax), [false,false]];
private _hemoPneumo      = ACE_player getVariable [QEGVAR(breathing,hemopneumothorax), [0,0]];
private _lungSurface     = ACE_player getVariable [QEGVAR(breathing,lungSurfaceArea), 400];
private _pL = _pneumo select 0;
private _pR = _pneumo select 1;
private _tL = _tensionPneumo select 0;
private _tR = _tensionPneumo select 1;
private _hL = _hemoPneumo select 0;
private _hR = _hemoPneumo select 1;
private _wheeze = (
    _pL > 0.2 ||
    _pR > 0.2 ||
    _tL ||
    _tR ||
    _hL > 0.2 ||
    _hR > 0.2 ||
    _lungSurface < 350
);
private _eyeInjurySeverity        = GET_DUST_INJURY(ACE_player);
private _eyeInjuries        = GET_EYE_INJURIES(ACE_player);
private _cmr             = GET_CMR(ACE_player);

private _airwayState = HAS_AIRWAY(ACE_player);
// - Visual effects -----------------------------------------------------------
[!_unconscious, _opioid] call FUNC(effectOpioid);

[
    !_unconscious,
    linearConversion [90, EGVAR(breathing,SpO2_dieValue), _spO2, 0, 1, true]
] call FUNC(effectLowSpO2);
[!_unconscious, !_airwayState] call FUNC(effectAirways);
private _time = ACE_player getVariable [QGVAR(airwayInjuryColorTime), 0];
private _intensity = 0;
private _timeFixed = 0;
if (_time != 0) then {
    _timeFixed = CBA_missionTime - _time;
};
[!_unconscious, !_airwayState, linearConversion [0, 20, _timeFixed, 0, 1, true]] call FUNC(effectAirwaysColor);
[!_unconscious, _wheeze, ACE_player] call FUNC(effectBreathingWheeze);
[!_unconscious, _eyeInjurySeverity] call FUNC(effectEyeInjury);
[!_unconscious, _eyeInjuries, _manualUpdate] call FUNC(effectHurtEye);

[!_unconscious, _cmr] call FUNC(effectLossCMR);

END_COUNTER(handleEffects);
