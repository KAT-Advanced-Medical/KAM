#include "script_component.hpp"
/*
 * Author: Glowbal
 * Edit: Tomcat
 * Overwrites the cprLocal of ACE to add the success chance for AED and AED-X
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Used Revive Object <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "AED"] call kat_circulation_fnc_cprLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_reviveObject"];

private _bloodLoss = _patient getVariable [QACEGVAR(medical,bloodVolume), 6.0];

private _chance = 0;
private _random = random 100;
private _randomAmi = random 4;
private _randomCPR = random 1;
private _epiBoost = 1;
private _amiBoost = 0;
private _lidoBoost = 0;
private _asystole = _patient getVariable [QGVAR(asystole), 1];
private _CPRcount = _patient getVariable [QGVAR(CPRcount), 0];

if !(GVAR(AdvRhythm)) then {
    _patient setVariable [QGVAR(asystole), 1, true];
    _asystole = _patient getVariable [QGVAR(asystole), 1];
    } else {
    if (_bloodLoss > 3.6) then {
        _patient setVariable [QGVAR(asystole), 1, true];
        _asystole = _patient getVariable [QGVAR(asystole), 1];
    } else {
        _patient setVariable [QGVAR(asystole), 2, true];
        _asystole = _patient getVariable [QGVAR(asystole), 2];
    };
};

{
    _x params ["_medication"];

    switch(_medication) do
    {
        case "Epinephrine": 
        {
        _epiBoost = 1.5;
        };
        case "Amiodarone": 
        {
        _amiBoost = _amiBoost + (random [8,14,20]);
        };
        case "Lidocaine":
        {
        _lidoBoost = _lidoBoost + 8;
        };
    };
} forEach (_patient getVariable [QACEGVAR(medical,medications), []]);

switch (_reviveObject) do {
    case "CPR": {
        [_patient, "activity", ACELSTRING(medical_treatment,Activity_CPR), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
        if (GVAR(enable_CPR_Chances)) then {
            switch (_medic getVariable [QACEGVAR(medical,medicClass),0]) do {
                case 0: {
                    _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(CPR_MinChance_Default), GVAR(CPR_MaxChance_Default), true];
                };
                case 1: {
                    _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(CPR_MinChance_RegularMedic), GVAR(CPR_MaxChance_RegularMedic), true];
                };
                case 2: {
                    _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(CPR_MinChance_Doctor), GVAR(CPR_MaxChance_Doctor), true];
                };
            };
        };
    };
    case "AED": {
        [_patient, "activity", LSTRING(Activity_AED), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
        _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(AED_MinChance), GVAR(AED_MaxChance), true];
    };
    case "AEDStation": {
        [_patient, "activity", LSTRING(Activity_AEDS), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
        _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(AED_MinChance), GVAR(AED_MaxChance), true];
    };
    case "AEDX": {
        [_patient, "activity", LSTRING(Activity_AEDX), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
        _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(AED_X_MinChance), GVAR(AED_X_MaxChance), true];
    };
    case "AEDXVehicle": {
        [_patient, "activity", LSTRING(Activity_AEDX), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
        _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(AED_X_MinChance), GVAR(AED_X_MaxChance), true];
    };
};

if (_reviveObject isEqualTo "AED" || _reviveObject isEqualTo "AEDX" || _reviveObject isEqualTo "AEDStation" || _reviveObject isEqualTo "AEDXVehicle") exitWith {
    _chance = _chance + (_amiBoost + (1 max _lidoBoost) * _epiBoost);

    if ((_random <= _chance) && (_asystole isEqualTo 1)) then {
        [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
        if (GVAR(AdvRhythm)) then {
        _patient setVariable [QGVAR(asystole), 1, true];
        };
        _patient setVariable [QGVAR(CPRcount), 2, true];
    };
};

if !(GVAR(enable_CPR_Chances)) then {
    private _min = ACEGVAR(medical_treatment,cprSuccessChanceMin);
    private _max = ACEGVAR(medical_treatment,cprSuccessChanceMax);
    _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), _min, _max, true];
    // ACE Medical settings are percentages (decimals, 0 <= x <= 1) instead of integers

    if ((random 1) <= _chance) then {
        [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
        if (GVAR(AdvRhythm)) then {
        _patient setVariable [QGVAR(asystole), 1, true];
        };
    };
} else {

    if (_epiBoost isEqualTo 1.5) then {
        _chance = _chance + (2 ^ _CPRcount);
        _CPRcount = _CPRcount + 1;
        _patient setVariable [QGVAR(CPRcount), _CPRcount, true];
    };

    if (_random <= _chance) then {
        if ((_randomAmi > 2) && (_asystole isEqualTo 2)) then {
             if (GVAR(AdvRhythm)) then {
            _patient setVariable [QGVAR(asystole), 1, true];
            };
        } else {
            [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
            if (GVAR(AdvRhythm)) then {
            _patient setVariable [QGVAR(asystole), 1, true];
            };
            _patient setVariable [QGVAR(CPRcount), 2, true];
        };
    };
};
