#include "..\script_component.hpp"
/*
 * Author: Claude
 * Reply handler run on the medic's own machine once the server has processed a
 * blood sample test. Shows the reading, removes the consumed sample item from
 * the vehicle and gives the medic the result item, or tells the medic the
 * sample was no longer available / no result slot was free.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Result: "ok", "invalid" (sample no longer exists) or "full" (no result slot free) <STRING>
 * 2: Result slot id, -1 on failure <NUMBER>
 * 3: Sample slot id that was tested <NUMBER>
 * 4: Vehicle the sample was tested at <OBJECT>
 * 5: Sample entry [patientName, bloodGasArray, timestamp], [] on failure <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ok", 5, 3, vehicle, ["Alice", [40,90,0.96,24,7.4,37], 120]] call kat_circulation_fnc_sampleTestedLocal;
 *
 * Public: No
 */

params ["_medic", "_result", "_resultId", "_sampleId", "_vehicle", "_entry"];

if (_result == "invalid") exitWith {
    [LLSTRING(ArterialTest_Invalid), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

if (_result == "full") exitWith {
    [LLSTRING(ArterialTest_NoSlots), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

_entry params ["_patientName", "_bloodGasArray"];
_bloodGasArray params ["_paCO2", "_paO2", "_spO2", "_hCO3", "_pH", "_etCO2"];

private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO3: %5, pH: %6", _patientName, _paCO2 toFixed 2, _paO2 toFixed 2, _spO2 toFixed 2, _hCO3 toFixed 2, _pH toFixed 2];
[_output, 3, _medic] call ACEFUNC(common,displayTextStructured);

[_vehicle, (format ["KAT_bloodSample_%1", _sampleId])] call CBA_fnc_removeItemCargo;
[_medic, (format ["KAT_bloodResult_%1", _resultId]), true] call CBA_fnc_addItem;
