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
 * Modes:
 *   "ki"         - potassium iodide: prophylactic uptake-reduction window.
 *   "prussian"   - Prussian blue: chelation window (faster internal clearance).
 *   "antibiotics"- opens an infection-suppression window and cuts current infection.
 *   "filgrastim" - opens a window that accelerates marrow/sickness recovery.
 *   "antiemetic" - opens a window that suppresses radiation vomiting.
 *   "stemcells"  - opens the marrow-rescue window that lets a lethal-tier
 *                  casualty's sickness decay under full intensive care.
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
        [_patient, LLSTRING(potassiumIodideItem)] call ACEFUNC(medical_treatment,addToTriageCard);
    };
    case "prussian": {
        _patient setVariable [QGVAR(radChelationWindow), CBA_missionTime + GVAR(rad_chelationDuration), true];
        [_patient, LLSTRING(prussianBlueItem)] call ACEFUNC(medical_treatment,addToTriageCard);
    };
    case "antibiotics": {
        _patient setVariable [QGVAR(radAntibioticWindow), CBA_missionTime + GVAR(rad_antibioticDuration), true];
        _patient setVariable [QGVAR(radInfectionLevel), (_patient getVariable [QGVAR(radInfectionLevel), 0]) * 0.5, true];
        [_patient, LLSTRING(antibioticsItem)] call ACEFUNC(medical_treatment,addToTriageCard);
    };
    case "filgrastim": {
        _patient setVariable [QGVAR(radFilgrastimWindow), CBA_missionTime + GVAR(rad_filgrastimDuration), true];
        [_patient, LLSTRING(filgrastimItem)] call ACEFUNC(medical_treatment,addToTriageCard);
    };
    case "antiemetic": {
        _patient setVariable [QGVAR(radAntiemeticWindow), CBA_missionTime + GVAR(rad_antiemeticDuration), true];
        [_patient, LLSTRING(antiemeticItem)] call ACEFUNC(medical_treatment,addToTriageCard);
    };
    case "stemcells": {
        _patient setVariable [QGVAR(radMarrowRescueWindow), CBA_missionTime + GVAR(rad_marrowRescueDuration), true];
        [_patient, LLSTRING(stemCellsItem)] call ACEFUNC(medical_treatment,addToTriageCard);
    };
};
