#include "..\script_component.hpp"
/*
 * Author: Mazinski/Cplhardcore
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
 * [player] call kat_pharma_fnc_treatmentAdvanced_TXAAutoLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart"];
private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
private _medsToCheck = ["TXA"];
private _txaEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("TXA" in _medName) then {
        _txaEffectiveness = _txaEffectiveness max _effectiveness;
    };
} forEach _medStack;
private _allowStack = missionNamespace getVariable [QGVAR(allowStackScript_TXA), true];
private _keepRunning = missionNamespace getVariable [QGVAR(keepScriptRunning_TXA), false];
private _cycleTime = missionNamespace getVariable [QGVAR(bandageCycleTime_TXA), 5];

if (!(GVAR(coagulation)) || GVAR(coagulation_allow_TXA_script)) then {

        if ((_txaEffectiveness > 0.3) && !(_allowStack)) exitWith {};

        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_keepRunning"];

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

                    if (_openWoundsOnPart isEqualTo [] || [_patient,_x] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) then {
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
            [_patient, _idPFH], 300] call CBA_fnc_waitAndExecute;

            if (_exit && !(_keepRunning)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

        }, _cycleTime, [_patient, _keepRunning]] call CBA_fnc_addPerFrameHandler;
};