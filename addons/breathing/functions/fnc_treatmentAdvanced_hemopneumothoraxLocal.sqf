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
    private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [0, 0]];
    _hemopneumothorax set [_side, 0];
    _patient setVariable [QGVAR(hemopneumothorax), _hemopneumothorax, true];
    [_patient, 0, _side] call FUNC(handlePneumothoraxTreatment);
};

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
    _ht deleteAt (_ht find "tension");
    _ht deleteAt (_ht find "hemo");
_patient setVariable [QEGVAR(circulation,ht), _ht, true];

private _pneumothorax = _patient getVariable [QGVAR(pneumothorax), [0, 0]];
private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [0, 0]];

if (((_pneumothorax select _side) == 0) &&
    ((_hemopneumothorax select _side) == 0) &&
    !((_patient getVariable [QGVAR(tensionPneumothorax), [false, false]]) select _side)) then {
    if (GVAR(clearChestSealAfterTreatment)) then {
        _activeChestSeal set [_side, false];
        _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
    };
};