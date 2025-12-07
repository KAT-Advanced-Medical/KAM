#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to start the surgical process for a fracture
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_incisionLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (GVAR(Surgery_ConsciousnessRequirement) == 1 && !(IS_UNCONSCIOUS(_patient))) exitWith {
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};
private _openWounds = GET_OPEN_WOUNDS(_patient);
private _existingWounds = _openWounds getOrDefault [_bodyPart, [], true];
private _bodyPartDamage = GET_BODYPART_DAMAGE(_patient);
private _woundTypeToAdd = "Cut";
TRACE_4("create_Incision1",_openWounds,_existingWounds,_bodyPartDamage,_woundTypeToAdd);
private _woundClassIDToAdd = ACEGVAR(medical_damage,woundClassNames) find _woundTypeToAdd;
private _injuryBleedingRate = random [0.06, 0.1, 0.13];
private _bleedMultiplier = random [0.8, 1, 1.2];
private _woundSize = 2;
private _bleeding = _woundSize * _bleedMultiplier * _injuryBleedingRate;
private _classComplex = 10 * _woundClassIDToAdd + _woundSize;
// Create a new injury. Format [0:classComplex, 1:amountOf, 2:bleedingRate, 3:woundDamage]
private _injury = [_classComplex, 1, _bleeding, 1];
TRACE_1("adding new wound",_injury);
_existingWounds pushBack _injury;
_patient setVariable [VAR_OPEN_WOUNDS, _openWounds, true];
_patient setVariable [VAR_BODYPART_DAMAGE, _bodyPartDamage, true];
[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);
private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _liveFracture = _fractureArray select _part;

_liveFracture = _liveFracture + 0.1;
_fractureArray set [_part, _liveFracture];
_patient setVariable [QGVAR(fractures), _fractureArray, true];

[_patient, false] call ACEFUNC(dragging,setCarryable);
[_patient, false] call ACEFUNC(dragging,setDraggable);

[_patient, "quick_view", LSTRING(incision_log), [[_medic] call ACEFUNC(common,getName), STRING_BODY_PARTS select _part]] call ACEFUNC(medical_treatment,addToLog);

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_part"];

    private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0,0,0,0,0,0,0]];
    private _liveFracture = _fractureArray select _part;
    private _count = ([_patient, "Etomidate", true] call ACEFUNC(medical_status,getMedicationCount)) select 1;
    _activeLoadingDose = _patient getVariable [QEGVAR(pharma,activeEtomidateLoadingDose), false];

    private _alive = alive _patient;

    if ((!_alive) || (_liveFracture == 0)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable [QGVAR(etomidate_Pain), false]
    };

    if (((GVAR(Surgery_ConsciousnessRequirement) in [0,1]) && (!(IS_UNCONSCIOUS(_patient))) && (_count <= 0.2) && (_activeLoadingDose)) || (GVAR(Surgery_ConsciousnessRequirement) == 3 && _count <= 0.2  && (_activeLoadingDose))) exitWith {
        if !(_patient getVariable [QGVAR(etomidate_Pain), false]) then {
            [_patient, "Pain", 2, 10, 120, 0.8, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
            _patient setVariable [QGVAR(etomidate_Pain), true]};
        [_patient, true] call ACEFUNC(medical,setUnconscious);
    };

    if (GVAR(Surgery_ConsciousnessRequirement) == 2 && _count <= 0.2 && (_activeLoadingDose)) then {
        if !(_patient getVariable [QGVAR(etomidate_Pain), false]) then {
            [_patient, "Pain", 2, 10, 120, 0.8, 40] call ACEFUNC(medical_status,addMedicationAdjustment);
            _patient setVariable [QGVAR(etomidate_Pain), true]
        };
    };
}, 5, [_patient, _part]] call CBA_fnc_addPerFrameHandler;

