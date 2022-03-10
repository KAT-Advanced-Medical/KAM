#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for collapsing local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus"] call kat_airway_fnc_treatmentAdvanced_airwayLocal;
 *
 * Public: No
 */

params ["_caller", "_target", "_className"];

if (_target getVariable ["KAT_medical_airwayOccluded", false]) exitWith {
    private _output = localize LSTRING(Airway_NotClearForItem);
    [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
	if (_className isEqualTo "Guedeltubus") then {
		[_caller, "kat_guedel"] call ace_common_fnc_addToInventory;
	} else {
	[_caller, "kat_larynx"] call ace_common_fnc_addToInventory;	
	};
    false;
};

if (_target getVariable [QGVAR(airway_item), ""] isEqualTo "larynx") exitWith {
    private _output = localize LSTRING(Airway_already);
    [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
    false;
};

if (_target getVariable [QGVAR(airway_item), ""] isEqualTo "guedel" && (_className isEqualTo "Guedeltubus")) exitWith {
    private _output = localize LSTRING(Airway_already);
    [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
    false;
};

_target setVariable [QGVAR(airway), true, true];
_target setVariable [QGVAR(obstruction), false, true];

private _item = LSTRING(Larynx_Display);
_target setVariable [QGVAR(airway_item), "larynx", true];

if (_className isEqualTo "Guedeltubus") then {
    _item = LSTRING(Guedel_Display);
    _target setVariable [QGVAR(airway_item), "guedel", true];
};

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(airway_log), [[_caller] call ace_common_fnc_getName, _item]] call ace_medical_treatment_fnc_addToLog;
[_target, "activity_view", LSTRING(airway_log), [[_caller] call ace_common_fnc_getName, _item]] call ace_medical_treatment_fnc_addToLog;

true;
