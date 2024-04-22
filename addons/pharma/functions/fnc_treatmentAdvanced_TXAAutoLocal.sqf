#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
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

params ["_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
;

if !(GVAR(coagulation)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        private _alive = alive _patient;
        private _exit = true;

        if !(GVAR(kidneyAction)) then {
            _patient setVariable [QGVAR(pH), 1500, true];
        };

        private _random = random 1000;
        private _ph = (_patient getVariable [QGVAR(pH), 1500]) - 500;

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

        if (!(_alive) || (_exit)) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

    }, 5, [_patient]] call CBA_fnc_addPerFrameHandler;
};