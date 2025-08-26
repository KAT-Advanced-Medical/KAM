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
 * [player, 15] call kat_breathing_fnc_handlePneumothoraxTreatment;
 *
 * Public: No
 */

params ["_unit", "_chanceIncrease", "_side"];

[{
    params ["_unit", "_chanceIncrease", "_side"];

    private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]]; // Default: [0, 0] for both sides

    if ((_pneumothoraxState select _side > 0)) then {
        // Try to deteriorate at set interval
        [{

            params ["_args", "_idPFH"];
            _args params ["_unit", "_chanceIncrease", "_side"];

            private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]];
            private _tensionState = _unit getVariable [QGVAR(tensionpneumothorax), [false, false]];
            private _hemoState = _unit getVariable [QGVAR(hemopneumothorax), [false, false]];
                if (_pneumothoraxState select _side != 0) then {
                    // If patient is dead, treated, or already deteriorated to advanced pneumothorax, kill the PFH
                    if ((_hemoState select _side) ||
                        (_tensionState select _side) ||
                        !(alive _unit)) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                        systemChat "removing PFH"
                    };

                    if ((floor (random 100) < 50)) then {
                        private _ptxTarget = (_pneumothoraxState select _side) - 1;
                        if (_ptxTarget < 0) exitWith {
                            if (GVAR(clearChestSealAfterTreatment)) then {
                                private _activeChestSeal = _unit getVariable [QGVAR(activeChestSeal), [false, false]];
                                _activeChestSeal set [_side, false];
                                _unit setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
                                };
                            [_idPFH] call CBA_fnc_removePerFrameHandler;
                        };
                        private _baroMult = 1;
                        if (EGVAR(hypothermia,baroPressureEnable)) then {
                            if (EGVAR(hypothermia,useACEpressure)) then {
                            private _hPa = _altitude call ACEFUNC(weather,calculateBarometricPressure);
                            private _baroPressure = _hPa * 0.750062;
                        } else {
                            private _baroPressure = 760 * exp((-(_altitude)) / 8400);
                            };
                            private _defaultBaroPressure = 760 * exp((-(0)) / 8400);
                            _baroMult = _baroPressure / _defaultBaroPressure;
                        };
                        private _delay = (GVAR(chestSealTreatmentLoopTime) * _baroMult) * random [0.8, 1, 1.3];
                        private _surface = (_unit getVariable [QGVAR(lungSurfaceArea), 400]);
                        private _pneumothoraxSurfaceArea = _unit getVariable [QGVAR(pneumothoraxSurfaceArea), [0, 0]];
                        private _pneumothoraxAmount = _pneumothoraxSurfaceArea select _side;
                            if (_surface < 400) then {
                                private _surfaceArea = _surface + 10;
                                _pneumothoraxSurfaceArea set [_side, _pneumothoraxAmount - 10];
                                _unit setVariable [QGVAR(lungSurfaceArea), _surfaceArea];
                                _unit setVariable [QGVAR(pneumothoraxSurfaceArea), _pneumothoraxSurfaceArea];
                            };
                        _pneumothoraxState set [_side, _ptxTarget];
                        _unit setVariable [QGVAR(pneumothorax), _pneumothoraxState, true];
                    };
                };
        }, GVAR(chestSealTreatmentLoopTime), [_unit, _chanceIncrease, _side]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _chanceIncrease, _side], GVAR(chestSealTreatmentLoopTime)] call CBA_fnc_waitAndExecute;