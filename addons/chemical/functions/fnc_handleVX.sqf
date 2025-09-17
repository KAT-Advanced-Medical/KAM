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


[{
    params ["_args", "_pfhID"];
    _args params ["_unit"];

    if(!(alive _unit && (_unit getVariable [QGVAR(VXPoisoned), false]) && (_unit getVariable [QGVAR(airPoisoning), false]))) then {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };


    private _cycle = (_unit getVariable [QGVAR(VXPoisonedCycle), 0]) + 1;
        _unit setVariable [QGVAR(VXPoisonedCycle), _cycle, true];

        switch (_cycle) do {
            case 1: {
                [_unit, 0.2] call ace_medical_fnc_adjustPainLevel;
                _unit setFatigue 1;
            };
            case 2: {
                [_unit, "BRADYCARDIA", 120, 1200, -40, 0, 0, 1, 0, 0, 0] call ACEFUNC(medical_status,addMedicationAdjustment);
                [_unit, true] call ace_medical_fnc_setUnconscious;
                _unit setFatigue 1;
                [_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
            };
            case 3: {
                _unit setVariable [QEGVAR(airway,occluded), true, true];
                _unit setVariable [QEGVAR(airway,obstruction), true, true];
                _unit setFatigue 1;
            };
            case 4: {
                _unit setVariable [QEGVAR(airway,occluded), true, true];
                ["ace_medical_FatalVitals", [_unit], _unit] call CBA_fnc_targetEvent;
                _unit setVariable [QEGVAR(circulation,cardiacArrestType), 4, true];
            };
            case 5: {
                ["ace_medical_FatalVitals", [_unit], _unit] call CBA_fnc_targetEvent;
                _unit setVariable [QEGVAR(circulation,cardiacArrestType), 3, true];
            };
            case 6: {
                
            };
            case 7: {
                
            };
            case 8: {
                ["ace_medical_FatalVitals", [_unit], _unit] call CBA_fnc_targetEvent;
                _unit setVariable [QEGVAR(circulation,cardiacArrestType), 1, true];
            };
            default {
                if (_cycle > 10) then {
                    _unit setDamage 1;
                };
            };
        };
}, _timebetween, [_unit]] call CBA_fnc_addPerFrameHandler;
