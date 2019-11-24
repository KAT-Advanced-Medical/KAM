#include "script_component.hpp"
/*
 * Author: Katalam
 * Will be called with a head wound from KAM_airway_fnc_handleAirway
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call KAM_airway_fnc_bloodHandler;
 *
 * Public: No
 */

params ["_unit"];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _ml = _unit getVariable [QGVAR(bloodInAirway), 0];
    if (_ml > 50) then {
        _unit setVariable [QGVAR(occluded), true, true];
    };

    /* Fix this shit!
    private _wounds = [_unit] call ace_medical_treatment_fnc_getStitchableWounds;
    private _remove = {
        params ["", "_bodyPartN"];
        if (_bodyPartN == 0) exitWith {false};
        true;
    } forEach _wounds;
    */
    
    if (_remove) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    
    private _headBleeding = 0;
    {
        _x params ["_woundClassID", "_bodyPartN", "_amountOf", "_bleeding"];
        if (_bodyPartN == 0 && {getNumber (configFile >> "ACE_Medical_Injuries" >> ace_medical_damage_woundClassNamesComplex select _woundClassID >> "internal") > 0}) then {
            _headBleeding = _headBleeding + (_amountOf * _bleeding);
        };
    } forEach (_unit getVariable ["ace_medical_openWounds", []]);
    if (_headBleeding < 0.01) exitWith {
        _unit setVariable [QGVAR(bloodInAirway), 0, true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _headBleeding = (_headBleeding min 0.9);

    private _cardiacOutput = [_unit] call ace_medical_status_fnc_getCardiacOutput;

    _ml = _ml + (_headBleeding * _cardiacOutput * ace_medical_bleedingCoefficient);
    _unit setVariable [QGVAR(bloodInAirway), _ml, true];

}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
