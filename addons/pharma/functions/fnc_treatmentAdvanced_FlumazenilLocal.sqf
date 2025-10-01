#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Flumazenil unsedating process
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_FlumazenilLocal;
 *
 * Public: No
 */

params ["_patient", "_dose"];
private _currentWeight = _patient getVariable [QEGVAR(vitals,currentWeight), 80];
private _doseNormalized = linearConversion [10, 30, _dose, 15, 35, true];
private _weightNormalized = linearConversion [60, 100, _currentWeight, 10, 30, true];
if (_doseNormalized > _weightNormalized) then {
    private _medications = _patient getVariable [QACEGVAR(medical,medications), []];
    if (_medications findIf {_x isEqualTo "Lorazepam"} != -1) exitWith {
        [{
        params ["_patient"];
            [{
                params ["_args", "_idPFH"];
                _args params ["_patient", "_FlumanzenilTarget"];
                _FlumanzenilTarget = _FlumanzenilTarget + 1;
                _args set [1, _FlumanzenilTarget];
                if (!(alive _patient)) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                    _FlumanzenilTarget = _FlumanzenilTarget + 1;
                    if (_FlumanzenilTarget > 12) exitWith {
                        [{
                            params ["_args", "_idPFH"];
                            _args params ["_patient"];
                            private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];
                            {
                            _x params ["_medication"];
                            if (_medication isEqualTo "Lorazapam") then {
                                _medicationArray deleteAt (_medicationArray find _x);
                            };
                            } forEach _medicationArray;
                            _patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];
                        }, [_patient], 15] call CBA_fnc_waitAndExecute;
                        [_idPFH] call CBA_fnc_removePerFrameHandler;
                    };
                    private _depression = _patient getVariable [QEGVAR(pharma,opioidDepression)] - 0.08;
                    _patient setVariable [QEGVAR(pharma,opioidDepression), _depression, true];
            }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, [_patient], 10] call CBA_fnc_waitAndExecute;};
};

