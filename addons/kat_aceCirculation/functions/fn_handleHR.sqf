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
/*
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
_currentWorkInMin = _currentWorkInMin max 8.9;
private _oxygen = 6 * _currentWorkInMin / 2826;
private _oxygenInl = _oxygen * 22.4;

private _bloodAmount = _oxygenInl * 1000 / 18 * 100;
if (_currentWorkInMin < 30) then {
	_bloodAmount = _oxygenInl * 10000; // 1000 / 10 * 100
};
private _heartRate = _bloodAmount / 1000 / 0.07;

private _new = (_heartRate - (ACE_PLAYER getVariable ["ace_medical_heartRate", 80])) min 170;

if (local ACE_PLAYER) then {
	[ACE_PLAYER, _new, 1, {diag_log "handleUnitVital"}] call ace_medical_fnc_addHeartRateAdjustment;
    diag_log formatText ["local addHeartRate %1 %2", _new, ACE_PLAYER];
} else {
	[[ACE_PLAYER, _new, 1, {diag_log "handleUnitVital"}], ace_medical_fnc_addHeartRateAdjustment] remoteExec ["call", ACE_PLAYER];
    diag_log formatText ["!local addHeartRate %1 %2", _new, ACE_PLAYER];
};

[kat_aceCirculation_fnc_handleHR, [], 3] call CBA_fnc_waitAndExecute;
*/
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
