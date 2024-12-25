#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Enables the audio on the Chemical Detector.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_chemical_enableChemDetector
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(detectorEnabled), true, true];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _alive = alive _unit;

    if (!_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_ChemicalDetector" in assignedItems _unit) exitWith {
        _unit setVariable [QGVAR(detectorEnabled), false, true];
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _detectorSound = _unit getVariable [QGVAR(detectorSound), false];
    private _intensity = _unit getVariable [QGVAR(areaIntensity), 0];

    if (_detectorSound) then {
        switch true do {
            case (_intensity > 0.9): { [QGVAR(playTone), [_unit, QGVAR(chemTone)], _unit] call CBA_fnc_targetEvent; };
            case (_intensity > 0.7): { [QGVAR(playTone), [_unit, QGVAR(chemRapidChime)], _unit] call CBA_fnc_targetEvent; };
            case (_intensity > 0.5): { [QGVAR(playTone), [_unit, QGVAR(chemFastChime)], _unit] call CBA_fnc_targetEvent; };
            case (_intensity > 0.3): { [QGVAR(playTone), [_unit, QGVAR(chemNormalChime)], _unit] call CBA_fnc_targetEvent; };
            case (_intensity > 0): { [QGVAR(playTone), [_unit, QGVAR(chemSlowChime)], _unit] call CBA_fnc_targetEvent; };
            default { [QGVAR(playTone), [_unit, QGVAR(chemBaseChime)], _unit] call CBA_fnc_targetEvent; };
        };
    };
}, 5, [_unit]] call CBA_fnc_addPerFrameHandler;