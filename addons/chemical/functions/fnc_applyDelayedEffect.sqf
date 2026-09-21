#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Dispatcher for delayed effects fired by the exposure watcher PFH. Runs
 * local to the unit (via QGVAR(applyDelayedEffect) target event).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Effect name <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_effect"];

if (!alive _unit) exitWith {};

switch (_effect) do {
    case "phosgenePulmonary": {
        if (LUNG_MODEL_ACTIVE) then {
            // Latency is over. Release the dose accumulated in the cloud as real lung injury,
            // which then ramps in over the next minute or so rather than landing all at once.
            private _gasData = GVAR(gasRegistry) getOrDefault ["phosgene", createHashMap];
            private _lct = (_gasData getOrDefault ["lungLCt", 60]) max 1;
            private _cap = _gasData getOrDefault ["lungInjuryCap", 0.9];
            private _severity = (((_unit getVariable [QGVAR(lungDose), 0]) / _lct) min 1) * _cap;

            _unit setVariable [QGVAR(lungOnsetFired), true, true];
            [QEGVAR(breathing,setLungInjury), [_unit, _severity, "phosgene", _gasData getOrDefault ["lungProgression", 0], _gasData getOrDefault ["lungProgressiveMin", LUNG_INJURY_PROGRESSIVE_MIN]]] call CBA_fnc_localEvent;
        } else {
            _unit setVariable [QGVAR(airPoisoning), true, true];
        };

        private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];
        
        if (_soundTargets isNotEqualTo []) then {
            [QEGVAR(breathing,playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
        };
    };
    case "mustardEye": {
        _unit setVariable [QEGVAR(ophthalmology,dustInjuryHeavy), 4, true];

        private _eyeInjuries = _unit getVariable [QEGVAR(ophthalmology,eyeInjuries), [1, 1]];

        // Randomly choose which eye to injure (0 = right, 1 = left)
        private _injuredEye = floor random 2;

        // Set the chosen eye to injured
        _eyeInjuries set [_injuredEye, 0];

        if (({_x == 0} count _eyeInjuries) > 1) then {
            _unit setVariable [QEGVAR(ophthalmology,eyeInjurySevere), true, true];
        };

        _unit setVariable [QEGVAR(ophthalmology,eyeInjuries), _eyeInjuries, true];
    };
    case "mustardBurn": {
        _unit setVariable [QGVAR(mustardBurnActive), true, true];
        [_unit] call FUNC(applyMustardDamage);
    };
    case "vomit": {
        private _sounds = [
            QPATHTOEF_SOUND(airway,sounds\puking1.wav),
            QPATHTOEF_SOUND(airway,sounds\puking2.wav),
            QPATHTOEF_SOUND(airway,sounds\puking1.wav)
        ];
        playSound3D [selectRandom _sounds, _unit, false, getPosASL _unit, 8, 1, 15];
    };
    case "unconscious": {
        [_unit, true] call ACEFUNC(medical,setUnconscious);
    };
    case "cardiac": {
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
};
