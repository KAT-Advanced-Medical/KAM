#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Eden module that spawns a radiation source. Resolves a preset (or the
 * per-type Custom fields) into a [alpha,beta,gamma,neutron] strength array and
 * registers the source. Cannot be called manually.
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: Affected Units (unused) <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_logic", "_units", "_activated"];

private _radius = _logic getVariable ["Radius", 20];
private _pointSource = _logic getVariable ["PointSource", false];
private _presetName = ["custom", "Cobalt60", "Reactor", "Fallout", "AlphaEmitter", "DirtyBomb"] param [_logic getVariable ["Preset", 0], "custom"];

private _strengths = if (_presetName isEqualTo "custom") then {
    [_logic getVariable ["Alpha", 0], _logic getVariable ["Beta", 0], _logic getVariable ["Gamma", 0], _logic getVariable ["Neutron", 0]]
} else {
    +(GVAR(radPresets) getOrDefault [_presetName, [0, 0, 0, 0]])
};

if (count _units == 0) then {_units pushBack _logic;};

if (!_activated) exitWith {};

if (isServer) then {
    [{
        params ["_logic", "_radius", "_strengths", "_pointSource", "_units"];

        private _falloff = ["linear", "inverseSquare"] select _pointSource;

        {
            [QGVAR(addRadSource), [_x, _radius, _strengths, _falloff, _x, {
                params ["_endTime", "_logic"];

                if (isNull _logic) exitWith {
                    false
                };

                CBA_missionTime < _endTime
            }, [CBA_missionTime + 1e10, _logic]]] call CBA_fnc_serverEvent;

        } forEach _units;

    }, [_logic, _radius, _strengths, _pointSource, _units], 1] call CBA_fnc_waitAndExecute;
};
