#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Regenerates clots
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_clotWound;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(coagulation)) exitWith {};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _alive = alive _unit;

    if !(_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (!GVAR(coagulation_allowOnAI) && ACE_Player != _unit) exitWith { // Check allowOnAI setting to save performance
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (GET_BLOOD_VOLUME_LITERS(_unit) < GVAR(coagulation_requireBV)) exitWith {}; // Blood volume check
    if ((_pulse < 20) && GVAR(coagulation_requireHR)) exitWith {}; // Has pulse & require setting

    private _currentCoagFactors = _unit getVariable [QGVAR(coagulationFactor), 30];
    private _savedCoagFactors = _unit getVariable [QGVAR(coagulationSavedFactors), (_unit getVariable [QGVAR(coagulationFactor), 30])];
    private _limitRegenCoagFactors = missionNamespace getVariable [QGVAR(coagulation_factor_count), 30];
    private _cooldownON = _unit getVariable [QGVAR(coagulationRegenCooldown), false];
    private _countTXA = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);
    private _countEACA = [_unit, "EACA"] call ACEFUNC(medical_status,getMedicationCount);
    private _ammountToAdd = 1;

    if (_currentCoagFactors < _savedCoagFactors) exitWith {
        [{
            params["_unit"];
            _unit setVariable [QGVAR(coagulationSavedFactors), _unit getVariable [QGVAR(coagulationFactor), 30], true];
        },
        [_unit], ((missionNamespace getVariable [QGVAR(coagulation_factor_regenerate_time), 150]) / 2)] call CBA_fnc_waitAndExecute; // Block regen PFH instance from happening
    };

    if (_currentCoagFactors == _savedCoagFactors && _currentCoagFactors < _limitRegenCoagFactors) exitWith {

        if (_countTXA > 0 || _countEACA > 0) then { // If TXA or EACA are in system add more factors
            if (_countTXA > 0 && _countEACA > 0) exitWith {
                _ammountToAdd = 4;
            };
            _ammountToAdd = 2;
        };

        _unit setVariable [QGVAR(coagulationFactor), (_currentCoagFactors + _ammountToAdd), true];
        _unit setVariable [QGVAR(coagulationSavedFactors), (_currentCoagFactors + _ammountToAdd), true];
    };

    if (_currentCoagFactors > _limitRegenCoagFactors && !(_cooldownON)) exitWith {

        if (_countTXA > 0 || _countEACA > 0) exitWith {}; // If TXA or EACA is in system don't remove factor

        _unit setVariable [QGVAR(coagulationFactor), (_currentCoagFactors - 1), true];
        _unit setVariable [QGVAR(coagulationSavedFactors), (_currentCoagFactors - 1), true];
        _unit setVariable [QGVAR(coagulationRegenCooldown), true, true];

        [{
            params["_unit"];
            _unit setVariable [QGVAR(coagulationRegenCooldown), false, true];
        },
        [_unit], missionNamespace getVariable [QGVAR(coagulation_factor_regenerate_time), 150]] call CBA_fnc_waitAndExecute;
    };

    _unit setVariable [QGVAR(coagulationSavedFactors), _currentCoagFactors, true];

}, missionNamespace getVariable [QGVAR(coagulation_factor_regenerate_time), 150], [_unit]] call CBA_fnc_addPerFrameHandler;
