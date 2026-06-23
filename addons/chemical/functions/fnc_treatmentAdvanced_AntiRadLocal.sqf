#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Applies an anti-radiation drug to a patient. Both effects are timestamp
 * windows read elsewhere, so they are locality-safe to set from any machine:
 *   "ki"       - potassium iodide: opens a prophylactic uptake-reduction window
 *                (read in fnc_irradiate via rad_kiFactor).
 *   "prussian" - Prussian blue: opens a chelation window that accelerates
 *                internal-burden elimination (read in fnc_radInternalTickPFH).
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Mode <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_patient", "_mode"];

switch (_mode) do {
    case "ki": {
        _patient setVariable [QGVAR(radProtectiveWindow), CBA_missionTime + GVAR(rad_kiDuration), true];
    };
    case "prussian": {
        _patient setVariable [QGVAR(radChelationWindow), CBA_missionTime + GVAR(rad_chelationDuration), true];
    };
};
