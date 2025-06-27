#include "..\script_component.hpp"
/*
 * Author: Katalam, modified by Kygan, YetheSamartaka and Tomcat.
 * handles chest seal treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_treatmentAdvanced_chestSealLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

if (GVAR(clearChestSealAfterTreatment)) then {
    private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
    private _tensionpneumothorax = _patient getVariable [QGVAR(tensionpneumothorax), [false, false]];
    private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];

    if ((_hemopneumothorax select _side) || (_tensionpneumothorax select _side)) then {
        _activeChestSeal set [_side, true];
        _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
    };
} else {
    private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
    _activeChestSeal set [_side, true];
    _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
};

private _deepPenetratingInjury = _patient getVariable [QGVAR(deepPenetratingInjury), [false, false]];
private _pneumothorax = _patient getVariable [QGVAR(pneumothorax), [0, 0]];
private _pneumothoraxAmount = _patient getVariable [QGVAR(pneumothoraxSurfaceArea), [0, 0]] select _side;

_deepPenetratingInjury set [_side, false];
_pneumothorax set [_side, 0];

_patient setVariable [QGVAR(deepPenetratingInjury), _deepPenetratingInjury, true];
_patient setVariable [QGVAR(pneumothorax), _pneumothorax, true];
private _surface = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]);
private _surfaceArea = _surface + _pneumothoraxAmount;
_patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];

