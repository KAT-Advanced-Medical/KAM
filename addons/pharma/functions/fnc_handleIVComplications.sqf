#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles advanced IV complications
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: flowDifference (difference in fluid between the cap and the actual)<Number>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1] call kat_pharma_fnc_handleIVComplications
 *
 * Public: No
 */
 params ["_patient", "_flowDifference"];

[{
    params ["_patient", "_flowDifference"];
    private _IVComplicationTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _IVComplicationTarget = _IVComplicationTarget + 1;
                if (_IVComplicationTarget > 24) exitWith {
                    if (random(100) < 33) then {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];
                        private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
                        if ((_ht findIf {_x isEqualTo "TRALI"}) == -1) then {
                            _ht pushBack "TRALI";

                            if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                            };

                            _patient setVariable [QEGVAR(circulation,ht), _ht, true];
                            };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
				if (_IVComplicationTarget > 6) then {
					_patient setVariable [QEGVAR(breathing,TRALI), true, true];
					};
				if (_flowDifference < 1) exitWith {
					[_idPFH] call CBA_fnc_removePerFrameHandler;
					};
                private _surface = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]);
                if (_surface < 100) then {
                    } else {
                        private _surfaceArea = _surface - 5;
                        _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
                    };
                private _rr = _patient getVariable [QEGVAR(breathing,respiratoryRateMultiplier), 1] + 0.05;
                _patient setVariable [QEGVAR(breathing,respiratoryRateMultiplier), _rr];
        }, 60, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 15] call CBA_fnc_waitAndExecute;
