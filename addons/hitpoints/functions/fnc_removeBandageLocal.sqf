#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for fully healing a fracture.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_closedReductionLocal
 *
 * Public: No
 */
params ["_patient", "_bodypart", "_type"];

private _bandagedWounds = _patient getVariable [VAR_BANDAGED_WOUNDS, createHashMap];
private _openWounds = _patient getVariable [VAR_OPEN_WOUNDS, createHashMap];

private _wounds = _bandagedWounds getOrDefault [_bodypart, []];
private _openWoundsOnPart = _openWounds getOrDefault [_bodypart, []];

{
    _x params ["_classID", "_amountOf", "_bleeding", "_damage", "_bandage"];
    if (_bandage isEqualTo _type) exitWith {
        private _injuryIndex = -1;
        {
            _x params ["_selClassID"];
            if (_selClassID == _classID) exitWith { _injuryIndex = _forEachIndex };
        } forEach _openWoundsOnPart;

        if (_injuryIndex == -1) exitWith {
            TRACE_1("Matching open wound not found for classID",_classID);
        };

        private _selectedInjury = _openWoundsOnPart select _injuryIndex;
        _selectedInjury params ["_selClassID", "_selAmount", "_selBleeding", "_selDamage"];
        
        private _wounds = _bandagedWounds getOrDefault [_bodypart, []];
        private _indexToRemove = -1;
        private _removedAmount = 0; // store how much we remove
        
        {
            _x params ["_id", "_amountOf", "", "", "_oldBandage"];
            if (_id == _classID && {_oldBandage == _bandage}) exitWith {
                private _reduction = [2, 4] select (_bandage == "ETD");
                private _newAmount = 0 max (_amountOf - _reduction);
        
                // store actual removed amount
                _removedAmount = _amountOf - _newAmount;
        
                if (_newAmount == 0) then {
                    _indexToRemove = _forEachIndex;
                } else {
                    _x set [1, _newAmount];
                };
            };
        } forEach _wounds;
        
        if (_indexToRemove != -1) then {
            _wounds deleteAt _indexToRemove;
            if (_wounds isEqualTo []) then {
                _bandagedWounds deleteAt _bodypart;
            } else {
                _bandagedWounds set [_bodypart, _wounds];
            };
        };
        _selectedInjury set [1, _selAmount + _removedAmount];
        
        _patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
        _patient setVariable [VAR_OPEN_WOUNDS, _openWounds, true];

        [_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);

        private _partIndex = ALL_BODY_PARTS find _bodypart;

        if (ACEGVAR(medical_treatment,clearTrauma) == 2) then {
            [_patient, _bodypart, _selDamage] call ACEFUNC(medical_treatment,addTrauma);
        };

        if ((ACEGVAR(medical,limping) == 1) && {_partIndex > 7}) then {
            [_patient] call EFUNC(misc,updateDamageEffects);
        };

        TRACE_2("Forced reopening complete",_classID,_type);
    };
} forEach _wounds;