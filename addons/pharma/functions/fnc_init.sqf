#include "..\script_component.hpp"
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

        if (_medication in ["Epinephrine", "Phenylephrine", "Nitroglycerin", "Lidocaine", "Norepinephrine"]) exitWith {
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

        private _ph = _unit getVariable [QGVAR(pH), 1500];
        if (_ph == 1500) exitWith {
            _unit setVariable [QGVAR(kidneyArrest), false, true];
            _unit setVariable [QGVAR(kidneyPressure), false, true];
            _unit setVariable [QGVAR(kidneyFail), false, true];
        };

        private _kidneyFail = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyArrest = _unit getVariable [QGVAR(kidneyArrest), false];
        private _kidneyPressure = _unit getVariable [QGVAR(kidneyPressure), false];

        if (_ph <= 0) exitWith {
            _unit setVariable [QGVAR(kidneyFail), true, true];
            _unit setVariable [QGVAR(pH), 0, true];

            if !(_kidneyArrest) then {
                private _random = random 1;

                if (_random >= 0.5) then {
                    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                    _unit setVariable [QGVAR(kidneyArrest), true, true];
                };
            };
        };

        if (_ph < 750) exitWith {
            _ph = (_ph + 25) min 1500;
            _unit setVariable [QGVAR(pH), _ph, true];

            if !(_kidneyPressure) then {
                _unit setVariable [QGVAR(kidneyPressure), true, true];
                [_unit, "KIDNEY", 15, 1200, 30, 0, 15] call ACEFUNC(medical_status,addMedicationAdjustment);
            };
        };

        _ph = (_ph + 50) min 1500;
        _unit setVariable [QGVAR(pH), _ph, true];
    }, 20, [_unit]] call CBA_fnc_addPerFrameHandler;
};

if (GVAR(coagulation)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _alive = alive _unit;

        if !(_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, createHashMap];
        private _pulse = _unit getVariable [VAR_HEART_RATE, 80];
        private _coagulationFactor = _unit getVariable [QGVAR(coagulationFactor), 10];

        if (_openWounds isEqualTo []) exitWith {};
        if (_pulse < 20) exitWith {};
        if (_coagulationFactor == 0) exitWith {};

        private _count = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);

        if (_count == 0) exitWith {
            {
                private _part = _x;
                {
                    _x params ["", "_amountOf", "_bleeding"];
                    if (_amountOf * _bleeding > 0) exitWith {
                        [QACEGVAR(medical_treatment,bandageLocal), [_unit, _part, "UnstableClot"], _unit] call CBA_fnc_targetEvent;
                        _unit setVariable [QGVAR(coagulationFactor), (_coagulationFactor - 1), true];
                    };
                } forEach _y;
            } forEach _openWounds;
        };

        if (_count > 0) exitWith {
            {
                private _part = _x;
                {
                    _x params ["", "_amountOf", "_bleeding"];
                    if (_amountOf * _bleeding > 0) exitWith {
                        [QACEGVAR(medical_treatment,bandageLocal), [_unit, _part, "PackingBandage"], _unit] call CBA_fnc_targetEvent;
                        _unit setVariable [QGVAR(coagulationFactor), (_coagulationFactor - 1), true];
                    };
                } forEach _y;
            } forEach _openWounds;
        };
    }, 8, [_unit]] call CBA_fnc_addPerFrameHandler;
};
