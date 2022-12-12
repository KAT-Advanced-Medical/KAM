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

_unit setVariable [QEGVAR(airway,obstruction), false, true];
_unit setVariable [QEGVAR(airway,airway), false, true];
_unit setVariable [QEGVAR(airway,occluded), false, true];
_unit setVariable [QEGVAR(airway,overstretch), false, true];
KAT_forceWakeup = false;
_unit setVariable [QEGVAR(airway,recovery), false, true];

// KAT Breathing

_unit setVariable [QEGVAR(breathing,airwayStatus), 100, true];
_unit setVariable [QEGVAR(breathing,pneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,hemopneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,tensionpneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,activeChestSeal), false, true];

_unit setVariable ["kat_breathing_pulseoximeter", false, true];
_unit setVariable ["kat_PulseoxiInUse_PFH", nil];

// KAT Circulation

_unit setVariable [QEGVAR(circulation,X), false, true];
_unit setVariable ["kat_AEDXPatient_PFH", nil];
_unit setVariable [QEGVAR(circulation,X_sound1), "x\kat\addons\circulation\sounds\noheartrate.wav", true];
_unit setVariable [QEGVAR(circulation,X_sound2), "x\kat\addons\circulation\sounds\heartrate.wav", true];
_unit setVariable [QEGVAR(circulation,use), false, true];
_unit setVariable [QEGVAR(circulation,returnedAED), false, true];
_unit setVariable [QEGVAR(circulation,asystole), 1, true];
_unit setVariable [QEGVAR(circulation,CPRcount), 2, true];
_unit setVariable [QEGVAR(circulation,AEDinUse), false, true];

// KAT Pharmacy

_unit setVariable [QEGVAR(pharma,alphaAction), 1, true];
_unit setVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,IVpfh), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,active), false, true];
_unit setVariable [QEGVAR(pharma,IVPharma_PFH), nil, true];


_unit setVariable [QEGVAR(pharma,pH), 1500, true];
_unit setVariable [QEGVAR(pharma,kidneyFail), false, true];
_unit setVariable [QEGVAR(pharma,kidneyArrest), false, true];
_unit setVariable [QEGVAR(pharma,kidneyPressure), false, true];
//KAT Surgery

_unit setVariable [QEGVAR(surgery,debridement), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,lidocaine), false, true];
_unit setVariable [QEGVAR(surgery,etomidate), false, true];
_unit setVariable [QEGVAR(surgery,sedated), false, true];


// Part of KAT Airway: This is a temp workaround till the adjustSPO2 part is rewritten
_unit spawn {
    _unit = param [0,objNull,[objNull]];
    sleep 2;
    if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};
    _unit setVariable [QGVAR(airway_item), "", true];
};

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
                    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                    _unit setVariable [QEGVAR(pharma,kidneyArrest), true, true];
                };
            };
        };

        if (_ph < 750) exitWith {
            _ph = (_ph + 25) min 1500;
            _unit setVariable [QEGVAR(pharma,pH), _ph, true];

            if !(_kidneyPressure) then {
                _unit setVariable [QEGVAR(pharma,kidneyPressure), true, true];
                [_unit, "KIDNEY", 15, 1200, 30, 0, 15] call ACEFUNC(medical_status,addMedicationAdjustment);
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

        private _count = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);

        if (_count == 0) exitWith {
            {
                _x params ["", "_bodyPart", "_amount", "_bleeding"];

                if (_amount * _bleeding > 0) exitWith {
                    private _part = ALL_BODY_PARTS select _bodyPart;
                    [QACEGVAR(medical_treatment,bandageLocal), [_unit, _part, "UnstableClot"], _unit] call CBA_fnc_targetEvent;
                    _unit setVariable [QEGVAR(pharma,coagulationFactor), (_coagulationFactor - 1), true];
                };
            } forEach _openWounds;
        };

        if (_count > 0) exitWith {
            {
                _x params ["", "_bodyPart", "_amount", "_bleeding"];

                if (_amount * _bleeding > 0) exitWith {
                    private _part = ALL_BODY_PARTS select _bodyPart;
                    [QACEGVAR(medical_treatment,bandageLocal), [_unit, _part, "PackingBandage"], _unit] call CBA_fnc_targetEvent;
                    _unit setVariable [QEGVAR(pharma,coagulationFactor), (_coagulationFactor - 1), true];
                };
            } forEach _openWounds;
        };
    }, 8, [_unit]] call CBA_fnc_addPerFrameHandler;
};

/// Clear Stamina & weapon sway
if (ACEGVAR(advanced_fatigue,enabled)) then {
    
    ["PDF"] call ace_advanced_fatigue_fnc_removeDutyFactor;
	["EDF"] call ace_advanced_fatigue_fnc_removeDutyFactor;
    ace_advanced_fatigue_swayFactor = GVAR(originalSwayFactor);

} else {

    params ["_patient"];

    _patient enableStamina true;
	_patient setAnimSpeedCoef 1;
    _patient setCustomAimCoef 1;

};

/// Clear chroma effect

["ChromAberration", 200, [ 0, 0, true ]] spawn
{
    params["_name", "_priority", "_effect", "_handle"];
    while
    {
        _handle = ppEffectCreate[_name, _priority];
        _handle < 0
    }
    do
    {
        _priority = _priority + 1;
    };
    _handle ppEffectEnable true;
    _handle ppEffectAdjust _effect;
    _handle ppEffectCommit 0;
    addCamShake[0, 0, 50];
    waitUntil{ppEffectCommitted _handle};
    _handle ppEffectEnable false;
    ppEffectDestroy _handle;
};

/// Terminate script
