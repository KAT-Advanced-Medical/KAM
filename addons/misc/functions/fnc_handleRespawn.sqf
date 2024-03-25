#include "..\script_component.hpp"
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
_unit setVariable [QEGVAR(airway,wasOccluded), false];
KAT_forceWakeup = false;
_unit setVariable [QEGVAR(airway,recovery), false, true];
_unit setVariable [QEGVAR(airway,airway_item), "", true];
_unit setVariable [QEGVAR(airway,clearedTime), 0, true];

// KAT Breathing

_unit setVariable [QEGVAR(breathing,airwayStatus), 100, true];
_unit setVariable [QEGVAR(breathing,pneumothorax), 0, true];
_unit setVariable [QEGVAR(breathing,hemopneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,tensionpneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,activeChestSeal), false, true];
_unit setVariable [QEGVAR(breathing,deepPenetratingInjury), false, true];
_unit setVariable [QEGVAR(breathing,PneumoBreathCooldownOn), false, true];

_unit setVariable [QEGVAR(breathing,BVMInUse), false, true];
_unit setVariable [QEGVAR(breathing,oxygenTankConnected), false, true];
_unit setVariable [QEGVAR(breathing,oxygenTankPreferred), "", true];

_unit setVariable [QEGVAR(breathing,pulseoximeter), false, true];
_unit setVariable [QEGVAR(breathing,PulseOximeter_Volume), false, true];
_unit setVariable [QEGVAR(breathing,PulseOximeter_VolumePatient), false, true];
_unit setVariable [QEGVAR(breathing,PulseOximeter_Attached), [0,0], true];

_unit setVariable ["kat_PulseoxiInUse_PFH", nil, true];
_unit setVariable ["kat_O2Breathing_PFH", nil, true];

_unit setVariable [QEGVAR(breathing,usingStethoscope), nil];

// KAT Circulation

_unit setVariable ["kat_AEDXPatient_PFH", nil, true];
_unit setVariable ["kat_AEDXPatient_HR_PFH", nil, true];
_unit setVariable ["kat_AEDXPatient_PulseOx_PFH", nil, true];
_unit setVariable [QEGVAR(circulation,Defibrillator_Charged), false, true];
_unit setVariable [QEGVAR(circulation,DefibrillatorPads_Connected), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_MedicVitalsMonitor_Connected), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_MedicVitalsMonitor_Patient), nil, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Connected), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Provider), nil, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Volume), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_VolumePatient), false, true];
_unit setVariable [QEGVAR(circulation,Defibrillator_Provider), nil, true];
_unit setVariable [QEGVAR(circulation,Defibrillator_ShockAmount), 0, true];
_unit setVariable [QEGVAR(circulation,DefibrillatorInUse), false, true];
_unit setVariable [QEGVAR(circulation,MedicDefibrillatorInUse), false, true];
_unit setVariable [QEGVAR(circulation,MedicDefibrillator_Patient), nil, true];
_unit setVariable [QEGVAR(circulation,cardiacArrestType), 0, true];
_unit setVariable [QEGVAR(circulation,heartRestart), false, true];
_unit setVariable [QEGVAR(circulation,cprCount), 2, true];
_unit setVariable [QEGVAR(circulation,bloodtype), [_unit, _dead, true] call EFUNC(circulation,generateBloodType), true];
_unit setVariable [QEGVAR(circulation,internalBleeding), 0, true];
_unit setVariable [QEGVAR(circulation,StoredBloodPressure), [0,0], true];

_unit setVariable [VAR_BLOODPRESSURE_CHANGE, nil, true];

_unit setVariable [QEGVAR(circulation,isPerformingCPR), false, true];
_unit setVariable [QEGVAR(circulation,OxygenationPeriod), 0, true];

// KAT Misc
_unit setVariable [QEGVAR(misc,isLeftArmFree), true, true];
_unit setVariable [QEGVAR(misc,isRightArmFree), true, true];
_unit setVariable [QEGVAR(misc,isLeftLegFree), true, true];
_unit setVariable [QEGVAR(misc,isRightLegFree), true, true];

_unit setVariable [QGVAR(Tourniquet_ArmNecrosis), 0];
_unit setVariable [QGVAR(Tourniquet_LegNecrosis), 0];
_unit setVariable [QGVAR(Tourniquet_PFH), -1];
_unit setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0, true];

// KAT Pharmacy

_unit setVariable [QEGVAR(pharma,alphaAction), 1, true];
_unit setVariable [QEGVAR(pharma,opioidFactor), 1, true];
_unit setVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,IVpfh), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,active), false, true];
_unit setVariable [QEGVAR(pharma,IVPharma_PFH), nil, true];


_unit setVariable [QEGVAR(pharma,pH), 1500, true];
_unit setVariable [QEGVAR(pharma,kidneyFail), false, true];
_unit setVariable [QEGVAR(pharma,kidneyArrest), false, true];
_unit setVariable [QEGVAR(pharma,kidneyPressure), false, true];

//KAT Surgery

_unit setVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,lidocaine), false, true];
_unit setVariable [QEGVAR(surgery,etomidate), false, true];
_unit setVariable [QEGVAR(surgery,sedated), false, true];
_unit setVariable [QEGVAR(surgery,imaging), false, true];
_unit setVariable [QEGVAR(surgery,reboa), false, true];
_unit setVariable [QEGVAR(surgery,surgicalBlock), [0,0,0,0,0,0], true];

//KAT Chemical

_unit setVariable [QEGVAR(chemical,enteredPoison), false, true];
_unit setVariable [QEGVAR(chemical,timeleft), missionNamespace getVariable [QEGVAR(chemical,infectionTime),60], true];
_unit setVariable [QEGVAR(chemical,poisonType), "", true];
_unit setVariable [QEGVAR(chemical,airPoisoning), false, true];
_unit setVariable [QEGVAR(chemical,CS), false, true];
_unit setVariable [QEGVAR(chemical,gasmask_durability), 10, true];

"kat_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
private _obj = _ui displayCtrl 101;
_obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
if (_unit getVariable [QEGVAR(chemical,painEffect),0] != 0) then {
    KAT_PAIN_EFFECT ppEffectEnable false;
};

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
        _unit setVariable [QEGVAR(pharma,alphaAction), 1];
    };

    if !(_opioid) then {
        _unit setVariable [QEGVAR(pharma,opioidFactor), 1];
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
    ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    ["kat_PDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    ["kat_EDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    // ACEGVAR(advanced_fatigue,swayFactor) = EGVAR(pharma,originalSwayFactor); // TODO REWORK OR REMOVE
} else {
    _unit setAnimSpeedCoef 1;
    _unit setCustomAimCoef 1;

    if (GVAR(staminaMedication)) then {
        _unit enableStamina true;

    };
};

/// Clear chroma effect & camera shake

resetCamShake;
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
    [
        {
            params["_handle"];
            ppEffectCommitted _handle
        },
        {
            params["_handle"];
            _handle ppEffectEnable false;
            ppEffectDestroy _handle;
        },
    [_handle]] call CBA_fnc_waitUntilAndExecute;
};

// Reenable ace fatige animationspeed override

if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
    _index = ACEGVAR(advanced_fatigue,setAnimExclusions) find "PervitinOverride";
    if (_index != -1) then {
        ACEGVAR(advanced_fatigue,setAnimExclusions) deleteAt _index;
    };
};