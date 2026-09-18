#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Owner-local per-unit tick for external (surface) radioactive contamination.
 * Decays contamination by weathering and keeps the server-side
 * cross-contamination source in sync (so the unit doses itself and nearby
 * people and reads on geigers). Self-terminates and removes the source when
 * contamination is cleared (decon or full decay) or the unit dies.
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

if (isNull _unit || {!alive _unit} || {(_unit getVariable [QGVAR(radExternalContam), 0]) <= 0.01}) exitWith {
    if (!isNull _unit) then {
        _unit setVariable [QGVAR(radExternalContam), 0, true];
        _unit setVariable [QGVAR(radContamPFHActive), false, true];
        [QGVAR(serverRemoveContamSource), [_unit]] call CBA_fnc_serverEvent;
    };
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};

private _interval = 5;
private _contam = (_unit getVariable [QGVAR(radExternalContam), 0]) * (0 max (1 - (GVAR(rad_contaminationDecay) * _interval)));
_unit setVariable [QGVAR(radExternalContam), _contam, true];

[QGVAR(serverRegisterContamSource), [_unit, _contam]] call CBA_fnc_serverEvent;
