#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins CWMP Treatment
 *
 * Arguments:
 * 0: patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_CWMPOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
[_patient, "CWMPOverdose", 30, 600, "", "", "", 0.3, "", ""] call EFUNC(vitals,addMedicationAdjustment);
if GVAR(kidneyAction) then
    {[
        {
        params ["_patient"];
        private _kidneyTarget = 0;
        [{
        params ["_patient", "_idPFH"];
        if (!(alive _patient)) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _kidneyTarget = _kidneyTarget + 1;
                if (_kidneyTarget > 12) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;};
                private _ph = _patient getVariable [QGVAR(externalPh), _ph, true] + 100;
                _patient setVariable [QGVAR(externalPh), _ph, true];
                private _coagulationFactor = (_patient getVariable [QGVAR(coagulationFactor), 30]);
                private _factorstoremove = 1;
                _patient setVariable [QGVAR(coagulationFactor), (_coagulationFactor - _factorstoremove), true];
                }, 10, [_patient]] call CBA_fnc_addPerFrameHandler;
    }, _patient, 15] call CBA_fnc_waitAndExecute;
}
[{
    params ["_patient"];
    private _bpTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _bpTarget = _bpTarget + 1;
                if (_bpTarget > 12) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;};
                [_patient, -2, -2, "CWMPOverdose"] call kat_circulation_fnc_updateBloodPressureChange;
        }, 15, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 15] call CBA_fnc_waitAndExecute;