#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_misc_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];

[_unit] call FUNC(fullHealLocal);

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _alive = alive _unit;

    if (!_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _medicationArray = _unit getVariable [QACEGVAR(medical,medications), []];
    private _action = false;

    {
        _x params ["_medication"];

        if (_medication in ["Epinephrine", "EpinephrineIV", "Phenylephrine", "Nitroglycerin", "Lidocaine", "Norepinephrine", "syringe_kat_norepinephrine_5ml_1", "syringe_kat_norepinephrine_5ml_2", "syringe_kat_phenylephrine_5ml_1", "syringe_kat_phenylephrine_5ml_2", "syringe_kat_nitroglycerin_5ml_1", "syringe_kat_nitroglycerin_5ml_2", "syringe_kat_epinephrineIV_5ml_1", "syringe_kat_epinephrineIV_5ml_2", "syringe_kat_lidocaine_5ml_1", "syringe_kat_lidocaine_5ml_2","syringe_kat_lidocaine_10ml_1"]) exitWith {
            _action = true;
        };
    } forEach (_medicationArray);

    if !(_action) then {
        _unit setVariable [QGVAR(alphaAction), 1];
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
