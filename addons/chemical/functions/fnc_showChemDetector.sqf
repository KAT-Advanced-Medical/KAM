#include "..\script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet
 * Modified: Mazinski
 * Displays the KWatch on screen.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_watch_fnc_showKWatch
 *
 * Public: Yes
 */

params ["_unit"];

"KAT_ChemicalDetector" cutRsc ["KAT_ChemicalDetector", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_ChemicalDetector", displayNull])) exitWith {};

GVAR(ChemDetectorActive) = true;

private _display = uiNamespace getVariable ["KAT_ChemicalDetector", displayNull];
private _background = _display displayCtrl 18801;
private _time = _display displayCtrl 18804;
private _exposure = _display displayCtrl 18805;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_time", "_exposure"];

    if !(GVAR(ChemDetectorActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        call FUNC(hideChemDetector);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_ChemicalDetector" in assignedItems _unit) exitWith {
        call FUNC(hideChemDetector);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _hour = floor dayTime;
    private _minute = floor ((dayTime - _hour) * 60);

    _time ctrlSetText (format ["%1:%2", [_hour, 2] call CBA_fnc_formatNumber, [_minute, 2] call CBA_fnc_formatNumber]); 

    private _gas = nearestObjects [_unit, ["kat_module_zeus_gas"], 2000];

    if ((count _gas) > 0) then {
        private _distance = _unit distance (_gas select 0);
        private _radius = (_gas select 0) getVariable [QGVAR(gas_radius), 0];

        _exposure ctrlSetText ((linearConversion[0, _radius, _distance, 1, 0, true]) toFixed 2);
    } else {
        _exposure ctrlSetText str (0); 
    };

}, 1, [
    _unit,
    _time,
    _exposure
]] call CBA_fnc_addPerFrameHandler;
