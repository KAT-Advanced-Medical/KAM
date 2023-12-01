#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Modified: Tomcat, Blue
 * Overwrites the cprLocal of ACE to add the success chance for CPR/AED/AED-X
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

private _chance = 0;
private _random = random 100;
private _randomAmi = random 4;
private _epiBoost = 1;
private _amiBoost = 0;
private _lidoBoost = 0;
private _CPRcount = _patient getVariable [QGVAR(cprCount), 0];

private _fnc_advRhythm = {
    params ["_patient", ["_CPR",false]];

    private _patientState = _patient getVariable [QGVAR(cardiacArrestType), 0];

    if (_CPR) then {
        if (floor (random 100) <= GVAR(AdvRhythm_CPR_ROSC_Chance)) then {
            _patient setVariable [QGVAR(cardiacArrestType), 0, true];
        } else {
            if (_patient getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 1) then {
                _patient setVariable [QGVAR(cardiacArrestType), 3, true];
            } else {
                if (_patient getVariable [QGVAR(cardiacArrestType), 0] < 4) then {
                    _patient setVariable [QGVAR(cardiacArrestType), _patientState + 1, true];
                } else {
                    _patient setVariable [QGVAR(cardiacArrestType), 0, true];
                };
            };
        };
    } else {
        if (_patientState > 2) then {
            if (floor (random 100) <= GVAR(AdvRhythm_AED_ROSC_Chance) || _patientState isEqualTo 4) then {
                _patient setVariable [QGVAR(cardiacArrestType), 0, true];
            } else {
                _patient setVariable [QGVAR(cardiacArrestType), 4, true];
            };
        };
    };

    if (_patient getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 0) exitWith {
        [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
    };

    if (GVAR(AdvRhythm_deteriorateAfterTreatment)) then {
        [_patient, nil, false] call FUNC(handleCardiacArrest);
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
        [_patient, "activity", LSTRING(Activity_Shock), [[_medic, false, true] call ACEFUNC(common,getName), "AED"]] call ACEFUNC(medical_treatment,addToLog);
        _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(AED_MinChance), GVAR(AED_MaxChance), true];
    };
    case "AEDX": {
        [_patient, "activity", LSTRING(Activity_Shock), [[_medic, false, true] call ACEFUNC(common,getName), "AED-X"]] call ACEFUNC(medical_treatment,addToLog);
        _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), GVAR(AED_X_MinChance), GVAR(AED_X_MaxChance), true];
    };
};

if (_reviveObject in ["AED", "AEDX"]) exitWith {
    _chance = _chance + (_amiBoost + (1 max _lidoBoost) * _epiBoost);

    private _patientState = _patient getVariable [QGVAR(cardiacArrestType), 0];

    if (GVAR(AdvRhythm)) then {
        if (_patientState > 2) then {
            if (_random <= _chance) then {
                [_patient] call _fnc_advRhythm;
            };
            _patient setVariable [QGVAR(cprCount), 2, true];
        } else {
            if (GVAR(AdvRhythm_Hardcore_Enable) && _patientState == 2) then {
                _patient setVariable [QGVAR(cardiacArrestType), 1, true];
            };
        };
    } else {
        if (_random <= _chance) then {
            [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
        };
    };
};

if !(GVAR(enable_CPR_Chances)) then {
    private _min = ACEGVAR(medical_treatment,cprSuccessChanceMin);
    private _max = ACEGVAR(medical_treatment,cprSuccessChanceMax);
    _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), _min, _max, true];
    // ACE Medical settings are percentages (decimals, 0 <= x <= 1) instead of integers

    if ((random 1) <= _chance) then {
        if (GVAR(AdvRhythm)) then {
            [_patient, true] call _fnc_advRhythm;
        } else {
            [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
        };
    };
} else {
    if (_epiBoost isEqualTo 1.5) then {
        _chance = _chance + (2 ^ _CPRcount);

        _CPRcount = _CPRcount + 1;
        _patient setVariable [QGVAR(cprCount), _CPRcount, true];
    };

    if (_patient getVariable [QGVAR(cardiacArrestType), 0] in [4,3] && _randomAmi > 2) then {
        _chance = _chance + _amiBoost;
    };

    if (_random <= _chance) then {
        if (GVAR(AdvRhythm)) then {
            if (_patient getVariable [QGVAR(cardiacArrestType), 0] != 0) then {
                [_patient, true] call _fnc_advRhythm;
            };
        } else {
            [QACEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
        };
        _patient setVariable [QGVAR(cprCount), 2, true];
    } else {
        _CPRcount = _CPRcount + 1;
        _patient setVariable [QGVAR(cprCount), _CPRcount, true];
    };
};
