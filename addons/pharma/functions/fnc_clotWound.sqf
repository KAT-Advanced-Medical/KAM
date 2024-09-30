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
    params ["_unit", "_bodyPart", "_wounds", "_countTXA", "_countEACA"];

        {
            _x params ["_woundClassID", "_amountOf", "_bleeding", "_damage"];

            private _category = _woundClassID % 10;
            private _suffix = ["Minor", "Medium", "Large"] select _category;
            private _selectionName = localize format [LSTRING(%1), _bodyPart];
            private _logString = LSTRING(coagulation_Bandaged);
            private _woundClotTime = 0;
            private _bandageToUse = "";
            private _coagulation_time_minor = missionNamespace getVariable [QGVAR(coagulation_time_minor), 15];
            private _coagulation_time_medium = missionNamespace getVariable [QGVAR(coagulation_time_medium), 30];
            private _coagulation_time_large = missionNamespace getVariable [QGVAR(coagulation_time_large), 45];
            private _factorCountToRemove = 1;

            switch (_suffix) do {
                case "Minor": {
                    _woundClotTime = round ((random (_coagulation_time_minor / 2)) + _coagulation_time_minor / 2);
                    _bandageToUse = "BloodClotMinor";
                    _factorCountToRemove = 1;

                    if !(missionNamespace getVariable [QGVAR(coagulation_allow_MinorWounds), true]) then { continue; };
                };
                case "Medium": {
                    _woundClotTime = round ((random (_coagulation_time_medium / 2)) + _coagulation_time_medium / 2);
                    _bandageToUse = "BloodClotMedium";
                    _factorCountToRemove = 2;

                    if !(missionNamespace getVariable [QGVAR(coagulation_allow_MediumWounds), true]) then { continue; };
                };
                default {
                    _woundClotTime = round ((random (_coagulation_time_large / 2)) + _coagulation_time_large / 2);
                    _bandageToUse = "BloodClotLarge";
                    _factorCountToRemove = 4;

                    if !(missionNamespace getVariable [QGVAR(coagulation_allow_LargeWounds), true]) then { continue; };
                };
            };

            if (_amountOf * _bleeding > 0) exitWith {

                if (_countTXA > 0 || _countEACA > 0) then {
                    _logString = LSTRING(coagulation_Bandaged_TXA);

                    if (_countEACA > 0 && _countTXA > 0) exitWith { // If TXA & EACA are in system at same time use EACA bandage
                        _woundClotTime = round (_woundClotTime / 3 * 2);
                        _bandageToUse = _bandageToUse + "EACA";
                    };

                    _bandageToUse = _bandageToUse + "TXA";
                };

                [{
                    params["_unit", "_bodyPart", "_selectionName", "_bandageToUse", "_logString", "_factorCountToRemove"];

                    private _coagulationFactor = _unit getVariable [QGVAR(coagulationFactor), 30];
                    private _openWounds = GET_OPEN_WOUNDS(_unit);
                    private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];
                    private _woundIndex = _openWoundsOnPart findIf {(_x select 1) > 0 && (_x select 2) > 0};

                    if (_coagulationFactor <= 0) exitWith {};
                    if (_woundIndex == -1) exitWith {};
                    if ([_unit, _bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo) && missionNamespace getVariable [QGVAR(coagulation_tourniquetBlock), true]) exitWith {};

                    _unit setVariable [QGVAR(coagulationFactor), (_coagulationFactor - _factorCountToRemove), true];
                    [QACEGVAR(medical_treatment,bandageLocal), [_unit, _bodyPart, _bandageToUse, 1], _unit] call CBA_fnc_targetEvent;
                    if (GVAR(coagulation_allow_clot_text)) then {
                        [_unit, "activity", _logString, [(toLower _selectionName)]] call ACEFUNC(medical_treatment,addToLog);
                    };
                },
                [_unit, _bodyPart, _selectionName, _bandageToUse, _logString, _factorCountToRemove], _woundClotTime] call CBA_fnc_waitAndExecute;
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

    if (!(GVAR(coagulation_allowOnAI)) && ACE_Player != _unit) exitWith { // Check allowOnAI setting to save performance
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, createHashMap];
    private _pulse = _unit getVariable [VAR_HEART_RATE, 80];
    private _coagulationFactor = _unit getVariable [QGVAR(coagulationFactor), 30];
    private _countTXA = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);
    private _countEACA = [_unit, "EACA"] call ACEFUNC(medical_status,getMedicationCount);
    private _hasWoundToBandageArray = [];

    if (_openWounds isEqualTo createHashMap) exitWith {}; // Exit when hashmap not initialized (Will not work when hashmap is set, cause ace only changes value of "woundCount" to 0)
    if (_coagulationFactor <= 0) exitWith {}; // Exit when no coagFactors left
    if (GET_BLOOD_VOLUME_LITERS(_unit) < GVAR(coagulation_requireBV)) exitWith {}; // Blood volume check
    if ((_pulse < 20) && GVAR(coagulation_requireHR)) exitWith {}; // Has pulse & require setting

    private _shuffledKeys = keys _openWounds call BIS_fnc_arrayShuffle; // Shuffel Keys to switch bodypart after each bandage for on_all_Bodyparts setting

    {
        if ([_unit, _x] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo) && missionNamespace getVariable [QGVAR(coagulation_tourniquetBlock), true]) then { // Check for tourniqet
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

        if (!(GVAR(coagulation_on_all_Bodyparts)) && true in _hasWoundToBandageArray) exitWith { // Check if coag should be present on all body party simultaneously, if not use this exitWith to block next interiation of forEach
            [_unit, _x, _openWounds get _x, _countTXA, _countEACA] call _fnc_clotWound;
        };

        if (true in _hasWoundToBandageArray) then { // Check if there is a wound to bandage for coag, if not loop through next interiation of forEach
            [_unit, _x, _openWounds get _x, _countTXA, _countEACA] call _fnc_clotWound;
        };
    } forEach _shuffledKeys;
}, missionNamespace getVariable [QGVAR(coagulation_time), 5], [_unit, _fnc_clotWound]] call CBA_fnc_addPerFrameHandler;
