#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handle the IV for the patient with blood types. Have to be local to avoid effect on all clients.
 *
 * Arguments:
 * 0: Classname <STRING>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ['Blood_IV_A', cursorTarget] call kat_circulation_fnc_treatmentAdvanced_IV
 *
 * Public: No
 */

params ["_className", "_unit"];

//unit, adjustment, time
private _volume = getNumber (configFile >> "ACE_Medical_Treatment" >> "IV" >> _className >> "volume");
[_unit, "BloodPoisoning", 120, 1200, 0, 0, 0, 0, -0.3] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_unit"];
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit", "_targetNumber"];
        private _medCount = [_unit, "BloodPoisoning"] call ACEFUNC(medical_status,getMedicationCount) select 0;
        _targetNumber = _targetNumber + 1;
        _args set [1, _targetNumber];
        if ((_medCount == 0) || !(alive _unit)) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            [{
                params ["_args", "_idPFH"];
                _args params ["_unit", "_count", "_targetNumber"];
                _count = _count + 1;
                _args set [1, _count];
                if ((_count == _targetNumber) || !(alive _unit)) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
                private _bronchospasmChange = _bronchospasm + 0.001;
                _unit setVariable [QEGVAR(breathing,bronchospasm), (_bronchospasmChange), true];
            }, 1, [_unit, 0, _targetNumber]] call CBA_fnc_addPerFrameHandler;
        };
        private _bloodlevels = GET_BODY_FLUID(_unit);
        _bloodlevels set [0, (_bloodlevels select 0) - 2];
        _unit setVariable [QEGVAR(circulation,bodyFluid), _bloodlevels, true];
        private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
        if (_bronchospasm > 0.5) then {
            private _bronchospasmChange = _bronchospasm - 0.001;
            _unit setVariable [QEGVAR(breathing,bronchospasm), (_bronchospasmChange), true];
        };
    }, 1, [_unit, 0]] call CBA_fnc_addPerFrameHandler;
}, [_unit], 120] call CBA_fnc_waitAndExecute;