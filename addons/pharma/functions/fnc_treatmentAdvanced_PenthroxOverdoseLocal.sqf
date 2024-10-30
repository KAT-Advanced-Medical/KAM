#include "..\script_component.hpp"
/*
 * Author: Blue
 * Begins Penthrox Inhaler use
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", classname, objNull, "kat_Penthrox"] call kat_pharma_fnc_treatmentAdvanced_Penthrox;
 *
 * Public: No
 */
params ["_patient"];
[{
    params ["_patient"];
    private _PenthroxOverdoseTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _PenthroxOverdoseTarget = _PenthroxOverdoseTarget + 1;
                if (_PenthroxOverdoseTarget > 6) exitWith {
                    [{
                        if (random 25 < 1) then {
                        private _randomValue = [3, 4];
                        private _randomRhythm = selectRandom _randomValue;
                        _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
                        };
                    }, [_patient], 20] call CBA_fnc_waitAndExecute;
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _surfaceArea = (_patient getVariable [QGVAR(lungSurfaceArea), 400]) - 5;
                _patient setVariable [QGVAR(lungSurfaceArea), _surfaceArea];
                private _respRate = _patient getVariable [VAR_BREATHING_RATE, 15];
                _patient setVariable [VAR_BREATHING_RATE, (_respRate + 1), true];
                if ((random 1000) < 1) then {_patient setDamage 1;};
        }, 20, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 20] call CBA_fnc_waitAndExecute;

