#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Locally changes a patient's PH value
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: pH value <NUMBER>
 * 2: Coagulation factors value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 500, 10] call kat_pharma_fnc_fluidLocal;
 *
 * Public: No
 */

params ["_patient", "_ph", "_coagulation", "_classname"];

private _current = _patient getVariable [QGVAR(externalPh), 0];
private _fluidVolume = GET_BODY_FLUID(_unit);

_patient setVariable [QGVAR(externalPh), ((_current + _ph) max 0), true];
_fluidVolume params ["_ECB","_ECP","_SRBC","_ISP","_fullVolume"];
