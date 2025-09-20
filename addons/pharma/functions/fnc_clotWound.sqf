#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Clots wounds
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_clotWound;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(coagulation)) exitWith {};

private _fnc_clotWound = {
    params ["_unit", "_bodyPart", "_wounds", "_txaEffectiveness"];

        {
            _x params ["_woundClassID", "_amountOf", "_bleeding", "_damage"];
            private _category = _woundClassID % 10;
            private _suffix = ["Minor", "Medium", "Large"] select _category;
            private _classIndex = _woundClassID / 10;
            private _classname = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
            private _selectionName = localize format [LSTRING(%1), _bodyPart];
            private _logString = LSTRING(coagulation_Bandaged);
            private _woundClotTime = 0;
            private _chance = 0;
            private _bandageToUse = "";
            private _coagulation_time_minor = missionNamespace getVariable [QGVAR(coagulation_time_minor), 15];
            private _coagulation_time_medium = missionNamespace getVariable [QGVAR(coagulation_time_medium), 30];
            private _coagulation_time_large = missionNamespace getVariable [QGVAR(coagulation_time_large), 45];
            private _factorCountToRemove = 1;
            private _woundClotDelayMult = 1;
            private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
            private _medsToCheck = ["Alteplase", "CWMP"];
            private _alteplaseEffectiveness = 0;
            private _cwmpEffectiveness = 0;
            {
                private _medName = toLower (_x select 0);
                private _effectiveness = _x select 2;
                if ("alteplase" in _medName) then {
                    _alteplaseEffectiveness = _alteplaseEffectiveness max _effectiveness;
                };
                if ("cwmp" in _medName) then {
                    _cwmpEffectiveness = _cwmpEffectiveness max _effectiveness;
                };
            } forEach _medStack;
            private _cwmpFixedEffectiveness = linearConversion [0, 1, _cwmpEffectiveness, 1, 1.2];
            private _alteplaseFixedEffectiveness = linearConversion [0, 1, _alteplaseEffectiveness, 1, 10];
            private _coagulationFactor = GET_BODY_FLUID_PLATELETS(_unit);
            private _hypothermiaDelay = 1;
            if (EGVAR(hypothermia,hypothermiaActive)) then {
                _hypothermiaDelay = linearConversion [35, 30, (_unit getVariable [QEGVAR(hypothermia,unitTemperature), 37]), 1, 3, true];
            };
            if (EGVAR(hypothermia,hypothermiaActive) && (_unit getVariable [QEGVAR(hypothermia,unitTemperature), 37]) < 30) exitWith {};
            private _woundClotDelayMult = (1 * _alteplaseFixedEffectiveness * (600/_coagulationFactor) * _cwmpFixedEffectiveness * _hypothermiaDelay * GET_VASOCONSTRICTION(_unit)) min 10;
            if (_woundClotDelayMult > 6) exitWith {};
            switch (_suffix) do {
                case "Minor": {
                    switch (true) do {
                        case (_classname in ["Cut", "Abrasion"]): {
                            _woundClotTime = round ((random (_coagulation_time_minor / 2)) + _coagulation_time_minor / 2) * _woundClotDelayMult * random [0.6, 0.8, 0.9];
                            _bandageToUse = "BloodClotMinor";
                            _factorCountToRemove = round (random [5, 9, 15]);
                            _chance = GVAR(coagulation_chance_MinorWounds) * 1.25;
                        };
                        case (_classname in ["Laceration", "PunctureWound"]): {
                            _woundClotTime = round ((random (_coagulation_time_minor / 2)) + _coagulation_time_minor / 2) * _woundClotDelayMult;
                           _bandageToUse = "BloodClotMinor";
                            _factorCountToRemove = round (random [8, 16, 25]);
                            _chance = GVAR(coagulation_chance_MinorWounds);
                        };
                        case (_classname in ["VelocityWound", "Avulsion"]): {
                            _woundClotTime = round ((random (_coagulation_time_minor/ 2)) + _coagulation_time_minor / 2) * _woundClotDelayMult * random [1.1, 1.4, 1.8];
                            _bandageToUse = "BloodClotMinor";
                            _factorCountToRemove = round (random [15, 19, 30]);
                            _chance = GVAR(coagulation_chance_MinorWounds) * 0.75;
                        };
                        case (_classname in ["InternalBleeding", "Evisceration"]): {
                            _woundClotTime = round ((random (_coagulation_time_minor / 2)) + _coagulation_time_minor / 2) * _woundClotDelayMult;
                            _bandageToUse = "BloodClotMinor";
                            _factorCountToRemove = round (random [8, 14, 20]);
                            _chance = GVAR(coagulation_chance_MinorWounds) * 1.5;
                        };
                        default {
                            _woundClotTime = round ((random (_coagulation_time_minor / 2)) + _coagulation_time_minor / 2) * _woundClotDelayMult;
                            _bandageToUse = "BloodClotMinor";
                            _factorCountToRemove = round (random [8, 14, 20]);
                            _chance = GVAR(coagulation_chance_MinorWounds);
                        };
                    };
                    if !(missionNamespace getVariable [QGVAR(coagulation_allow_MinorWounds), true]) then { continue; };
                };
                case "Medium": {
                    switch (true) do {
                        case (_classname in ["Cut", "Abrasion"]): {
                            _woundClotTime = round ((random (_coagulation_time_medium / 2)) + _coagulation_time_medium / 2) * _woundClotDelayMult * random [0.6, 0.8, 0.9];
                            _bandageToUse = "BloodClotMedium";
                            _factorCountToRemove = round (random [10, 15, 25]);
                            _chance = GVAR(coagulation_chance_MediumWounds) * 1.25;
                        };
                        case (_classname in ["Laceration", "PunctureWound"]): {
                            _woundClotTime = round ((random (_coagulation_time_medium / 2)) + _coagulation_time_medium / 2) * _woundClotDelayMult;
                           _bandageToUse = "BloodClotMedium";
                            _factorCountToRemove = round (random [18, 26, 35]);
                            _chance = GVAR(coagulation_chance_MediumWounds);
                        };
                        case (_classname in ["VelocityWound", "Avulsion"]): {
                            _woundClotTime = round ((random (_coagulation_time_medium/ 2)) + _coagulation_time_medium / 2) * _woundClotDelayMult * random [1.1, 1.4, 1.8];
                            _bandageToUse = "BloodClotMedium";
                            _factorCountToRemove = round (random [22, 29, 40]);
                            _chance = GVAR(coagulation_chance_MediumWounds) * 0.75;
                        };
                        case (_classname in ["InternalBleeding", "Evisceration"]): {
                            _woundClotTime = round ((random (_coagulation_time_medium / 2)) + _coagulation_time_medium / 2) * _woundClotDelayMult;
                            _bandageToUse = "BloodClotMedium";
                            _factorCountToRemove = round (random [14, 21, 30]);
                            _chance = GVAR(coagulation_chance_MediumWounds) * 1.5;
                        };
                        default {
                            _woundClotTime = round ((random (_coagulation_time_medium / 2)) + _coagulation_time_medium / 2) * _woundClotDelayMult;
                            _bandageToUse = "BloodClotMedium";
                            _factorCountToRemove = round (random [14, 21, 30]);
                            _chance = GVAR(coagulation_chance_MediumWounds);
                        };
                    };
                    if !(missionNamespace getVariable [QGVAR(coagulation_allow_MediumWounds), true]) then { continue; };
                };
                default {
                    switch (true) do {
                        case (_classname in ["Cut", "Abrasion"]): {
                            _woundClotTime = round ((random (_coagulation_time_large / 2)) + _coagulation_time_large / 2) * _woundClotDelayMult * random [0.6, 0.8, 0.9];
                            _bandageToUse = "BloodClotLarge";
                            _factorCountToRemove = round (random [15, 23, 35]);
                            _chance = GVAR(coagulation_chance_LargeWounds) * 1.25;
                        };
                        case (_classname in ["Laceration", "PunctureWound"]): {
                            _woundClotTime = round ((random (_coagulation_time_large / 2)) + _coagulation_time_large / 2) * _woundClotDelayMult;
                           _bandageToUse = "BloodClotLarge";
                            _factorCountToRemove = round (random [24, 32, 45]);
                            _chance = GVAR(coagulation_chance_LargeWounds);
                        };
                        case (_classname in ["VelocityWound", "Avulsion"]): {
                            _woundClotTime = round ((random (_coagulation_time_large/ 2)) + _coagulation_time_large / 2) * _woundClotDelayMult * random [1.1, 1.4, 1.8];
                            _bandageToUse = "BloodClotLarge";
                            _factorCountToRemove = round (random [35, 41, 50]);
                            _chance = GVAR(coagulation_chance_LargeWounds) * 0.75;
                        };
                        case (_classname in ["InternalBleeding", "Evisceration"]): {
                            _woundClotTime = round ((random (_coagulation_time_large / 2)) + _coagulation_time_large / 2) * _woundClotDelayMult;
                            _bandageToUse = "BloodClotLarge";
                            _factorCountToRemove = round (random [22, 31, 40]);
                            _chance = GVAR(coagulation_chance_LargeWounds) * 1.5;
                        };
                        default {
                            _woundClotTime = round ((random (_coagulation_time_large / 2)) + _coagulation_time_large / 2) * _woundClotDelayMult;
                            _bandageToUse = "BloodClotLarge";
                            _factorCountToRemove = round (random [22, 31, 40]);
                            _chance = GVAR(coagulation_chance_LargeWounds);
                        };
                    };
                    if !(missionNamespace getVariable [QGVAR(coagulation_allow_LargeWounds), true]) then { continue; };
                };
            };
            _factorCountToRemove = ceil (_factorCountToRemove * (1 + ( _bleeding * 0.5)));
            if (_amountOf * _bleeding > 0) exitWith {

                if (_txaEffectiveness > 0.2) then {
                    _logString = LSTRING(coagulation_Bandaged_TXA);
                    _bandageToUse = _bandageToUse + "TXA";
                    _factorCountToRemove = _factorCountToRemove * 0.5
                };
                [{
                    params["_unit", "_bodyPart", "_selectionName", "_bandageToUse", "_logString", "_factorCountToRemove", "_chance", "_txaEffectiveness"];

                    private _bodyFluid = GET_BODY_FLUID(_unit);
                    private _coagulationFactor = GET_BODY_FLUID_PLATELETS(_unit);
                    if (_coagulationFactor <= 0) exitWith {};
                    private _bodyPartN = ALL_BODY_PARTS find _bodyPart;
                    private _woundIndex = _openWoundsOnPart findIf {(_x select 1) > 0 && (_x select 2) > 0};
                    if (_woundIndex == -1) exitWith {};
                    if ([_unit,_bodyPartN] call EFUNC(pharma,occlusionCheck) && GVAR(coagulation_tourniquetBlock)) exitWith {};
                    private _openWounds = GET_OPEN_WOUNDS(_unit);
                    private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];
                    private _txaMult = linearConversion [0, 1, _txaEffectiveness, 1, 1.5];
                    private _chance = _chance * _txaMult;
                    if (HAS_APPLIEDPRESSURE_ON(_unit,_bodyPartN) && GVAR(pressureInfluenceCoag)) then {
                        _chance = _chance * 1.25;
                    } else {
                        _chance = _chance * 1.25;
                    };
                    if (floor (random 100) > _chance) exitWith {};
                
                    _bodyFluid set [5, (_coagulationFactor - _factorCountToRemove)];
                    _unit setVariable [VAR_BODY_FLUID, _bodyFluid, true];
                    [QACEGVAR(medical_treatment,bandageLocal), [_unit, _bodyPart, _bandageToUse, 1], _unit] call CBA_fnc_targetEvent;
                    if (GVAR(coagulation_allow_clot_text)) then {
                        private _classIndex = _woundClassID / 10;
                        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
                        if (_className in ["InternalBleeding", "Evisceration"]) exitWith {};
                        [_unit, "activity", _logString, [(toLower _selectionName)]] call ACEFUNC(medical_treatment,addToLog);
                    };
                },
                [_unit, _bodyPart, _selectionName, _bandageToUse, _logString, _factorCountToRemove, _chance, _txaEffectiveness], _woundClotTime] call CBA_fnc_waitAndExecute;
            };
        } forEach _wounds;
};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_fnc_clotWound"];

    private _alive = alive _unit;

    if !(_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    // Check allowOnAI setting to save performance
    if (!(GVAR(coagulation_allowOnAI)) && (ACE_player != _unit)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, createHashMap];
    private _pulse = _unit getVariable [VAR_HEART_RATE, 80];
    private _coagulationFactor = GET_BODY_FLUID_PLATELETS(_unit);
    private _txaEffectiveness = [_patient, "TXA"] call ACEFUNC(medical_status,getMedicationCount) select 1;
    private _hasWoundToBandageArray = [];

    if (_openWounds isEqualTo createHashMap) exitWith {}; // Exit when hashmap not initialized (Will not work when hashmap is set, cause ace only changes value of "woundCount" to 0)
    if (_coagulationFactor <= 0) exitWith {}; // Exit when no coagFactors left
    if (GET_BLOOD_VOLUME_LITERS(_unit) < GVAR(coagulation_requireBV)) exitWith {}; // Blood volume check
    if ((_pulse < 20) && GVAR(coagulation_requireHR)) exitWith {}; // Has pulse & require setting

    private _shuffledKeys = keys _openWounds call BIS_fnc_arrayShuffle; // Shuffel Keys to switch bodypart after each bandage for on_all_Bodyparts setting

    {
        private _bodyPartN = ALL_BODY_PARTS find _x;
        if ([_unit,_bodyPartN] call EFUNC(pharma,occlusionCheck) && missionNamespace getVariable [QGVAR(coagulation_tourniquetBlock), true]) then { // Check for tourniqet
            continue;
        };

        {
            _x params ["_woundClassID", "_amountOf", "_bleeding", "_damage"];

            private _category = _woundClassID % 10;
            private _suffix = ["Minor", "Medium", "Large"] select _category;

            switch (_suffix) do {
                case "Minor": {
                    if (missionNamespace getVariable [QGVAR(coagulation_allow_MinorWounds), true] && _amountOf * _bleeding > 0) then {
                        _hasWoundToBandageArray pushBack true;
                    };
                };
                case "Medium": {
                    if (missionNamespace getVariable [QGVAR(coagulation_allow_MediumWounds), true] && _amountOf * _bleeding > 0) then {
                        _hasWoundToBandageArray pushBack true;
                    };
                };
                default {
                    if (missionNamespace getVariable [QGVAR(coagulation_allow_LargeWounds), true] && _amountOf * _bleeding > 0) then {
                        _hasWoundToBandageArray pushBack true;
                    };
                };
            };
        } forEach (_openWounds get _x); // Sets array that specifies if there is a open wound that coag can bandage in body part (here for performance so that the fnc does not get called every time)

        if (true in _hasWoundToBandageArray) then { // Check if there is a wound to bandage for coag, if not loop through next interiation of forEach
            [_unit, _x, _openWounds get _x, _txaEffectiveness] call _fnc_clotWound;
        };
    } forEach _shuffledKeys;
}, missionNamespace getVariable [QGVAR(coagulation_time), 5], [_unit, _fnc_clotWound]] call CBA_fnc_addPerFrameHandler;
