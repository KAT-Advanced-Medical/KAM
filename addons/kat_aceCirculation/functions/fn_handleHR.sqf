/*
 * Author: Katalam
 * Handle the unit heartrate.
 * HAVE TO BE LOCAL!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceCirculation_fnc_handleHR;
 *
 * Public: No
 */

private _currentWork = 18.83;
private _currentSpeed = (vectorMagnitude (velocity ACE_PLAYER)) min 6;

if (ace_advanced_fatigue_isProne) then {
    _currentSpeed = _currentSpeed min 1.5;
};

if ((vehicle ACE_PLAYER == ACE_PLAYER) && {_currentSpeed > 0.1} && {isTouchingGround ACE_PLAYER || {underwater ACE_PLAYER}}) then {
    _currentWork = [ACE_PLAYER, _currentSpeed] call ace_advanced_fatigue_fnc_getMetabolicCosts;
    _currentWork = _currentWork max 18.83;
};
private _currentWorkInMin = _currentWork * 60 / 1000;
// joule/s goes to kJ/min
_currentWorkInMin = _currentWorkInMin max 8.9;
// if you stand your normal metabolic cost is like 8.9 kJ/min
private _oxygen = 6 * _currentWorkInMin / 2826;
// 2826 kJ is the ouput from 6 o2 atoms
private _oxygenInl = _oxygen * 22.4;
// normal material quantity in liter calculation of gas is 22.4

private _bloodAmount = _oxygenInl * 1000 / 18 * 100;
// 100 ml blood can transport 18 ml oxygen
if (_currentWorkInMin < 30) then {
	_bloodAmount = _oxygenInl * 10000; // 1000 / 10 * 100
	// 100 ml blood can transport 10 ml oxygen if your current work is too small
};
private _heartRate = _bloodAmount / 1000 / 0.07;
// ml in l and then stroke volume is 70 ml

private _oldHR = ACE_PLAYER getVariable ["ace_medical_heartRate", 80];
private _new = (_heartRate - _oldHR) min 150;

[ACE_PLAYER, _new, 2] call ace_medical_fnc_addHeartRateAdjustment;
[kat_aceCirculation_fnc_handleHR, [], 2] call CBA_fnc_waitAndExecute;

//-----------------------------------------------------------------------------

//TODO: Replace the ace_medical_fnc_addHeartRateAdjustment. It can't handle so much data

/*
[{
	params ["_args"];
	_args params ["_unit"];

	private _unit = player;
	private _currentWork = 18.83;
	private _currentSpeed = (vectorMagnitude (velocity _unit)) min 6;

	if (ace_advanced_fatigue_isProne) then {
		_currentSpeed = _currentSpeed min 1.5;
	};

	if ((vehicle _unit == _unit) && {_currentSpeed > 0.1} && {isTouchingGround _unit || {underwater _unit}}) then {
		_currentWork = [_unit, _currentSpeed] call ace_advanced_fatigue_fnc_getMetabolicCosts;
		_currentWork = _currentWork max 18.83;
	};
	private _currentWorkInMin = _currentWork * 60 / 1000;
	_currentWorkInMin = _currentWorkInMin max 8.9;
	private _oxygen = 6 * _currentWorkInMin / 2826;
	private _oxygenInl = _oxygen * 22.4;

	private _bloodAmount = _oxygenInl * 1000 / 18 * 100;
	if (_currentWorkInMin < 30) then {
		_bloodAmount = _oxygenInl * 1000 / 10 * 100;
	};
	private _heartRate = _bloodAmount / 1000 / 0.07;

	private _new = (_heartRate - (_unit getVariable ["ace_medical_heartRate", 80])) min 170;
	[[_unit, _new, 2], ace_medical_fnc_addHeartRateAdjustment] remoteExec ["call", _unit];
	diag_log _new;
}, 3, [player]] call CBA_fnc_addPerFrameHandler;
*/
