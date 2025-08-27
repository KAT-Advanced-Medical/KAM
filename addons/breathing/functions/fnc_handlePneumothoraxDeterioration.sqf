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

params ["_unit", "_chanceIncrease", "_side"];

[{
    params ["_unit", "_chanceIncrease", "_side"];

    private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]]; // Default: [0, 0] for both sides

    if ((_pneumothoraxState select 0 > 0) || (_pneumothoraxState select 1 > 0)) then {
        // Try to deteriorate at set interval
        [{

            params ["_args", "_idPFH"];
            _args params ["_unit", "_chanceIncrease", "_side"];

            private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]];
            private _tensionState = _unit getVariable [QGVAR(tensionpneumothorax), [false, false]];
            private _hemoState = _unit getVariable [QGVAR(hemopneumothorax), [false, false]];
            private _occlusion = ((_unit getVariable [QEGVAR(airway,occlusion), [0, 0, 0]]) findIf { _x > 4 }) != -1;
            private _obstruction = ((_unit getVariable [QEGVAR(airway,obstruction), [0, 0, 0]]) findIf { _x != 0 }) != -1;
            private _activeChestSeal = (_unit getVariable [QGVAR(activeChestSeal), [false, false]]) select _side;
            if (EGVAR(hypothermia,baroPressureEnable)) then {
                if (EGVAR(hypothermia,useACEpressure)) then {
                private _hPa = _altitude call ACEFUNC(weather,calculateBarometricPressure);
                _baroPressure = _hPa * 0.750062;
            } else {
                _baroPressure = 760 * exp((-(_altitude)) / 8400);
                };
            };

            private _breathing = !(_obstruction) && !(_occlusion) && ((GET_BREATHING_RATE(_unit) > 5) || (_unit getVariable [QEGVAR(breathing,BVMInUse), false]));
                if (_pneumothoraxState select _side > 0) then {
                    // If patient is dead, treated, or already deteriorated to advanced pneumothorax, kill the PFH
                    if (!(alive _unit) ||
                        (_pneumothoraxState select _side isEqualTo 0) || (_activeChestSeal)) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                    };

                    if (floor (random 100) < GVAR(deterioratingPneumothorax_chance) && _breathing) then {
                        private _ptxTarget = (_pneumothoraxState select _side) + 1;
                        if (_ptxTarget % 4 == 0) then {
                            if ((random 100 < 30) && GVAR(PneumothoraxArrest)) then {
                                [{

                                    params ["_args", "_idPFH"];
                                    _args params ["_unit", "_side"];

                                    if ((_unit getVariable [QGVAR(pneumothorax), [0, 0]] select _side) % 4 == 0) then {
                                        private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
                                        if ((_ht findIf {_x isEqualTo "tension"}) == -1) then {
                                            _ht pushBack "tension";

                                            if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                                [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                                            };

                                            _unit setVariable [QEGVAR(circulation,ht), _ht, true];
                                        };
                                    };
                                }, [_unit, _side], GVAR(arrestPneumothorax_interval)] call CBA_fnc_waitAndExecute;
                            };

                            if (GVAR(advPtxEnable)) then {
                                [_unit, _chanceIncrease, _side, true] call FUNC(inflictAdvancedPneumothorax);
                            };
                            
                        };
                        if (_ptxTarget > 16) exitWith {
                            [_idPFH] call CBA_fnc_removePerFrameHandler;
                        };
                        private _baroMult = 1;
                        if (GVAR(baroPressureEnable)) then {
                            if (GVAR(useACEpressure)) then {
                            private _hPa = _altitude call ACEFUNC(weather,calculateBarometricPressure);
                            private _baroPressure = _hPa * 0.750062;
                        } else {
                            private _baroPressure = 760 * exp((-(_altitude)) / 8400);
                            };
                            private _defaultBaroPressure = 760 * exp((-(0)) / 8400);
                            _baroMult = _defaultBaroPressure / _baroPressure;
                        };
                        private _delay = (GVAR(deterioratingPneumothorax_interval) * _baroMult) * random [0.8, 1, 1.3];
                        [_idPFH, _delay] call CBA_fnc_setPerFrameHandlerDelay;
                        private _surface = (_unit getVariable [QGVAR(lungSurfaceArea), 400]);
                        private _pneumothoraxSurfaceArea = _unit getVariable [QGVAR(pneumothoraxSurfaceArea), [0, 0]];
                        private _pneumothoraxAmount = _pneumothoraxSurfaceArea select _side;
                            if (_surface > 150) then {
                                private _surfaceArea = _surface - 10;
                                _pneumothoraxSurfaceArea set [_side, _pneumothoraxAmount + 10];
                                _unit setVariable [QGVAR(lungSurfaceArea), _surfaceArea];
                                _unit setVariable [QGVAR(pneumothoraxSurfaceArea), _pneumothoraxSurfaceArea];
                            };
                        _pneumothoraxState set [_side, _ptxTarget];
                        _unit setVariable [QGVAR(pneumothorax), _pneumothoraxState, true];
                        [_unit, 0.8 * (_ptxTarget / 16)] call ACEFUNC(medical_status,adjustPainLevel);
                    };
                };
        }, GVAR(deterioratingPneumothorax_interval), [_unit, _chanceIncrease, _side]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _chanceIncrease, _side], GVAR(deterioratingPneumothorax_interval)] call CBA_fnc_waitAndExecute;