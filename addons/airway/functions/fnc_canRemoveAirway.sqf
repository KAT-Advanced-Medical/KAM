#include "script_component.hpp"
/*
 * Author: Katalam
 * Checks if airway management is possible.
 * Endotracheal requires unconscious patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * ReturnValue:
 * Can Airway <BOOL>
 *
 * Public: No
 */

params ["", "_target"];

_target getVariable [QGVAR(airway), [false, ""]] select 0
