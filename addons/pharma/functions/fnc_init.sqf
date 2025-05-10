#include "..\script_component.hpp"
/*
 * Author: Katalam, Miss Heda
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_init;
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

[_unit] call FUNC(fullHealLocal);

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _alive = alive _unit;

    if (!_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _medicationArray = _unit getVariable [QACEGVAR(medical,medications), []];
    private _alpha = false;
    private _opioid = false;

    {
        _x params ["_medication"];

        if (_medication in ["Epinephrine", "EpinephrineIV", "Phenylephrine", "Nitroglycerin", "Lidocaine", "Norepinephrine"]) exitWith {
            _alpha = true;
        };
    } forEach (_medicationArray);

    {
        _x params ["_medication"];

        if (_medication in ["Fentanyl", "Morphine", "Nalbuphine"]) exitWith {
            _opioid = true;
        };
    } forEach (_medicationArray);

    if !(_alpha) then {
        _unit setVariable [QGVAR(alphaAction), 1];
    };

    if !(_opioid) then {
        _unit setVariable [QGVAR(opioidFactor), 1];
    };
}, 180, [_unit]] call CBA_fnc_addPerFrameHandler;

if (GVAR(kidneyAction)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _alive = alive _unit;

        if (!_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _ph = _unit getVariable [QGVAR(externalPh), 0];
        private _kidneyFail = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyArrest = _unit getVariable [QGVAR(kidneyArrest), false];
        private _kidneyPressure = _unit getVariable [QGVAR(kidneyPressure), false];

        switch true do {
            case(_ph == 3000): {
                if (_ph == 3000) exitWith {
                    _unit setVariable [QGVAR(kidneyFail), true, true];
                    _unit setVariable [QGVAR(kidneyArrest), true, true];
                };
            };
            case (_ph >= 2000): {
                _unit setVariable [QGVAR(kidneyFail), true, true];

                if !(_kidneyArrest) then {
                    private _random = random 1;
        
                    if (_random >= 0.75) then {
                        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                        _unit setVariable [QGVAR(kidneyArrest), true, true];
                    };
                };
            };
            case (_ph >= 1000): {
                _ph = (_ph - 30) max 0;
                _unit setVariable [QGVAR(externalPh), _ph, true];
    
                if !(_kidneyPressure) then {
                    _unit setVariable [QGVAR(kidneyPressure), true, true];
                    [_unit, "KIDNEY", 15, 1200, 30, 0, 15] call ACEFUNC(medical_status,addMedicationAdjustment);
                };
            };
            default {
                _ph = (_ph - 60) max 0;
                _unit setVariable [QGVAR(externalPh), _ph, true];
            };
        };
    }, 20, [_unit]] call CBA_fnc_addPerFrameHandler;
};
