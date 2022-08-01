#include "script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_init;
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(pH), 1500, true];
_unit setVariable [QGVAR(kidneyFail), false, true];
_unit setVariable [QGVAR(kidneyArrest), false, true];
_unit setVariable [QGVAR(kidneyPressure), false, true];

_unit setVariable [QGVAR(debridement), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(fractures), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(lidocaine), false, true];
_unit setVariable [QGVAR(etomidate), false, true];
_unit setVariable [QGVAR(sedated), false, true];

/*
* 0 = Unaffected
* 1 = Stable Fracture 
* 2 = Compound Fracture
* 3 = Comminuted Fracture
* 2.1/3.1 = Open Fracture
* 2.2/3.2 = Prepared Fracture
* 2.5 = Irrigated Fracture
* 3.5 = Clamped Fracture
*/

if (GVAR(kidneyAction)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _ph = _unit getVariable [QGVAR(ph), 1500];
        if (_ph == 1500) exitWith {};

        private _kidneyFail = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyArrest = _unit getVariable [QGVAR(kidneyArrest), false];
        private _kidneyPressure = _unit getVariable [QGVAR(kidneyPressure), false];

        if (_ph <= 0) exitWith {
            _unit setVariable [QGVAR(kidneyFail), true, true];

            if !(_kidneyArrest) then {
                private _random = random 1;

                if (_random >= 0.5) then {
                    [_unit, true] call ace_medical_status_fnc_setCardiacArrestState;
                    _unit setVariable [QGVAR(kidneyArrest), true, true];
                };
            };
        };

        if (_ph < 750) exitWith {
            _ph = (_ph + 25) min 1500;
            _unit setVariable [QGVAR(ph), _ph, true];

            if !(_kidneyPressure) then {
                _unit setVariable [QGVAR(kidneyPressure), true, true];
                [_unit, "KIDNEY", 15, 1200, 30, 0, 15] call ace_medical_status_fnc_addMedicationAdjustment;
            };
        };

        _ph = (_ph + 50) min 1500;
        _unit setVariable [QGVAR(ph), _ph, true];
    }, 20, [_unit]] call CBA_fnc_addPerFrameHandler;
};