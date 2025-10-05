#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_hitpoints_ABDPad
 *
 * Public: No
 */
params ["_patient", "_bodyPart"];

private _eviscerationLevel = _patient getVariable [QGVAR(evisceration), 0];
private _newEviscerationLevel = (_eviscerationLevel - 2) max 0;
_patient setVariable [QGVAR(evisceration), _newEviscerationLevel, true];
_patient setVariable [QGVAR(activeWoundPack), 1, true];
if (_newEviscerationLevel == 0) then {
    [_patient] call EFUNC(misc,updateDamageEffects);
};


[{
    params ["_patient","_bodyPart"];
private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _bandagedWoundsOnPart = _bandagedWounds get _bodyPart;
TRACE_1("WrapAllWounds1",_bandagedWoundsOnPart);

private _includedTypes = ["Compressed_Gauze", "Abdominal_Pad", "fourByfour_Gauze"];

private _wrappedAny = false;

{
    private _bandageType = _x param [4, ""];
    if (_bandageType in _includedTypes) then {
        private _classID = (_x select 0) + 0.1;
        private _amount = _x select 1;
        private _bleeding = _x select 2;
        private _damage = _x select 3;
        private _oldBandage = _bandageType;

        private _newClassID = _classID + 0.01;
        private _newEntry = [
            _newClassID,
            _amount,
            _bleeding,
            _damage,
            _oldBandage + "_wrapped"
        ];

        TRACE_2("Wound Before/After Wrap",_x,_newEntry);

        _bandagedWoundsOnPart set [_forEachIndex, _newEntry];
        _bandagedWounds set [_bodyPart, _bandagedWoundsOnPart];

        private _impact = 1;
        private _woundIndex = _forEachIndex;
        private _wound = _newEntry;
        private _bandage = _oldBandage + "_wrapped";
        private _patient = GVAR(ABDpatient);
        private _bodyPart = GVAR(ABDbodyPart);

        TRACE_6("WrapWound",patient,_impact,bodyPart,_woundIndex,_wound,_bandage);
        [patient, _impact, bodyPart, _woundIndex, _wound, _bandage, false] call ACEFUNC(medical_treatment,handleBandageOpening);

        _wrappedAny = true;
    };
} forEach _bandagedWoundsOnPart;

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];

_wrappedAny

}, [_patient,_bodyPart], 0.5] call CBA_fnc_waitAndExecute;