#include "script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_breathing_fnc_init
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QEGVAR(medical,airwayStatus), 100, true];
_unit setVariable [QEGVAR(medical,airwayOccluded), false, true];
_unit setVariable [QEGVAR(medical,airwayCollapsed), false, true];

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable [QGVAR(o2), false, true];
// KAT_medical_airwayStatus - oxygen saturation
diag_log "Breathing Init done!"
