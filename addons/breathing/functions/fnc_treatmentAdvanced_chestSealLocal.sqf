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

private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
_activeChestSeal set [_side, true];
_patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
private _deepPenetratingInjury = _patient getVariable [QGVAR(deepPenetratingInjury), [false, false]];
systemChat str _deepPenetratingInjury;
_deepPenetratingInjury set [_side, false];
systemChat str _deepPenetratingInjury;
_patient setVariable [QGVAR(deepPenetratingInjury), _deepPenetratingInjury, true];
[_patient, 0, _side] call FUNC(handlePneumothoraxTreatment);

