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
 * [player] call kat_pharma_fnc_coagRegen;
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

    private _bv = GET_BLOOD_VOLUME_LITERS(_unit);
    if (_bv < GVAR(coagulation_requireBV)) exitWith {}; // Blood volume check
    if ((GET_HEART_RATE(_unit) < 20) && GVAR(coagulation_requireHR)) exitWith {}; // Has pulse & require setting
    private _bodyFluid = GET_BODY_FLUID(_unit);
    private _currentCoagFactors = GET_BODY_FLUID_PLATELETS(_unit);
    private _savedCoagFactors = _unit getVariable [QGVAR(coagulationSavedFactors), GET_BODY_FLUID_PLATELETS(_unit)];
    private _cooldownON = _unit getVariable [QGVAR(coagulationRegenCooldown), false];
    private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
    private _medsToCheck = ["TXA", "EACA"];
    private _eacaEffectiveness = 0;
    private _txaEffectiveness = 0;
    {
        private _medName = toLower (_x select 0);
        private _effectiveness = _x select 2;
        if ("txa" in _medName) then {
            _txaEffectiveness = _txaEffectiveness max _effectiveness;
        };
        if ("eaca" in _medName) then {
            _eacaEffectiveness = _eacaEffectiveness max _effectiveness;
        };
    } forEach _medStack;

    if (_currentCoagFactors < _savedCoagFactors) exitWith {
        [{
            params["_unit"];
            _unit setVariable [QGVAR(coagulationSavedFactors), GET_BODY_FLUID_PLATELETS(_unit), true];
        },
        [_unit], ((missionNamespace getVariable [QGVAR(coagulation_factor_regenerate_time), 150]) / 2)] call CBA_fnc_waitAndExecute; // Block regen PFH instance from happening
    };

    if (_currentCoagFactors == _savedCoagFactors && _currentCoagFactors < 600) exitWith {
        private _bodyFluid = GET_BODY_FLUID(_unit);
        private _baseRegen = 3;
        private _pain = GET_PAIN(_unit);
        private _painBoost = linearConversion [0, 1, _pain, 0.01, 5, true];
        private _factorDeficit = 600 - _currentCoagFactors;
        private _reboundMultiplier = 1 + (1 - exp(-3 * (_factorDeficit / 600)));
        private _regenAmount = ((_baseRegen + _painBoost) * _reboundMultiplier) min _factorDeficit;
        private _totalAmount = _currentCoagFactors + _regenAmount;
        _bodyFluid set [5, _totalAmount];
        _unit setVariable [VAR_BODY_FLUID, _bodyFluid, true];
        _unit setVariable [QGVAR(coagulationSavedFactors), _currentCoagFactors + _regenAmount, true];
    };  

    if ((_currentCoagFactors > 600) && !(_cooldownON)) exitWith {

        if (_txaEffectiveness > 0 || _eacaEffectiveness > 0) exitWith {}; // If TXA or EACA is in system don't remove factor
        private _factorOverflow = (_currentCoagFactors - 600) max 0;
        private _reboundMultiplier = exp(2 * (_factorOverflow / 600)) - 1;
        _bodyFluid set [5, (_currentCoagFactors - (1 * _reboundMultiplier))];
        _unit setVariable [VAR_BODY_FLUID, _bodyFluid, true];
        _unit setVariable [QGVAR(coagulationSavedFactors), (_currentCoagFactors - (1 * _reboundMultiplier)), true];
        _unit setVariable [QGVAR(coagulationRegenCooldown), true, true];

        [{
            params["_unit"];
            _unit setVariable [QGVAR(coagulationRegenCooldown), false, true];
        },
        [_unit], missionNamespace getVariable [QGVAR(coagulation_factor_regenerate_time), 150]] call CBA_fnc_waitAndExecute;
    };

    _unit setVariable [QGVAR(coagulationSavedFactors), _currentCoagFactors, true];

}, missionNamespace getVariable [QGVAR(coagulation_factor_regenerate_time), 150], [_unit]] call CBA_fnc_addPerFrameHandler;
