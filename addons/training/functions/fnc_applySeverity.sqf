#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Wounds a patient randomly according to a severity level. Has to run where the patient is local.
 *
 * 1 (light): a few minor limb wounds
 * 2 (moderate): several limb and torso wounds
 * 3 (severe): heavy wounds anywhere, a fracture and a pneumothorax
 * 4 (critical): massive wounds, two fractures, tension or hemopneumothorax, unconscious
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Severity, 1 to 4 <NUMBER> (default: 1)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, 3] call kat_training_fnc_applySeverity
 *
 * Public: No
 */

#define LIMBS ["leftarm", "rightarm", "leftleg", "rightleg"]
#define DAMAGE_TYPES ["bullet", "grenade", "stab", "falling"]
// Keeps single head wounds below the lethal headshot threshold of ACE
#define HEAD_DAMAGE_MAX 0.5
#define SEVERITY_SEVERE 3
#define SEVERITY_CRITICAL 4

params [["_patient", objNull, [objNull]], ["_severity", 1, [0]]];

_severity = (round _severity max 1) min SEVERITY_CRITICAL;

// Minimum wounds, maximum wounds, minimum damage, maximum damage, body parts
([
    [1, 2, 0.15, 0.35, LIMBS],
    [3, 4, 0.3, 0.6, LIMBS + ["body"]],
    [4, 6, 0.5, 0.8, ALL_BODY_PARTS],
    [6, 8, 0.6, 0.95, ALL_BODY_PARTS]
] select (_severity - 1)) params ["_minWounds", "_maxWounds", "_minDamage", "_maxDamage", "_bodyParts"];

for "_i" from 1 to (_minWounds + floor random (_maxWounds - _minWounds + 1)) do {
    if (!alive _patient) then {break};

    private _bodyPart = selectRandom _bodyParts;
    private _damage = _minDamage + random (_maxDamage - _minDamage);

    if (_bodyPart == "head") then {
        _damage = _damage min HEAD_DAMAGE_MAX;
    };

    [_patient, _damage, _bodyPart, selectRandom DAMAGE_TYPES] call ACEFUNC(medical,addDamageToUnit);
};

if (!alive _patient || {_severity < SEVERITY_SEVERE}) exitWith {};

[_patient, selectRandom LIMBS, 1 + floor random 3] call FUNC(addFracture);

if (_severity < SEVERITY_CRITICAL) exitWith {
    [_patient, "pneumothorax"] call FUNC(addChestInjury);
};

[_patient, selectRandom LIMBS, 1 + floor random 3] call FUNC(addFracture);
[_patient, selectRandom ["tension", "hemo"]] call FUNC(addChestInjury);

if !(IS_UNCONSCIOUS(_patient)) then {
    [_patient, true] call ACEFUNC(medical,setUnconscious);
};
