#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for collapsing
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "Head", "Larynxtubus", objNull, "kat_larynx"] call kat_airway_fnc_treatmentAdvanced_airway;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[QGVAR(airwayLocal), [_medic, _patient, _classname, _usedItem], _patient] call CBA_fnc_targetEvent;
