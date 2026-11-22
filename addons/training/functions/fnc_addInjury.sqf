#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Applies an injury to a patient. Has to run where the patient is local.
 *
 * Injury types and their arguments:
 * - "severity": 0: Severity, 1 (light) to 4 (critical) <NUMBER>
 * - "wound": 0: Body part <STRING>, 1: ACE damage type <STRING>, 2: Damage <NUMBER>
 * - "fracture": 0: Body part <STRING>, 1: Grade, 1 (simple) to 3 (comminuted) <NUMBER>
 * - "chest": 0: "pneumothorax", "tension", "hemo" or "tamponade" <STRING>
 * - "cardiacArrest": 0: Rhythm, 1 asystole, 2 PEA, 3 VF, 4 VT <NUMBER>
 * - "airway": 0: "obstruction" or "occlusion" <STRING>
 * - "unconscious": 0: Never wake up on their own <BOOL> (default: false)
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Injury type <STRING>
 * 2: Injury arguments <ARRAY> (default: [])
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, "wound", ["leftleg", "bullet", 0.5]] call kat_training_fnc_addInjury
 *
 * Public: No
 */

#define DEFAULT_WOUND_DAMAGE 0.5
#define NO_WAKE_UP_TIME 1e9

params [["_patient", objNull, [objNull]], ["_type", "", [""]], ["_args", [], [[]]]];

if (!alive _patient || {!local _patient}) exitWith {};

switch (_type) do {
    case "severity": {
        _args params [["_severity", 1, [0]]];

        [_patient, _severity] call FUNC(applySeverity);
    };
    case "wound": {
        _args params [["_bodyPart", "body", [""]], ["_damageType", "bullet", [""]], ["_damage", DEFAULT_WOUND_DAMAGE, [0]]];

        [_patient, _damage, _bodyPart, _damageType] call ACEFUNC(medical,addDamageToUnit);
    };
    case "fracture": {
        _args params [["_bodyPart", "", [""]], ["_grade", 1, [0]]];

        [_patient, _bodyPart, _grade] call FUNC(addFracture);
    };
    case "chest": {
        _args params [["_injury", "", [""]]];

        [_patient, _injury] call FUNC(addChestInjury);
    };
    case "cardiacArrest": {
        _args params [["_rhythm", 1, [0]]];

        // A rhythm set before the arrest starts is kept by kat_circulation_fnc_handleCardiacArrest
        _patient setVariable [QEGVAR(circulation,cardiacArrestType), _rhythm, true];

        if !(IN_CRDC_ARRST(_patient)) then {
            [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
        };
    };
    case "airway": {
        _args params [["_injury", "", [""]]];

        // Airway injuries only matter on an unconscious patient and are cleared on a conscious one
        if !(IS_UNCONSCIOUS(_patient)) then {
            [_patient, true] call ACEFUNC(medical,setUnconscious);
        };

        if (_injury == "occlusion") then {
            _patient setVariable [QEGVAR(airway,occluded), true, true];
        } else {
            _patient setVariable [QEGVAR(airway,obstruction), true, true];
        };
    };
    case "unconscious": {
        _args params [["_stayUnconscious", false, [false]]];

        // ACE only rolls a spontaneous wake up once this time has passed
        if (_stayUnconscious) then {
            _patient setVariable [QACEGVAR(medical,lastWakeUpCheck), NO_WAKE_UP_TIME];
        };

        if !(IS_UNCONSCIOUS(_patient)) then {
            [_patient, true] call ACEFUNC(medical,setUnconscious);
        };
    };
};
