#include "..\script_component.hpp"
/*
 * Author: Kygan, modified by YetheSamartaka and Tomcat.
 * Treatment for tension pneumothorax
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
 * call kat_breathing_fnc_treatmentAdvanced_tensionpneumothoraxLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
if (_activeChestSeal select _side) then {
    private _tensionPneumothorax = _patient getVariable [QGVAR(tensionPneumothorax), [false, false]];
    _tensionPneumothorax set [_side, false];
    _patient setVariable [QGVAR(tensionPneumothorax), _tensionPneumothorax, true];
};

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
private _tensionIndex = _ht find "tension";

if (_tensionIndex > -1) then {
    _ht deleteAt _tensionIndex;
    _patient setVariable [QEGVAR(circulation,ht), _ht, true];
};

if (!(_patient getVariable [QGVAR(pneumothorax), [0, 0]] select _side > 0) &&
    !(_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select _side) &&
    !((_patient getVariable [QGVAR(tensionPneumothorax), [false, false]]) select _side)) then {
    
    [_patient, 0, 0, format ["ptx_tension_%1", _side], true] call EFUNC(circulation,updateBloodPressureChange);
    
    if (GVAR(clearChestSealAfterTreatment)) then {
        _activeChestSeal set [_side, false];
        _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
    };
};
