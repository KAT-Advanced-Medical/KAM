#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Server-side: (re)registers a contaminated unit as a weak beta/gamma point
 * source so it doses itself and anyone nearby and shows on geigers. Tagged with
 * contamSourceOwner so the unit's own exposure handler doesn't re-deposit
 * contamination from it (no feedback loop). The source self-removes via its
 * condition once the unit's contamination clears.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Contamination level (0..1) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_contam"];

if (isNull _unit) exitWith {};

private _gamma = _contam * GVAR(rad_crossContamStrength);
private _strengths = [0, _gamma * 0.5, _gamma, 0];

[QGVAR(addRadSource), [_unit, 4, _strengths, "linear", _unit, {
    params ["_unit"];
    !isNull _unit && {alive _unit} && {(_unit getVariable [QGVAR(radExternalContam), 0]) > 0.01}
}, [_unit]]] call CBA_fnc_localEvent;

private _entry = GVAR(radSources) getOrDefault [hashValue _unit, []];
if (_entry isNotEqualTo []) then {
    (_entry select 0) setVariable [QGVAR(contamSourceOwner), _unit, true];
};
