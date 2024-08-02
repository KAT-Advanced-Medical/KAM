#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks patient temperature
 *
 * Arguments:
 * 0: Array <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[[40,90,0.96,24,7.4,37], "Patient"], patient] call kat_circulation_fnc_showBloodGas;
 * 
 * Public: No
 */
params ["_entries"];

private _bloodGas = _entries select 0;
private _bloodGasArray = _bloodGas select 1;
private _patient = _bloodGas select 0;

private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO2: %5, pH: %6, ETCO2: %7", _patient, (_bloodGasArray select 0) toFixed 2, (_bloodGasArray select 1) toFixed 2, (_bloodGasArray select 2) toFixed 2, (_bloodGasArray select 3) toFixed 2, (_bloodGasArray select 4) toFixed 2, (_bloodGasArray select 5) toFixed 2];
[_output, 3, (_entries select 2)] call ACEFUNC(common,displayTextStructured);

GVAR(resultCounter) = if (GVAR(resultCounter) == 20) then { 1 } else { GVAR(resultCounter) + 1 };
GVAR(resultSampleMap) set [GVAR(resultCounter), [_patient, _bloodGasArray]];

private _itemStr = format ["KAT_bloodResult_%1",GVAR(resultCounter)];

[(_entries select 3), (format ["KAT_bloodSample_%1",(_entries select 2)])] call CBA_fnc_removeItemCargo;
[(_entries select 1), _itemStr, true] call CBA_fnc_addItem;