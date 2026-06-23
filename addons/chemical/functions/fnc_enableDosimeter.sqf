#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Starts the dosimeter audio loop. While the dosimeter sound is enabled it
 * emits geiger clicks whose tier scales with the current dose-rate, and only
 * while the unit is actually being irradiated. Single-instance; self-terminates
 * when the dosimeter is disabled, the unit dies, or the item is removed.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_chemical_fnc_enableDosimeter
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(dosimeterEnabled), true, true];

if (_unit getVariable [QGVAR(dosimeterAudioActive), false]) exitWith {};
_unit setVariable [QGVAR(dosimeterAudioActive), true, true];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    if (!alive _unit || {!("KAT_Dosimeter" in assignedItems _unit)} || {!(_unit getVariable [QGVAR(dosimeterEnabled), false])}) exitWith {
        _unit setVariable [QGVAR(dosimeterEnabled), false, true];
        _unit setVariable [QGVAR(dosimeterAudioActive), false, true];
        _idPFH call CBA_fnc_removePerFrameHandler;
    };

    if !(_unit getVariable [QGVAR(dosimeterSound), false]) exitWith {};

    private _rate = _unit getVariable [QGVAR(radDoseRate), 0];
    if (_rate < 0.01) exitWith {};

    private _tone = switch (true) do {
        case (_rate > 10):  { QGVAR(geiger_rapid) };
        case (_rate > 1):   { QGVAR(geiger_fast) };
        case (_rate > 0.1): { QGVAR(geiger_normal) };
        default             { QGVAR(geiger_slow) };
    };

    [QGVAR(playTone), [_unit, _tone], _unit] call CBA_fnc_targetEvent;
}, 5, [_unit]] call CBA_fnc_addPerFrameHandler;
