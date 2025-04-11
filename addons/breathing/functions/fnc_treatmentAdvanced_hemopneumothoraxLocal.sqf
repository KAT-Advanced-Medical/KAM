#include "..\script_component.hpp"
/*
 * Author: Kygan, modified by YetheSamartaka and Tomcat.
 * Treatment for hemopneumothorax
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
 * call kat_breathing_fnc_treatmentAdvanced_hemopneumothoraxLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
if (_activeChestSeal select _side) then {
    private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
    _hemopneumothorax set [_side, false];
    _patient setVariable [QGVAR(hemopneumothorax), _hemopneumothorax, true];
};

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
_ht deleteAt (_ht find "tension");
_patient setVariable [QEGVAR(circulation,ht), _ht, true];

if ((_patient getVariable [QGVAR(pneumothorax), 0] == 0) && !(_patient getVariable [QGVAR(hemopneumothorax), false]) && !(_patient getVariable [QGVAR(tensionpneumothorax), false])) then {
    [_patient, 0, 0, "ptx_tension", true] call EFUNC(circulation,updateBloodPressureChange);
    if (GVAR(clearChestSealAfterTreatment)) then {
        _patient setVariable [QGVAR(activeChestSeal), false, true];
    };
};

private _pneumothorax = _patient getVariable [QGVAR(pneumothorax), [0, 0]];
private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];

if (!(_patient getVariable [QGVAR(pneumothorax), [0, 0]] select _side > 0) &&
    !(_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select _side) &&
    !((_patient getVariable [QGVAR(tensionPneumothorax), [false, false]]) select _side)) then {
    
    [_patient, 0, 0, format ["ptx_tension_%1", _side], true] call EFUNC(circulation,updateBloodPressureChange);
    
    if (GVAR(clearChestSealAfterTreatment)) then {
        _activeChestSeal set [_side, false];
        _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
    };
};