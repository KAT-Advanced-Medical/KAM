#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles the progress of the AED treatment.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: AED-X origin <INT>
 *    0: Medic
 *    1: Placed
 *    2: Vehicle
 *
 * Return Value:
 * Continue AED <BOOL>
 *
 * Example:
 * [[_medic,_patient,_bodyPart,_classname,_itemUser,_usedItem],_elapsedTime,_totalTime,_errorCode,_AEDOrigin] call kat_circulation_fnc_AEDProgress
 *
 * Public: No
 */

params ["_args", "_elapsedTime", "_totalTime", "_errorCode", ["_AEDOrigin",0]];
_args params ["_medic", "_patient"];

if !(_patient getVariable [QGVAR(AEDSoundPlaying), false]) then {
    _patient setVariable [QGVAR(AEDSoundPlaying), true, true];
    switch (_AEDOrigin) do {
        case 1: {
            private _nearObjects = nearestObjects [position _patient, ["kat_AEDItem"], GVAR(distanceLimit_AEDX)];

            if !(_nearObjects findIf {typeOf _x in ["kat_X_AEDItem","kat_AEDItem","Land_Defibrillator_F"]} isEqualTo -1) then {
                [_medic, _patient, (_nearObjects select (_nearObjects findIf {typeOf _x in ["kat_X_AEDItem","kat_AEDItem","Land_Defibrillator_F"]}))] call FUNC(AED_Sound);
            };
            
        };
        case 2: {
            [_medic, _patient, _patient] call FUNC(AED_Sound);
        };
        default {
            [_medic, _patient, _medic] call FUNC(AED_Sound);
        };
    };
};

// Cancel AED if patient wakes up

!(_patient call ACEFUNC(common,isAwake))
&& {(ACEGVAR(medical_treatment,advancedDiagnose) != 0) || {IN_CRDC_ARRST(_patient)}} // if basic diagnose, then only show action if appropriate (they can't tell difference between uncon/ca)
&& {_medic == (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull])}
