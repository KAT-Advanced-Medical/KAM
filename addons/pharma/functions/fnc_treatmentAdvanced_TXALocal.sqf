#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Begins TXA bandaging process
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_timeTillMaxEffect", "_timeInSystem"];
private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
private _medsToCheck = ["TXA"];
private _txaEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("txa" in _medName) then {
        _txaEffectiveness = _txaEffectiveness max _effectiveness;
    };
} forEach _medStack;
private _allowStack = missionNamespace getVariable [QGVAR(allowStackScript_TXA), true];
private _keepRunning = missionNamespace getVariable [QGVAR(keepScriptRunning_TXA), false];
private _cycleTime = missionNamespace getVariable [QGVAR(bandageCycleTime_TXA), 5];

if (_IVactual > 1) then {
    private _randomNumber = random 100;

    if (_IVactual != 14) exitWith {
        if (_randomNumber < GVAR(blockChance)) then {
            [{
                params ["_patient", "_IVarray", "_partIndex", "_IVactual"];

                if (_IVactual > 1 && ([10,11,12] find _IVactual == -1)) exitWith {};
                _IVarray set [_partIndex, _IVactual + 5];
                _patient setVariable [QGVAR(IV), _IVarray, true];
            },
            [_patient, _IVarray, _partIndex, _IVactual], (random 300)] call CBA_fnc_waitAndExecute;
        };
    };

    _IVarray set [_partIndex, _IVactual];
    _patient setVariable [QGVAR(IV), _IVarray, true];
};

private _fnc_txaClot = {
    params ["_patient", "_bodyPart", "_id", "_amount", "_bleeding", "_damage", "_delay", "_oldBandage", "_newBandage", "_factorCountToRemove"];
    [{
    params ["_patient", "_bodyPart", "_id", "_amount", "_bleeding", "_damage", "_oldBandage", "_newBandage", "_factorCountToRemove"];
    if !(alive _patient) exitWith {};
    private _eacaAmount = [_patient, "EACA", true] call ACEFUNC(medical_status,getMedicationCount) select 1;
    if (_eacaAmount > 0.1) exitWith {};
    private _coagWoundsLive = GET_COAGED_WOUNDS(_patient);
    private _currentWounds  = _coagWoundsLive getOrDefault [_bodyPart, []];
    private _minorIndex = -1;
    private _minorWound = -1;
    {
        _x params ["_idW", "_amount", "_bleeding", "_damage", "_bandage", "_time"];
        if ((_bandage isEqualTo _oldBandage) && (_idW isEqualTo _id)) exitWith {
            _minorIndex = _forEachIndex;
            _minorWound = _x;
        };
    } forEach _currentWounds;

    if (_minorIndex == -1) exitWith {};
    _minorWound params ["_id", "_amount", "_bleeding", "_damage", "_bandage", "_time"];
    _currentWounds deleteAt _minorIndex;
    private _newWound = [_id, _amount, _bleeding, _damage, _newBandage, CBA_missionTime];
    _currentWounds pushBack _newWound;
    _coagWoundsLive set [_bodyPart, _currentWounds];
    _patient setVariable [VAR_COAGED_WOUNDS, _coagWoundsLive, true];
    private _bodyFluid = GET_BODY_FLUID(_patient);
    private _coagulationFactor = GET_BODY_FLUID_PLATELETS(_patient);
    if (_coagulationFactor <= 0) exitWith {};
    _bodyFluid set [5, (_coagulationFactor - _factorCountToRemove)];
    _patient setVariable [VAR_BODY_FLUID, _bodyFluid, true];
    private _impact = _amount;
    private _woundIndex = count _currentWounds - 1;
    private _finalWound = _currentWounds select _woundIndex;
    [_patient, _impact, _bodyPart, _woundIndex, _finalWound, _newBandage, false] call EFUNC(misc,handleCoagReopening);
    }, [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _oldBandage, _newBandage,_factorCountToRemove], _delay] call CBA_fnc_waitAndExecute;
};


