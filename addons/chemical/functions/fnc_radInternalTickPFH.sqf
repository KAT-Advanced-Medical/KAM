#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Owner-local per-unit tick that turns internal radionuclide burden into
 * committed whole-body dose and decays the burden (biological elimination,
 * accelerated while a chelation window is active). Self-terminates when the
 * burden is cleared or the unit dies.
 *
 * Arguments:
 * 0: [_unit] <ARRAY>
 * 1: PFH handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_args", "_pfhHandle"];
_args params ["_unit"];

if (isNull _unit || {!alive _unit}) exitWith {
    if (!isNull _unit) then { _unit setVariable [QGVAR(radInternalPFHActive), false, true]; };
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};

private _burden = _unit getVariable [QGVAR(radInternalBurden), 0];

if (_burden < 0.001) exitWith {
    _unit setVariable [QGVAR(radInternalBurden), 0, true];
    _unit setVariable [QGVAR(radInternalPFHActive), false, true];
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};

private _interval = 5;

_unit setVariable [QGVAR(radDoseWB), (_unit getVariable [QGVAR(radDoseWB), 0]) + (_burden * GVAR(rad_internalConversionRate) * _interval), true];

private _decay = GVAR(rad_internalDecayRate);
if (CBA_missionTime < (_unit getVariable [QGVAR(radChelationWindow), 0])) then {
    _decay = _decay * GVAR(rad_chelationFactor);
};
_unit setVariable [QGVAR(radInternalBurden), _burden * (0 max (1 - (_decay * _interval))), true];

[_unit] call FUNC(evaluateRadDose);
