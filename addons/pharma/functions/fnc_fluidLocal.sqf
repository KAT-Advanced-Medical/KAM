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

if (_classname in ["PackedRBCIV_500", "PackedRBCIV_250"]) then {
    private _plasma = (_fluidVolume select 1);
    private _ph = GET_PH(_patient);
    if ((_plasma <= 2000) && (_ph > 6.5) && (_ph < 8)) then {
        private _coagFactorMax = missionNamespace getVariable [QGVAR(coagulation_factor_limit), 60];
         private _factor = _patient getVariable [QGVAR(coagulationFactor), 30];
        private _final2 = (_factor + _coagulation) min _coagFactorMax;
        _patient setVariable [QGVAR(coagulationFactor), _final2, true];
    };
    } else {
        private _coagFactorMax = missionNamespace getVariable [QGVAR(coagulation_factor_limit), 60];
        private _factor = _patient getVariable [QGVAR(coagulationFactor), 30];
        private _final2 = (_factor + _coagulation) min _coagFactorMax;

        _patient setVariable [QGVAR(coagulationFactor), _final2, true];
    };
