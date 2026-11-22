#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Returns the steps of the guided training. Each step gives the patient its injuries when it starts
 * and is finished once its condition, called with [patient, player], returns true.
 *
 * The title and text of a step come from the stringtable keys Tutorial_<key>_Title and Tutorial_<key>_Text.
 * Injuries use the types of kat_training_fnc_addInjury.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Steps, each [key <STRING>, injuries <ARRAY>, condition <CODE>, show the heart rhythm chart <BOOL> (optional)] <ARRAY>
 *
 * Example:
 * call kat_training_fnc_getTutorialSteps
 *
 * Public: No
 */

#define APPROACH_DISTANCE 3
#define RHYTHM_ASYSTOLE 1
#define RHYTHM_VF 3

[
    [
        "Approach",
        [["unconscious", [true]]],
        {
            params ["_patient", "_player"];

            (_player distance _patient) < APPROACH_DISTANCE
        }
    ],
    [
        "Bleeding",
        [["wound", ["leftleg", "bullet", 0.9]], ["wound", ["rightarm", "stab", 0.5]]],
        {
            params ["_patient"];

            // Tourniquets stop the bleeding of their limb, so this is done before the wounds are closed
            GET_WOUND_BLEEDING(_patient) <= 0
        }
    ],
    [
        "AirwayClear",
        [["airway", ["obstruction"]], ["airway", ["occlusion"]]],
        {
            params ["_patient"];

            !(_patient getVariable [QEGVAR(airway,occluded), false])
        }
    ],
    [
        "AirwaySecure",
        [],
        {
            params ["_patient"];

            (_patient getVariable [QEGVAR(airway,airway_item), ""]) == "Larynxtubus"
        }
    ],
    [
        // Both sound the same until the chest is sealed, which is what the next steps teach
        "BreathingListen",
        [["chest", [selectRandom ["tension", "hemo"]]]],
        {
            params ["", "_player"];

            _player getVariable [QEGVAR(breathing,usingStethoscope), false]
        }
    ],
    [
        "BreathingSeal",
        [],
        {
            params ["_patient"];

            _patient getVariable [QEGVAR(breathing,activeChestSeal), false]
        }
    ],
    [
        "BreathingTreat",
        [],
        {
            params ["_patient"];

            !(_patient getVariable [QEGVAR(breathing,tensionpneumothorax), false]) && {!(_patient getVariable [QEGVAR(breathing,hemopneumothorax), false])}
        }
    ],
    [
        "Circulation",
        [],
        {
            params ["_patient"];

            private _openBleeding = false;

            {
                if ((_y findIf {_x params ["", "_amount", "_bleeding"]; (_amount * _bleeding) > 0}) != -1) exitWith {
                    _openBleeding = true;
                };
            } forEach GET_OPEN_WOUNDS(_patient);

            !_openBleeding && {(GET_TOURNIQUETS(_patient) findIf {_x != 0}) == -1}
        }
    ],
    [
        "CardiacAssess",
        [["cardiacArrest", [RHYTHM_VF]]],
        {
            params ["_patient"];

            _patient getVariable [QEGVAR(circulation,DefibrillatorPads_Connected), false]
        },
        true
    ],
    [
        "CardiacShock",
        [],
        {
            params ["_patient"];

            !(IN_CRDC_ARRST(_patient))
        },
        true
    ],
    [
        "CardiacCPR",
        [["cardiacArrest", [RHYTHM_ASYSTOLE]]],
        {
            params ["_patient"];

            !(IN_CRDC_ARRST(_patient))
        },
        true
    ]
]
