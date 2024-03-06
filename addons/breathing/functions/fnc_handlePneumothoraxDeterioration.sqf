#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle pneumothorax deterioration
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Deterioration chance increase <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 15] call kat_breathing_fnc_handlePneumothoraxDeterioration;
 *
 * Public: No
 */

params ["_unit", "_chanceIncrease"];

[{
    params ["_unit", "_chanceIncrease"];

    if (_unit getVariable [QGVAR(pneumothorax), 0] > 0) then {
        // Try to deteriorate at set interval
        [{
            params ["_args", "_idPFH"];
            _args params ["_unit", "_chanceIncrease"];

            private _breathing = !(_unit getVariable [QEGVAR(airway,occluded), false]) && !(_unit getVariable [QEGVAR(airway,obstruction), false]) && (GET_HEART_RATE(_unit) > 20);

            // If patient is dead, already treated or has already deteriorated into advanced pneumothorax, kill the PFH
            if (_unit getVariable [QGVAR(hemopneumothorax), false] || _unit getVariable [QGVAR(tensionpneumothorax), false] || !(alive _unit) || _unit getVariable [QGVAR(pneumothorax), 0] isEqualTo 0) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            if (floor (random 100) <= GVAR(deterioratingPneumothorax_chance) && _breathing) then {
                private _ptxTarget = (_unit getVariable [QGVAR(pneumothorax), 0]) + 1;
                // Once deteriorated far enough try to inflict advanced pneumothorax or if disabled kill the PFH
                if (_ptxTarget > 4) exitWith {
                    if (GVAR(advPtxEnable)) then {
                        [_unit, _chanceIncrease, true] call FUNC(inflictAdvancedPneumothorax);
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                _unit setVariable [QGVAR(pneumothorax), _ptxTarget, true];
                [_unit, 0.5 * (_ptxTarget / 4)] call ACEFUNC(medical_status,adjustPainLevel); // Adjust pain based on severity
                [_unit, -12, -12, "ptx_tension"] call EFUNC(circulation,updateBloodPressureChange); // Simulate low blood pressure and high heart rate caused by pneumothorax
            };
        }, GVAR(deterioratingPneumothorax_interval), [_unit, _chanceIncrease]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _chanceIncrease], GVAR(deterioratingPneumothorax_interval)] call CBA_fnc_waitAndExecute;