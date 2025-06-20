#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Attaches BVM to a Patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_breathing_fnc_attachBVM
 *
 * Public: No
 */

params ["_medic", "_patient"];
if (!(_patient call ACEFUNC(common,isAwake)) && (IN_MED_VEHICLE(_patient)) && !(_patient getVariable [QGVAR(oxygenMaskActive), false]) && !(_patient getVariable [QGVAR(attachedVent), false]) && (_patient getVariable [QEGVAR(airway,airway_item), ""] in ["Larynxtubus", "IGEL", "Surgical_Airway", "ETT"])) exitWith {true};
false

