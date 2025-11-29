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

params ["_unit", "_side"];

[{
    params ["_unit", "_side"];

    private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]]; // Default: [0, 0] for both sides

    if ((_pneumothoraxState select 0 > 0) || (_pneumothoraxState select 1 > 0)) then {
        // Try to deteriorate at set interval
        [{

            params ["_args", "_idPFH"];
            _args params ["_unit", "_side"];

            private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]];
            private _airway = HAS_AIRWAY(_unit);
            private _activeChestSeal = (_unit getVariable [QGVAR(activeChestSeal), [false, false]]) select _side;
            private _breathing = ((_airway) && ((GET_BREATHING_RATE(_unit) > 5) || (_unit getVariable [QEGVAR(breathing,BVMInUse), false]) || (_unit getVariable [QEGVAR(breathing,attachedVent), false])));
                if (_pneumothoraxState select _side > 0) then {
                    // If patient is dead, treated, or already deteriorated to advanced pneumothorax, kill the PFH
                    if (!(alive _unit) ||
                        (_pneumothoraxState select _side isEqualTo 0) || (_activeChestSeal) || (_pneumothoraxState select _side isEqualTo 16)) exitWith {
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                    };

                    if (floor (random 100) < GVAR(deterioratingPneumothorax_chance) && _breathing) then {
                        private _ptxTarget = (_pneumothoraxState select _side) + 1;
                        if ((_ptxTarget % 4) == 0) then {
                            if ((random 100 < 30) && GVAR(PneumothoraxArrest)) then {
                                [{

                                    params ["_unit"];
                                    if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                                    };
                                }, [_unit], GVAR(arrestPneumothorax_interval)] call CBA_fnc_waitAndExecute;
                            };
                            [_unit, _side, true] call FUNC(inflictAdvancedPneumothorax);
                            
                        };
                        if (_ptxTarget > 16) exitWith {
                            [_idPFH] call CBA_fnc_removePerFrameHandler;
                        };
                        private _baroMult = 1;
                        if (EGVAR(hypothermia,baroPressureEnable)) then {
                            private _altitude = (getPosASL _unit) select 2;
                            if (EGVAR(hypothermia,useACEpressure)) then {
                            private _hPa = _altitude call ACEFUNC(weather,calculateBarometricPressure);
                            private _baroPressure = _hPa * 0.750062;
                            private _defaulthPa = 0 call ACEFUNC(weather,calculateBarometricPressure);
                            private _defaultbaroPressure = _defaulthPa * 0.750062;
                            _baroMult = _baroPressure / _defaultBaroPressure;
                            } else {
                            private _baroPressure = 760 * exp((-(_altitude)) / 8400);
                            private _defaultBaroPressure = 760 * exp((-(0)) / 8400);
                            _baroMult = _baroPressure / _defaultBaroPressure;
                            };
                        };
                        private _delay = (GVAR(deterioratingPneumothorax_interval) * _baroMult) * random [0.8, 1, 1.3];
                        [_idPFH, _delay] call CBA_fnc_setPerFrameHandlerDelay;
                        _pneumothoraxState set [_side, _ptxTarget];
                        _unit setVariable [QGVAR(pneumothorax), _pneumothoraxState, true];
                    };
                };
        }, GVAR(deterioratingPneumothorax_interval), [_unit, _side]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _side], GVAR(deterioratingPneumothorax_interval)] call CBA_fnc_waitAndExecute;