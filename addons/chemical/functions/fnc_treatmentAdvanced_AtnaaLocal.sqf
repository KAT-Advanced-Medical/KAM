#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Chemical-side ATNAA local handler. Clears nerve-agent exposure so the
 * server-side exposure watcher aborts the scheduled symptom chain (vomit,
 * unconsciousness, cardiac arrest).
 *
 * Note: VX skin contamination is NOT cleared here — players still need a
 * decontamination kit to stop being re-exposed by the contamination tick.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(nerveAgentExposure), "", true];

// Clear all scheduled nerve-agent deadlines so a future re-exposure (e.g. the
// VX contamination tick at +60s) gets a fresh symptom chain via
// scheduleNerveSymptomChain — without this it short-circuits because the
// original cardiac deadline is still > 0.
_patient setVariable [QGVAR(nerveDeadline_vomit), 0, true];
_patient setVariable [QGVAR(nerveDeadline_unconscious), 0, true];
_patient setVariable [QGVAR(nerveDeadline_cardiac), 0, true];
