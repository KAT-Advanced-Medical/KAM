#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 * handle VX gas poisoning
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_chemical_fnc_handleVX;
 *
 * Public: No
 */

params ["_unit"];
if (_unit getVariable [QGVAR(VXPoisoned), false]) exitWith {};
_unit setVariable [QGVAR(VXPoisoned), true, true];
_unit setVariable [QGVAR(VXPoisonedCycle), 0, true];
_timebetween = missionNamespace getVariable [QGVAR(vxCycleTime), 40];

[_unit, _timebetween] spawn {
    params ["_unit", "_timebetween"];

    while {alive _unit && (_unit getVariable [QGVAR(VXPoisoned), false]) && (_unit getVariable [QGVAR(airPoisoning), false])} do {
        private _cycle = (_unit getVariable [QGVAR(VXPoisonedCycle), 0]) + 1;
        _unit setVariable [QGVAR(VXPoisonedCycle), _cycle, true];

        switch (_cycle) do {
            case 1: {
                [_unit, 0.2] call ace_medical_fnc_adjustPainLevel;
                _unit setFatigue 1;
            };
            case 2: {
                // Add bradycardia
                [_unit, true] call ace_medical_fnc_setUnconscious;
                _unit setFatigue 1;
                [_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
            };
            case 3: {
                _unit setVariable ["kat_airway_occluded", true, true];
                _unit setVariable ["kat_airway_obstruction", true, true];
                _unit setFatigue 1;
                [_unit, true] call ace_medical_fnc_setUnconscious;
                [_unit] call kat_breathing_fnc_handleBreathing;
            };
            case 4: {
                _unit setVariable ["kat_airway_occluded", true, true];
                _unit setVariable [QEGVAR(circulation,cardiacArrestType), 4, true];
                ["ace_medical_FatalVitals", [_unit], _unit] call CBA_fnc_targetEvent;
                [_unit, true] call ace_medical_fnc_setUnconscious;
                [_unit] call kat_breathing_fnc_handleBreathing;
            };
            case 5: {
                _unit setVariable [QEGVAR(circulation,cardiacArrestType), 3, true];
                ["ace_medical_FatalVitals", [_unit], _unit] call CBA_fnc_targetEvent;
            };
            case 6: {
                
            };
            case 7: {
                
            };
            case 8: {
                _unit setVariable [QEGVAR(circulation,cardiacArrestType), 1, true];
                ["ace_medical_FatalVitals", [_unit], _unit] call CBA_fnc_targetEvent;
            };
            default {
                if (_cycle > 9) then {
                    _unit setDamage 1;
                };
            };
        };

        sleep _timebetween;
    };
    _unit setVariable [QGVAR(VXPoisoned), false, true];
};
