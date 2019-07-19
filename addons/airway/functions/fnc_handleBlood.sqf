#include "script_component.hpp"
/*
 * Author: Katalam
 * Called when a unit enters the unconscious state. Will add a FrameHandler for puking while unconscious.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call KAM_airway_fnc_handleBlood;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(enable)) exitWith {};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    private _ml = _unit getVariable [QGVAR(bloodInAirway), 0];
    if (_ml > 50) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(occluded), true, true];
    };
    // to-do remove if alive or something else
    private _headBleeding = 0;
    {
        _x params ["", "", "_bodyPart", "_amountOf", "_bleeeding"];
        if (_bodyPart == 0) then {
            _headBleeding = _headBleeding + (_amountOf * _bleeeding);
        };
    } forEach (_unit getVariable ["ace_medical_openWounds", []]);
    private _headBleeding = (_headBleeding min 0.9);

    private _cardiacOutput = [_unit] call ace_medical_status_fnc_getCardiacOutput;

    if (((eyeDirection _unit) select 2) < -0.02) exitWith {};
    _ml = _ml + (_headBleeding * _cardiacOutput * ace_medical_bleedingCoefficient);
    _unit setVariable [QGVAR(bloodInAirway), _ml, true];

}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
