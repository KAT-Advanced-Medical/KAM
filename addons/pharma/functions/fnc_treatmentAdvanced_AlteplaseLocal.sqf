#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Alteplase
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_pharma_fnc_treatmentAdvanced_AlteplaseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];
{
    _x params ["_medication"];
    private _lowerMed = toLower _medication;
    if (
        (_lowerMed find "txa" != -1) ||
        (_lowerMed find "eaca" != -1)
    ) then {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach _medicationArray;

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];
[{
    params ["_patient"];
    private _AlteplaseTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _AlteplaseTarget = _AlteplaseTarget + 1;
                if (_AlteplaseTarget > 24) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;};
                private _surfaceArea = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]) + 5;
                _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
                private _coagulationFactor = (_patient getVariable [QGVAR(coagulationFactor), 30]);
                private _factorstoremove = 1;
                _patient setVariable [QGVAR(coagulationFactor), (_coagulationFactor - _factorstoremove), true];
        }, 10, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 15] call CBA_fnc_waitAndExecute;
