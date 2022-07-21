#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Begins TXA bandaging process
 *
 * Arguments:
 * 0: Medic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_patient"];

private _IVsite = _patient getVariable [QGVAR(IVsite), 0];

if (_IVsite > 1) then {
    private _randomNumber = random 100;
    private _flush = _patient getVariable [QGVAR(IVflush), false];
    private _block = _patient getVariable [QGVAR(IVblock), false];

    if !(_flush) then {
        if (_randomNumber < GVAR(blockChance)) then {
            _block = true;
            _patient setVariable [QGVAR(IVblock), true, true];
        };
    };

    if (_block) exitWith {};

    _patient setVariable [QGVAR(IVflush), false, false];
};

[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];

    private _medicationArray = _patient getVariable ["ace_medical_medications", []];
    private _TXA = false;
    private _TXAactive = true;

    {
        _x params ["_medication"];

        if (_medication == "TXA") exitWith {
            _TXA = true;
       };
    } forEach (_medicationArray);

    if (_unit getVariable ["kat_TXA_PFH", false]) exitWith {}; 
    _unit setVariable ["kat_TXA_PFH", true];

    private _alive = alive _patient;

    if ((!_alive) || (!_TXA)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ["kat_TXA_PFH", nil]; 
    };

    private _openWounds = _patient getVariable ["ace_medical_openWounds", []];

    private _random = random 1000;
    private _ph = (_patient getVariable [QGVAR(ph), 1500]) - 500;

    if (_random <= _ph) then {
        {
            _x params ["_id", "_bodyPart", "_amount"];

            if ((_id != 20) && (_amount > 0)) exitWith {
                private _part = ALL_BODY_PARTS select _bodyPart;
                ["ace_medical_treatment_bandageLocal", [_patient, _part, "QuikClot"], _patient] call CBA_fnc_patientEvent;
            };

        } forEach _openWounds;
    };

}, 6, [_patient]] call CBA_fnc_addPerFrameHandler;

true