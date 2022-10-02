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

[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];

    private _medicationArray = _patient getVariable ["ace_medical_medications", []];
    private _TXA = false;

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
    private _once = false;

    {
        _x params ["_id", "_bodyPart", "_amount"];

        if (!_once && (floor(_id / 10) != 2) && (floor(_id / 10) != 8) && (_amount > 0)) exitWith {
            private _part = ALL_BODY_PARTS select _bodyPart;
            ["ace_medical_treatment_bandageLocal", [_patient, _part, "QuikClot"], _patient] call CBA_fnc_targetEvent;

            _once = true;
        };

    } forEach _openWounds;

}, 6, [_patient]] call CBA_fnc_addPerFrameHandler;