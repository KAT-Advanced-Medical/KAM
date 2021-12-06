#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Begins TXA bandaging process
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "TXA"] call aceP_circulation_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_target", "_item"];

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, "TXA"]] call ace_medical_treatment_fnc_addToLog;
[_target, "TXA", 5, 120, 0, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;


[{
    params ["_args", "_idPFH"];
    _args params ["_target"];

    private _medicationArray = _target getVariable ["ace_medical_medications", []];
    private _TXA = false;
    private _TXAactive = true;

    {
        _x params ["_medication"];

        if (_medication == "TXA") exitWith {
            _TXA = true;
       };
    } forEach (_medicationArray);

    private _alive = alive _target;

    if ((!_alive) || (_TXA == false)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler; 
    };

    private _openWounds = _target getVariable ["ace_medical_openWounds", []];
    private _once = false;

    {
        _x params ["_id", "_bodyPart", "_amount"];

        if (_once == false && _id != 20 && _amount > 0) exitWith {
            private _part = ALL_BODY_PARTS select _bodyPart;
            ["ace_medical_treatment_bandageLocal", [_target, _part, "QuikClot"], _target] call CBA_fnc_targetEvent;

            _once = true;
        };

    } forEach _openWounds;

}, 6, [_target]] call CBA_fnc_addPerFrameHandler;

true