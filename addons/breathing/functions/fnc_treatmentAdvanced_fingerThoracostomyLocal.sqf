#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Treatment for hemopneumothorax/tensionPnumo
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_fingerThoracostomyLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

private _lidocaineCount = [_patient, "Lidocaine", false] call ACEFUNC(medical_status,getMedicationCount);
private _morphineCount = [_patient, "Morphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount = [_patient, "Nalbuphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount = [_patient, "Fentanyl", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount = [_patient, "Ketamine", false] call ACEFUNC(medical_status,getMedicationCount);
if ((_lidocaineCount <=  0.6 && _morphineCount <=  0.8 && _nalbuphineCount <=  0.8 && _fentanylCount <=  0.8 && _ketamineCount <=  0.8) || !IS_UNCONSCIOUS(_patient)) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] call ACEFUNC(medical_status,adjustPainLevel);
};
if (random 100 <= 30) exitWith {};
private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
if (_activeChestSeal select _side) then {
    private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
    _hemopneumothorax set [_side, false];
    _patient setVariable [QGVAR(hemopneumothorax), _hemopneumothorax, true];
    private _tensionPneumothorax = _patient getVariable [QGVAR(tensionPneumothorax), [false, false]];
    _tensionPneumothorax set [_side, false];
    _patient setVariable [QGVAR(tensionPneumothorax), _tensionPneumothorax, true];
};

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
_ht deleteAt (_ht find "tension");
_patient setVariable [QEGVAR(circulation,ht), _ht, true];

private _pneumothorax = _patient getVariable [QGVAR(pneumothorax), [0, 0]];
private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];

if ((_patient getVariable [QGVAR(pneumothorax), [0, 0]] select _side > 0) &&
    !(_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select _side) &&
    !((_patient getVariable [QGVAR(tensionPneumothorax), [false, false]]) select _side)) then {
    
    [_patient, 0, 0, format ["ptx_tension_%1", _side], true] call EFUNC(circulation,updateBloodPressureChange);
    
    if (GVAR(clearChestSealAfterTreatment)) then {
        _activeChestSeal set [_side, false];
        _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
    };
};