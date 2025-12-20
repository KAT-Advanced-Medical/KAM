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

if (GVAR(kidneyAction)) then {

    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        if (!alive _unit) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];
        private _bloodPH = (GET_PH(_unit)) max 6.5;

        private _damage = _unit getVariable [QGVAR(kidneyDamage), 0];
        private _kidneyFail = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyArrest = _unit getVariable [QGVAR(kidneyArrest), false];
        private _kidneyPressure = _unit getVariable [QGVAR(kidneyPressure), false];

        /*
            RENAL CLEARANCE OF METABOLIC ACID
        */
        if (!_kidneyFail && {_externalPh > 0}) then {

            private _baseClearance = 6; // slower, realistic
            private _phStress = linearConversion [7.4, 7.1, _bloodPH, 1, 2.2, true];
            private _damageMult = 1 - _damage;

            private _clearance =
                _baseClearance
                * _phStress
                * _damageMult;

            _externalPh = (_externalPh - _clearance) max 0;
            _unit setVariable [QEGVAR(pharma,externalPh), _externalPh, true];
        };

        /*
            RENAL DAMAGE FROM SUSTAINED ACIDOSIS
        */
        if (_bloodPH < 7.25) then {

            private _rate = linearConversion [7.25, 6.9, _bloodPH, 0.0008, 0.01, true];
            _damage = (_damage + _rate) min 1;
        };

        /*
            RENAL FAILURE
        */
        if (_damage >= 0.7 && !_kidneyFail) then {
            _unit setVariable [QGVAR(kidneyFail), true, true];
        };

        /*
            FLUID / PRESSURE EFFECTS
        */
        if (_kidneyFail && !_kidneyPressure) then {
            _unit setVariable [QGVAR(kidneyPressure), true, true];
            [_unit, "KIDNEY", 12, 1200, 25, 0, 12] call EFUNC(vitals,addMedicationAdjustment);
        };

        /*
            TERMINAL METABOLIC ACIDOSIS
        */
        if (_bloodPH < 6.9 && !_kidneyArrest) then {
            if (random 1 < 0.35) then {
                [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                _unit setVariable [QGVAR(kidneyArrest), true, true];
            };
        };

        _unit setVariable [QGVAR(kidneyDamage), _damage, true];

    }, 20, [_unit]] call CBA_fnc_addPerFrameHandler;
};