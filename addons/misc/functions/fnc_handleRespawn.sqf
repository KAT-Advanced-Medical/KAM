#include "script_component.hpp"
/*
 * Author: YetheSamartaka
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
TRACE_2("handleRespawn",_unit,_dead);

if (!local _unit) exitWith {};

// KAT Airway

_unit setVariable ["kat_airway_obstruction", false, true]; // predelat aby to bylo vic citelné
_unit setVariable ["kat_airway_airway", false, true];
_unit setVariable ["kat_airway_overstretch", false, true];
_unit setVariable ["kat_airway_startTime", 0, true];
_unit setVariable ['kat_AEDinUse', false, true];
KAT_forceWakeup = false;
_unit setVariable [QEGVAR(airway,recovery), false, true];

// KAT Breathing

_unit setVariable ["KAT_medical_airwayStatus", 100, true];
_unit setVariable ["KAT_medical_airwayOccluded", false, true];
_unit setVariable ["KAT_medical_pneumothorax", false, true];
_unit setVariable ["KAT_medical_hemopneumothorax", false, true];
_unit setVariable ["KAT_medical_tensionpneumothorax", false, true];
_unit setVariable ["KAT_medical_activeChestSeal", false, true];

_unit setVariable ["kat_breathing_pulseoximeter", false, true];
_unit setVariable ["kat_PulseoxiInUse_PFH", nil];
_unit setVariable ["kat_breathing_o2", false, true];
_unit setVariable ["KAT_circulation_X", false, true];

// KAT Circulation

_unit setVariable ["KAT_circulation_IV_counts", 0, true];
_unit setVariable ["KAT_circulation_X", false, true];
_unit setVariable ["kat_AEDXPatient_PFH", nil];
_unit setVariable ["KAT_circulation_X_sound1", "x\kat\addons\circulation\sounds\noheartrate.wav", true];
_unit setVariable ["KAT_circulation_X_sound2", "x\kat\addons\circulation\sounds\heartrate.wav", true];
_unit setVariable ["KAT_circulation_use", false, true];
_unit setVariable ["KAT_circulation_returnedAED", false, true];
_unit setVariable ["KAT_circulation_asystole", 1, true];
_unit setVariable ["KAT_circulation_CPRcount", 2, true];

// KAT Pharmacy

_unit setVariable ["kat_pharma_alphaAction", 1, true];
_unit setVariable ["kat_pharma_IV", [0,0,0,0,0,0], true];
_unit setVariable ["kat_pharma_IVpfh", [0,0,0,0,0,0], true];
_unit setVariable ["kat_pharma_active", false, true];
_unit setVariable ["kat_pharma_PFH", nil, true];
_unit setVariable ["kat_pharma_alphaAction", 1];
_unit setVariable ["kat_pharma_sedated", false, true];

_unit setVariable ["kat_pharma_TXA", 1, true];
_unit setVariable ["kat_pharma_ondUse", false, true];

_unit setVariable ["kat_pharma_pH", 1500, true];
_unit setVariable ["kat_pharma_kidneyFail", false, true];
_unit setVariable ["kat_pharma_kidneyArrest", false, true];
_unit setVariable ["kat_pharma_kidneyPressure", false, true];

//KAT Surgery

_unit setVariable ["kat_surgery_debridement", [0,0,0,0,0,0], true];
_unit setVariable ["kat_surgery_fractures", [0,0,0,0,0,0], true];
_unit setVariable ["kat_surgery_lidocaine", false, true];
_unit setVariable ["kat_surgery_etomidate", false, true];


// Part of KAT Airway: This is a temp workaround till the adjustSPO2 part is rewritten
_unit spawn {
    _unit = param [0,objNull,[objNull]];
    sleep 2;
    if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};
    _unit setVariable [QGVAR(airway_item), "", true];
};

if ((isPlayer _unit) || (EGVAR(pharma,aiEnableAdvanced))) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _alive = alive _unit;

        if (!_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _medicationArray = _unit getVariable ["ace_medical_medications", []];
        private _action = false;

        {
            _x params ["_medication"];

            if (_medication in ["Epinephrine", "Phenylephrine", "Nitroglycerin", "Lidocaine", "Norepinephrine"]) exitWith {
                _action = true;
           };
        } forEach (_medicationArray);

        if !(_action) then {
            _unit setVariable [QEGVAR(pharma,alphaAction), 1];
        };
    }, 180, [_unit]] call CBA_fnc_addPerFrameHandler;

    if (EGVAR(pharma,kidneyAction)) then {
        [{
            params ["_args", "_idPFH"];
            _args params ["_unit"];

            private _alive = alive _unit;

            if (!_alive) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            private _ph = _unit getVariable [QEGVAR(pharma,pH), 1500];
            if (_ph == 1500) exitWith {};

            private _kidneyFail = _unit getVariable [QEGVAR(pharma,kidneyFail), false];
            private _kidneyArrest = _unit getVariable [QEGVAR(pharma,kidneyArrest), false];
            private _kidneyPressure = _unit getVariable [QEGVAR(pharma,kidneyPressure), false];

            if (_ph <= 0) exitWith {
                _unit setVariable [QEGVAR(pharma,kidneyFail), true, true];

                if !(_kidneyArrest) then {
                    private _random = random 1;

                    if (_random >= 0.5) then {
                        ["ace_medical_FatalVitals", _unit] call CBA_fnc_localEvent;
                        _unit setVariable [QEGVAR(pharma,kidneyArrest), true, true];
                    };
                };
            };

            if (_ph < 750) exitWith {
                _ph = (_ph + 25) min 1500;
                _unit setVariable [QEGVAR(pharma,pH), _ph, true];

                if !(_kidneyPressure) then {
                    _unit setVariable [QEGVAR(pharma,kidneyPressure), true, true];
                    [_unit, "KIDNEY", 15, 1200, 30, 0, 15] call ace_medical_status_fnc_addMedicationAdjustment;
                };
            };

            _ph = (_ph + 50) min 1500;
            _unit setVariable [QEGVAR(pharma,pH), _ph, true];
        }, 20, [_unit]] call CBA_fnc_addPerFrameHandler;
    };

    if (EGVAR(pharma,coagulation)) then {
        [{
            params ["_args", "_idPFH"];
            _args params ["_unit"];

            private _alive = alive _unit;

            if !(_alive) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, []];
            private _pulse = _unit getVariable [VAR_HEART_RATE, 80];
            private _coagulationFactor = _unit getVariable [QEGVAR(pharma,coagulationFactor), 10];

            if (_openWounds isEqualTo []) exitWith {};
            if (_pulse < 20) exitWith {};
            if (_coagulationFactor == 0) exitWith {};

            private _count = [_unit, "TXA"] call ace_medical_status_fnc_getMedicationCount;

            if (_count == 0) exitWith {
                {
                    _x params ["", "_bodyPart", "_amount", "_bleeding"];

                    if (_amount * _bleeding > 0) exitWith {
                        private _part = ALL_BODY_PARTS select _bodyPart;
                        ["ace_medical_treatment_bandageLocal", [_unit, _part, "UnstableClot"], _unit] call CBA_fnc_targetEvent;
                        _unit setVariable [QEGVAR(pharma,coagulationFactor), (_coagulationFactor - 1), true];
                    };
                } forEach _openWounds;
            };

            if (_count > 0) exitWith {
                {
                    _x params ["", "_bodyPart", "_amount", "_bleeding"];

                    if (_amount * _bleeding > 0) exitWith {
                        private _part = ALL_BODY_PARTS select _bodyPart;
                        ["ace_medical_treatment_bandageLocal", [_unit, _part, "PackingBandage"], _unit] call CBA_fnc_targetEvent;
                        _unit setVariable [QEGVAR(pharma,coagulationFactor), (_coagulationFactor - 1), true];
                    };
                } forEach _openWounds;
            };
        }, 8, [_unit]] call CBA_fnc_addPerFrameHandler;
    };
};