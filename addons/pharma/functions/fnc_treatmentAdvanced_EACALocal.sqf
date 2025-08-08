#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Local function for EACA treatment
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_patient, "LeftArm"] call kat_pharma_fnc_treatmentAdvanced_EACALocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_timeTillMaxEffect", "_timeInSystem"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _eacaEffectiveness = [_patient, "EACA", true] call ACEFUNC(medical_status,getMedicationCount) select 1;
private _allowStack = missionNamespace getVariable [QGVAR(allowStackScript_EACA), true];
private _keepRunning = missionNamespace getVariable [QGVAR(keepScriptRunning_EACA), false];
private _cycleTime = missionNamespace getVariable [QGVAR(bandageCycleTime_EACA), 5];

if (_IVactual > 1) then {
    private _randomNumber = random 100;

    if (_IVactual in [2, 3, 4]) exitWith {
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


private _fnc_eacaClot = {
    params ["_patient", "_bodyPart", "_id", "_amount", "_bleeding", "_damage", "_delay", "_oldBandage"];
    [{
    params ["_patient", "_bodyPart", "_id", "_amount", "_bleeding", "_damage", "_oldBandage", "_newBandage"];
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
    systemChat str _minorIndex;
    _currentWounds deleteAt _minorIndex;
    private _newWound = [_id, _amount, _bleeding, _damage, _newBandage, CBA_missionTime];
    _currentWounds pushBack _newWound;
    _coagWoundsLive set [_bodyPart, _currentWounds];
    _patient setVariable [VAR_COAGED_WOUNDS, _coagWoundsLive, true];
    
    private _impact = _amount;
    private _woundIndex = count _currentWounds - 1;
    private _finalWound = _currentWounds select _woundIndex;
    [_patient, _impact, _bodyPart, _woundIndex, _finalWound, _newBandage, false] call EFUNC(misc,handleCoagReopening);
    }, [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _oldBandage, _newBandage], _delay] call CBA_fnc_waitAndExecute;
};


if (GVAR(coagulation)) then {
    if (([7,8,9] find _IVactual) == -1) then {
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_timeInSystem", "_fnc_eacaClot"];

            if !(alive _patient) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            private _random = random [6.4, 6.8, 7.2];
            private _ph     = GET_PH(_patient);

            if (_random <= _ph) then {
                private _coagWounds       = GET_COAGED_WOUNDS(_patient);
                private _pulse            = _patient getVariable [VAR_HEART_RATE, 80];

                if (_coagWounds isEqualTo createHashMap) exitWith {};
                if (GET_BLOOD_VOLUME_LITERS(_patient) < GVAR(coagulation_requireBV)) exitWith {};
                if ((_pulse < 20) && {GVAR(coagulation_requireHR)}) exitWith {};

                {
                    private _bodyPart = _x;

                    // Skip if tourniquet applied and blocking is enabled
                    private _bodyPartN = ALL_BODY_PARTS find _x;
                    if ([_patient,_bodyPartN] call EFUNC(pharma,occlusionCheck)
                        && { missionNamespace getVariable [QGVAR(coagulation_tourniquetBlock), true] }) then {
                        continue;
                    };

                    private _wounds = _coagWounds getOrDefault [_bodyPart, []];

                    {
                        _x params ["_id", "_amount", "_bleeding", "_damage", "_bandage", "_time"];
                        switch (true) do {
                            case (_bandage isEqualTo "BloodClotMinor"): {
                                private _delay = random [30, 45, 60];
                                private _newBandage = "BloodClotMinorEACA";
                                    [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage] call _fnc_eacaClot;
                            };
                            case (_bandage isEqualTo "BloodClotMedium"): {
                                private _delay = random [60, 90, 120];
                                private _newBandage = "BloodClotMediumEACA";
                                    [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage] call _fnc_eacaClot;
                            };
                            case (_bandage isEqualTo "BloodClotLarge"): {
                                private _delay = random [90, 120, 160];
                                private _newBandage = "BloodClotLargeEACA";
                                    [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage] call _fnc_eacaClot;
                            };
                            case (_bandage isEqualTo "BloodClotMinorTXA"): {
                                private _delay = random [20, 35, 60];
                                private _newBandage = "BloodClotMinorEACA";
                                    [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage] call _fnc_eacaClot;
                            };
                            case (_bandage isEqualTo "BloodClotMediumTXA"): {
                                private _delay = random [45, 60, 90];
                                private _newBandage = "BloodClotMediumEACA";
                                    [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage] call _fnc_eacaClot;
                            };
                            case (_bandage isEqualTo "BloodClotLargeTXA"): {
                                private _delay = random [60, 90, 120];
                                private _newBandage = "BloodClotLargeEACA";
                                    [_patient, _bodyPart, _id, _amount, _bleeding, _damage, _delay, _bandage, _newBandage] call _fnc_eacaClot;
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

        }, 10, [_patient, _timeInSystem, _fnc_eacaClot]] call CBA_fnc_addPerFrameHandler;
    };
};


if (!(GVAR(coagulation)) || GVAR(coagulation_allow_EACA_script)) then {
    if ([7,8,9] find _IVactual == -1) then {
        if (_eacaEffectiveness < 0.3) && (!_allowStack) exitWith {};

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

                    private _coagWounds = GET_BANDAGED_WOUNDS(_patient);
                    private _bandagedWoundsOnPart = _coagWounds getOrDefault [_targetBodyPart, []];
                    private _bodyPartN = ALL_BODY_PARTS find _x;
                    if (_bandagedWoundsOnPart isEqualTo [] || [_patient,_bodyPartN] call EFUNC(pharma,occlusionCheck)) then {
                        continue;
                    };

                    private _index = _bandagedWoundsOnPart findIf {!((_x select 0) in [20,21,22])};

                    if (_index != -1) exitWith {
                        (_bandagedWoundsOnPart select _index) params ["_classID", "_amountOf", "", "_damageOf"];

                        private _treatedWound = [_classID, _amountOf, 0, _damageOf];

                        private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
                        private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_targetBodyPart, []];

                        private _woundIndex = _stitchedWoundsOnPart findIf {(_x select 0) isEqualTo _classID};

                        if (_woundIndex == -1) then {
                            _stitchedWoundsOnPart pushBack _treatedWound;
                        } else {
                            private _wound = _stitchedWoundsOnPart select _woundIndex;
                            _stitchedWoundsOnPart set [_woundIndex, [(_wound select 1) + _amountOf, _wound select 2, _wound select 3]];
                        };
                        _stitchedWounds set [_targetBodyPart, _stitchedWoundsOnPart];
                        _patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

                        _bandagedWoundsOnPart deleteAt _index;
                        _coagWounds set [_targetBodyPart, _bandagedWoundsOnPart];

                        _patient setVariable [VAR_BANDAGED_WOUNDS, _coagWounds, true];

                        private _partIndex = ALL_BODY_PARTS find _targetBodyPart;
                        private _bodyPartDamage = _patient getVariable [QACEGVAR(medical,bodyPartDamage), []];
                        private _damage = (_bodyPartDamage select _partIndex) - (_damageOf * _amountOf);
                        
                        if (_damage < 0.05) then {
                            _bodyPartDamage set [_partIndex, 0];
                        } else {
                            _bodyPartDamage set [_partIndex, _damage];
                        };
                        _patient setVariable [QACEGVAR(medical,bodyPartDamage), _bodyPartDamage, true];

                        _exit = false;
                    };
                } forEach ALL_BODY_PARTS_PRIORITY;
            };

            [{
                params ["_patient", "_idPFH"];
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            },
            [_patient, _idPFH], _timeInSystem] call CBA_fnc_waitAndExecute;

            if (_exit && !(_keepRunning)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

        }, _cycleTime,[_patient, _keepRunning, _timeInSystem]] call CBA_fnc_addPerFrameHandler;
    };
};
