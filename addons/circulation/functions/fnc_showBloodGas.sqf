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
_entries params ["_bloodGas", "_player", "_idNumber", "_vehicle"];
_bloodGas params ["_patientName", "_bloodGasArray"];
_bloodGasArray params ["_paCO2", "_paO2", "_spO2", "_hCO2", "_pH", "_etCO2"];

private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO2: %5, pH: %6", _patientName, _paCO2 toFixed 2, _paO2 toFixed 2, _spO2 toFixed 2, _hCO2 toFixed 2, _pH toFixed 2];
[_output, 3, _player] call ACEFUNC(common,displayTextStructured);

GVAR(resultCounter) = if (GVAR(resultCounter) == 20) then { 1 } else { GVAR(resultCounter) + 1 };
GVAR(resultSampleMap) set [GVAR(resultCounter), [_patientName, _bloodGasArray]];

private _itemStr = format ["KAT_bloodResult_%1",GVAR(resultCounter)];

[_vehicle, (format ["KAT_bloodSample_%1",_idNumber])] call CBA_fnc_removeItemCargo;
[_player, _itemStr, true] call CBA_fnc_addItem;