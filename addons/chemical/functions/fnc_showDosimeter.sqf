#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Displays the dosimeter HUD and runs a per-frame handler that refreshes the
 * accumulated whole-body dose (Gy) and, while the dosimeter is enabled, the
 * current dose-rate (Gy/h). The rate reads "--" when the dosimeter is off and
 * 0 once the unit leaves a field.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_chemical_fnc_showDosimeter
 *
 * Public: Yes
 */

params ["_unit"];

"KAT_Dosimeter" cutRsc ["KAT_Dosimeter", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_Dosimeter", displayNull])) exitWith {};

GVAR(DosimeterActive) = true;

private _display = uiNamespace getVariable ["KAT_Dosimeter", displayNull];
private _rate = _display displayCtrl 18814;
private _dose = _display displayCtrl 18815;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_rate", "_dose"];

    if !(GVAR(DosimeterActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        call FUNC(hideDosimeter);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_Dosimeter" in assignedItems _unit) exitWith {
        call FUNC(hideDosimeter);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _doseTotal = _unit getVariable [QGVAR(radDoseWB), 0];
    _dose ctrlSetText (format ["%1 Gy", _doseTotal toFixed 3]);

    if (_unit getVariable [QGVAR(dosimeterEnabled), false]) then {
        _rate ctrlSetText (format ["%1 Gy/h", (_unit getVariable [QGVAR(radDoseRate), 0]) toFixed 3]);
    } else {
        _rate ctrlSetText "--";
    };
}, 1, [
    _unit,
    _rate,
    _dose
]] call CBA_fnc_addPerFrameHandler;
