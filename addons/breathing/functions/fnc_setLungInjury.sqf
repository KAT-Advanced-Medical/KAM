#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Applies diffuse, non-penetrating lung injury to a unit - chemical pneumonitis, smoke
 * inhalation, blast lung, aspiration. This is the entry point any addon or mod should use;
 * do not write kat_breathing_lungInjury directly.
 *
 * Severity raises the injury TARGET rather than the current value, so the injury ramps in
 * over time instead of appearing instantly. Repeated calls take the highest severity seen,
 * so two sources cannot fight each other.
 *
 * Runs local to the unit; forwards itself to the owner if called elsewhere.
 *
 * A unit can be opted out entirely by setting KAT_LungInjury_Exclusion to true on it.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target severity, 0 to 1. Clamped. <NUMBER>
 * 2: Cause id, shown to medics and used to route treatment (optional, default "") <STRING>
 * 3: Progression rate in severity per second (optional, default 0) <NUMBER>
 * 4: Severity below which progression does not apply (optional, default 0.35) <NUMBER>
 *
 * Progression is what separates a chemical injury from a traumatic one. Leave it at 0 - the
 * default - and the injury holds where it peaks until treated, which is correct for blast lung,
 * smoke inhalation and aspiration. Set it above 0 and the injury keeps worsening toward death
 * until atropine halts it or dexamethasone reverses it, which is correct for chemical agents.
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0.6, "phosgene", 0.0007, 0.15] call kat_breathing_fnc_setLungInjury;
 * [player, 0.5, "blast"] call kat_breathing_fnc_setLungInjury;  // holds, does not worsen
 *
 * Public: Yes
 */

params [["_unit", objNull, [objNull]], ["_severity", 0, [0]], ["_cause", "", [""]], ["_progression", 0, [0]], ["_progressiveMin", LUNG_INJURY_PROGRESSIVE_MIN, [0]]];

if (isNull _unit || {!(_unit isKindOf "CAManBase")} || {!alive _unit}) exitWith {};

if !((missionNamespace getVariable [QGVAR(enable), true]) && {missionNamespace getVariable [QGVAR(lungInjury_enable), true]}) exitWith {};

//Other mods can utilise KAT_LungInjury_Exclusion variable to prevent lung injury from happening
if (_unit getVariable ["KAT_LungInjury_Exclusion", false]) exitWith {};

if (!(isPlayer _unit) && {_unit getVariable [QEGVAR(vitals,simpleMedical), false]}) exitWith {};

if (!local _unit) exitWith {
    [QGVAR(setLungInjury), [_unit, _severity, _cause, _progression, _progressiveMin], _unit] call CBA_fnc_targetEvent;
};

_severity = (_severity max 0) min 1;
if (_severity <= 0) exitWith {};

// Progression is applied even when the severity below is not an increase, because a fresh
// exposure must re-arm deterioration on a casualty who was already stabilised with atropine.
if (_progression > 0) then {
    private _scaled = _progression * GVAR(lungInjury_progressionMultiplier);

    if (_scaled > (_unit getVariable [QGVAR(lungInjuryProgression), 0])) then {
        _unit setVariable [QGVAR(lungInjuryProgression), _scaled, true];

        // Travels with the rate it belongs to. Phosgene passes a lower bar than everything else,
        // because any dose of it you can feel is eventually fatal - that is the whole agent.
        _unit setVariable [QGVAR(lungInjuryProgressiveMin), _progressiveMin, true];
    };
};

// Worst active source wins; a milder source never pulls an existing injury down.
if (_severity <= (_unit getVariable [QGVAR(lungInjuryTarget), 0])) exitWith {};

_unit setVariable [QGVAR(lungInjuryTarget), _severity, true];

if (_cause isNotEqualTo "") then {
    _unit setVariable [QGVAR(lungInjuryCause), _cause, true];
};

TRACE_3("setLungInjury",_unit,_severity,_cause);