if (GVAR(coagulation)) then {
    if (([7,8,9] find _IVactual) == -1) then {
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_timeInSystem", "_fnc_txaClot"];

            if !(alive _patient) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            private _eacaAmount = [_patient, "EACA", true] call ACEFUNC(medical_status,getMedicationCount) select 1;
            if (_eacaAmount > 0.1) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };


            private _random = random [6.4, 6.8, 7.2];
            private _ph     = GET_PH(_patient);

            if (_random <= _ph) then {
                private _coagWounds       = GET_COAGED_WOUNDS(_patient);
                private _pulse            = _patient getVariable [VAR_HEART_RATE, 80];
                private _coagulationFactor = GET_BODY_FLUID_PLATELETS(_patient);
                if (_coagWounds isEqualTo createHashMap) exitWith {};
                if (GET_BLOOD_VOLUME_LITERS(_patient) < GVAR(coagulation_requireBV)) exitWith {};
                if ((_pulse < 20) && {GVAR(coagulation_requireHR)}) exitWith {};
                if (_coagulationFactor <= 0) exitWith {};
                {
                    private _bodyPart = _x;
                    private _wounds = _coagWounds getOrDefault [_bodyPart, []];
                    {
                        _x params ["_id", "_amount", "_bleeding", "_damage", "_bandage", "_time"];
                        switch (true) do {
                            case (_bandage isEqualTo "BloodClotMinor"): {
                                private _delay = random [10, 15, 20];
                                private _newBandage = "BloodClotMinorTXA";
                                private _factorCountToRemove = random [6, 11, 15];
                                [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage, _factorCountToRemove] call _fnc_txaClot;
                            };
                            case (_bandage isEqualTo "BloodClotMedium"): {
                                private _delay = random [15, 23, 45];
                                private _newBandage = "BloodClotMediumTXA";
                                private _factorCountToRemove = random [12, 18, 25];
                                [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage, _factorCountToRemove] call _fnc_txaClot;
                            };
                            case (_bandage isEqualTo "BloodClotLarge"): {
                                private _delay = random [20, 40, 60];
                                private _newBandage = "BloodClotLargeTXA";
                                private _factorCountToRemove = random [16, 23, 30];
                                [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage, _factorCountToRemove] call _fnc_txaClot;
                            };
                            default {};
                        };
                    } forEach _wounds;

                } forEach (keys _coagWounds);
            };
            [{
                params ["_patient", "_idPFH"];
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            }, [_patient, _idPFH], _timeInSystem] call CBA_fnc_waitAndExecute;

        }, 10, [_patient, _timeInSystem, _fnc_txaClot]] call CBA_fnc_addPerFrameHandler;
    };
};
if (!(GVAR(coagulation)) || GVAR(coagulation_allow_TXA_script)) then {

    if ([7,8,9] find _IVactual == -1) then {

        if ((_txaEffectiveness > 0.3) && !(_allowStack)) exitWith {};

        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_keepRunning", "_timeInSystem"];

            private _alive = alive _patient;
            private _exit = true;
            private _random = random [6.4, 6.8, 7.2];
            private _ph = GET_PH(_patient);

            if !(_alive) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            if (_random <= _ph) then {
                {
                    _x params ["_targetBodyPart"];
                    
                    private _openWounds = GET_OPEN_WOUNDS(_patient);
                    private _openWoundsOnPart = _openWounds getOrDefault [_targetBodyPart, []];

                    private _bodyPartN = ALL_BODY_PARTS find _x;
                    if (_openWoundsOnPart isEqualTo [] || [_patient,_bodyPartN] call EFUNC(pharma,occlusionCheck)) then {
                        continue;
                    };

                    private _woundIndex = _openWoundsOnPart findIf {(_x select 1) > 0 && (_x select 2) > 0};
                    
                    if (_woundIndex != -1) exitWith {
                        [QACEGVAR(medical_treatment,bandageLocal), [_patient, _targetBodyPart, "PackingBandage"], _patient] call CBA_fnc_targetEvent;
                        _exit = false;
                    };
                } forEach ALL_BODY_PARTS_PRIORITY;
            };

            [{
                params["_patient", "_idPFH"];
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            },
            [_patient, _idPFH], _timeInSystem] call CBA_fnc_waitAndExecute;

            if (_exit && !(_keepRunning)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

        }, _cycleTime, [_patient, _keepRunning, _timeInSystem]] call CBA_fnc_addPerFrameHandler;
    };
};