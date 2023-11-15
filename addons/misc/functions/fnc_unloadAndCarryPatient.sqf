#include "..\script_component.hpp"
/*
 * Author: Blue
 * Unload patient from vehicle and carry (skip animation)
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_misc_fnc_unloadAndCarryPatient;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_medic, _patient] call ACEFUNC(medical_treatment,unloadUnit);

// From ace_dragging_fnc_startCarry

// exempt from weight check if object has override variable set
if (!GETVAR(_patient,ACEGVAR(dragging,ignoreWeightCarry),false) && {
    private _weight = [_patient] call ACEFUNC(dragging,getWeight);
    _weight > GETMVAR(ACE_maxWeightCarry,1E11)
}) exitWith {
    // exit if object weight is over global var value
    [ACELLSTRING(dragging,UnableToDrag)] call ACEFUNC(common,displayTextStructured);
};

private _timer = CBA_missionTime;

// add a primary weapon if the unit has none.
if (primaryWeapon _medic isEqualto "") then {
    _medic addWeapon "ACE_FakePrimaryWeapon";
};

// select primary, otherwise the drag animation actions don't work.
_medic selectWeapon primaryWeapon _medic;

// move a bit closer and adjust direction when trying to pick up a person
_patient setDir (getDir _medic + 180);
_patient setPosASL (getPosASL _medic vectorAdd (vectorDir _medic));
[_medic, "blockThrow", "ACE_dragging", true] call ACEFUNC(common,statusEffect_set);

// prevent multiple players from accessing the same object
[_medic, _patient, true] call ACEFUNC(common,claim);

// prevents draging and carrying at the same time
_medic setVariable [QACEGVAR(dragging,isCarrying), true, true];

// required for aborting animation
_medic setVariable [QACEGVAR(dragging,carriedObject), _patient, true];
[ACEFUNC(dragging,startCarryPFH), 0.2, [_medic, _patient, _timer]] call CBA_fnc_addPerFrameHandler;

// disable collisions by setting the physx mass to almost zero
private _mass = getMass _patient;
if (_mass > 1) then {
    _patient setVariable [QACEGVAR(dragging,originalMass), _mass, true];
    [QACEGVAR(common,setMass), [_patient, 1e-12]] call CBA_fnc_globalEvent; // force global sync
};
