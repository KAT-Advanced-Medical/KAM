#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka, Tomcat and Blue
 * Handles listening to lungs.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <Number>
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 1] call kat_breathing_fnc_listenLungs;
 *
 * Public: No
 */

params ["_patient"];

private _hasSurgical = _patient getVariable [QEGVAR(airway,airway_item), ""] isEqualTo "Surgical_Airway";
_hasSurgical
