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
        _unit setVariable [QGVAR(airPoisoning), true, true];
        _unit setVariable [QEGVAR(breathing,respiratoryDepth), 0.4, true];
        [QEGVAR(breathing,playCough), [_unit], _unit] call CBA_fnc_targetEvent;
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

    case "radProdromal": {
        if ((_unit getVariable [QGVAR(radTimeToVomit), -1]) < 0) then {
            _unit setVariable [QGVAR(radTimeToVomit), CBA_missionTime, true];
        };

        private _sounds = [
            QPATHTOEF_SOUND(airway,sounds\puking1.wav),
            QPATHTOEF_SOUND(airway,sounds\puking2.wav),
            QPATHTOEF_SOUND(airway,sounds\puking1.wav)
        ];
        if (CBA_missionTime >= (_unit getVariable [QGVAR(radAntiemeticWindow), 0])) then {
            playSound3D [selectRandom _sounds, _unit, false, getPosASL _unit, 8, 1, 15];
        };

        private _pain = _unit getVariable [VAR_PAIN, 0];
        _unit setVariable [VAR_PAIN, (_pain + 0.1) min 1, true];

        if (GVAR(rad_showSickness) && {_unit == ACE_player}) then {
            [LLSTRING(radHint_nausea), 1.5, _unit] call ACEFUNC(common,displayTextStructured);
        };
    };
    case "radHema": {
        private _pain = _unit getVariable [VAR_PAIN, 0];
        _unit setVariable [VAR_PAIN, (_pain + 0.15) min 1, true];

        if (GVAR(rad_showSickness) && {_unit == ACE_player}) then {
            [LLSTRING(radHint_weak), 1.5, _unit] call ACEFUNC(common,displayTextStructured);
        };
    };
    case "radGI": {
        private _sounds = [
            QPATHTOEF_SOUND(airway,sounds\puking1.wav),
            QPATHTOEF_SOUND(airway,sounds\puking2.wav)
        ];
        if (CBA_missionTime >= (_unit getVariable [QGVAR(radAntiemeticWindow), 0])) then {
            playSound3D [selectRandom _sounds, _unit, false, getPosASL _unit, 8, 1, 15];
        };

        private _pain = _unit getVariable [VAR_PAIN, 0];
        _unit setVariable [VAR_PAIN, (_pain + 0.25) min 1, true];

        if (GVAR(rad_showSickness) && {_unit == ACE_player}) then {
            [LLSTRING(radHint_gi), 1.5, _unit] call ACEFUNC(common,displayTextStructured);
        };
    };
    case "radCNS": {
        [_unit, true] call ACEFUNC(medical,setUnconscious);
    };
    case "radCardiac": {
        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    };
};
