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
_unit setVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,IVpfh), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,active), false, true];
_unit setVariable [QEGVAR(pharma,IVPharma_PFH), nil, true];


_unit setVariable [QEGVAR(pharma,pH), 1500, true];
_unit setVariable [QEGVAR(pharma,kidneyFail), false, true];
_unit setVariable [QEGVAR(pharma,kidneyArrest), false, true];
_unit setVariable [QEGVAR(pharma,kidneyPressure), false, true];
_unit setVariable [QEGVAR(pharma,coagulationFactor), missionNamespace getVariable [QEGVAR(pharma,coagulation_factor_count), 15], true];

//KAT Surgery

_unit setVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,lidocaine), false, true];
_unit setVariable [QEGVAR(surgery,etomidate), false, true];
_unit setVariable [QEGVAR(surgery,sedated), false, true];

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

// Coagulation PFH

if (EGVAR(pharma,coagulation)) then {

    private _fnc_clotWound = {
        params ["_unit", "_bodyPart", "_wounds", "_countTXA", "_countEACA"];

        {   
            _x params ["_woundClassID", "_amountOf", "_bleeding", "_damage"];

            private _category = _woundClassID % 10;
            private _suffix = ["Minor", "Medium", "Large"] select _category;
            private _selectionName = localize format [LSTRING(%1), _bodyPart];
            private _logString = LSTRING(coagulation_Bandaged);
            private _woundClotTime = 0;
            private _bandageToUse = "";
            private _coagulation_time_minor = missionNamespace getVariable [QEGVAR(pharma,coagulation_time_minor), 15];
            private _coagulation_time_medium = missionNamespace getVariable [QEGVAR(pharma,coagulation_time_medium), 30];
            private _coagulation_time_large = missionNamespace getVariable [QEGVAR(pharma,coagulation_time_large), 45];
            private _factorCountToRemove = 1;

            switch (_suffix) do {
                case "Minor": { 
                    _woundClotTime = round ((random (_coagulation_time_minor / 2)) + _coagulation_time_minor / 2);
                    _bandageToUse = "BloodClotMinor";
                    _factorCountToRemove = 1;

                    if !(missionNamespace getVariable [QEGVAR(pharma,coagulation_allow_MinorWounds), true]) then { continue; };
                };
                case "Medium": { 
                    _woundClotTime = round ((random (_coagulation_time_medium / 2)) + _coagulation_time_medium / 2);
                    _bandageToUse = "BloodClotMedium";
                    _factorCountToRemove = 1.5;

                    if !(missionNamespace getVariable [QEGVAR(pharma,coagulation_allow_MediumWounds), true]) then { continue; };
                };
                default { 
                    _woundClotTime = round ((random (_coagulation_time_large / 2)) + _coagulation_time_large / 2);
                    _bandageToUse = "BloodClotLarge";
                    _factorCountToRemove = 2;

                    if !(missionNamespace getVariable [QEGVAR(pharma,coagulation_allow_LargeWounds), true]) then { continue; };
                };
            };

            if (_amountOf * _bleeding > 0) exitWith {

                if (_countTXA > 0 || _countEACA > 0) then {
                    _logString = LSTRING(coagulation_Bandaged_TXA);

                    if (_countEACA > 0 && _countTXA > 0) exitWith { // If TXA & EACA are in system at same time use EACA bandage
                        _woundClotTime = round (_woundClotTime / 3 * 2);
                        _bandageToUse = _bandageToUse + "EACA";
                    };

                    _bandageToUse = _bandageToUse + "TXA";
                };

                [{
                    params["_unit", "_bodyPart", "_selectionName", "_bandageToUse", "_logString", "_factorCountToRemove"];

                    private _coagulationFactor = _unit getVariable [QEGVAR(pharma,coagulationFactor), 15];
                    private _openWounds = GET_OPEN_WOUNDS(_unit);
                    private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];
                    private _woundIndex = _openWoundsOnPart findIf {(_x select 1) > 0 && (_x select 2) > 0};

                    if (_coagulationFactor <= 0) exitWith {};
                    if (_woundIndex == -1) exitWith {};
                    if ([_unit, _bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo) && missionNamespace getVariable [QEGVAR(pharma,coagulation_tourniquetBlock), true]) exitWith {};
                    
                    _unit setVariable [QEGVAR(pharma,coagulationFactor), (_coagulationFactor - _factorCountToRemove), true];
                    [QACEGVAR(medical_treatment,bandageLocal), [_unit, _bodyPart, _bandageToUse], _unit] call CBA_fnc_targetEvent;
                    if (GVAR(coagulation_allow_clot_text)) then {
                        [_unit, "activity", _logString, [(toLower _selectionName)]] call ACEFUNC(medical_treatment,addToLog);
                    };
                },
                [_unit, _bodyPart, _selectionName, _bandageToUse, _logString, _factorCountToRemove], _woundClotTime] call CBA_fnc_waitAndExecute;
            };
        } forEach _wounds;
    };

    [{
        params ["_args", "_idPFH"];
        _args params ["_unit", "_fnc_clotWound"];

        private _alive = alive _unit;

        if !(_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (!(EGVAR(pharma,coagulation_allowOnAI)) && ACE_Player != _unit) exitWith { // Check allowOnAI setting to save performance
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, []];
        private _pulse = _unit getVariable [VAR_HEART_RATE, 80];
        private _coagulationFactor = _unit getVariable [QEGVAR(pharma,coagulationFactor), 15];
        private _countTXA = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);
        private _countEACA = [_unit, "EACA"] call ACEFUNC(medical_status,getMedicationCount);
        private _hasWoundToBandageArray = [];

        if (_openWounds isEqualTo []) exitWith {}; // Exit when hashmap not initialized (Will not work when hashmap is set, cause ace only changes value of "woundCount" to 0)
        if (_coagulationFactor <= 0) exitWith {}; // Exit when no coagFactors left
        if (_unit getVariable [QACEGVAR(medical,bloodVolume), 6.0] < EGVAR(pharma,coagulation_requireBV)) exitWith {}; // Blood volume check
        if ((_pulse < 20) && EGVAR(pharma,coagulation_requireHR)) exitWith {}; // Has pulse & require setting

        private _shuffledKeys = keys _openWounds call BIS_fnc_arrayShuffle; // Shuffel Keys to switch bodypart after each bandage for on_all_Bodyparts setting
        
        {
            if ([_unit, _x] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo) && missionNamespace getVariable [QEGVAR(pharma,coagulation_tourniquetBlock), true]) then { // Check for tourniqet
                continue;
            };

            {
                _x params ["_woundClassID", "_amountOf", "_bleeding", "_damage"];

                private _category = _woundClassID % 10;
                private _suffix = ["Minor", "Medium", "Large"] select _category;

                switch (_suffix) do {
                    case "Minor": { 
                        if (missionNamespace getVariable [QEGVAR(pharma,coagulation_allow_MinorWounds), true] && _amountOf * _bleeding > 0) then { 
                            _hasWoundToBandageArray pushBack true;
                        };
                    };
                    case "Medium": { 
                        if (missionNamespace getVariable [QEGVAR(pharma,coagulation_allow_MediumWounds), true] && _amountOf * _bleeding > 0) then { 
                            _hasWoundToBandageArray pushBack true;
                        };
                    };
                    default { 
                        if (missionNamespace getVariable [QEGVAR(pharma,coagulation_allow_LargeWounds), true] && _amountOf * _bleeding > 0) then { 
                            _hasWoundToBandageArray pushBack true;
                        };
                    };
                };
            } forEach (_openWounds get _x); // Sets array that specifies if there is a open wound that coag can bandage in body part (here for performance so that the fnc does not get called every time)

            if (!(EGVAR(pharma,coagulation_on_all_Bodyparts)) && true in _hasWoundToBandageArray) exitWith { // Check if coag should be present on all body party simultaneously, if not use this exitWith to block next interiation of forEach
                [_unit, _x, _openWounds get _x, _countTXA, _countEACA] call _fnc_clotWound;
            };
            
            if (true in _hasWoundToBandageArray) then { // Check if there is a wound to bandage for coag, if not loop through next interiation of forEach
                [_unit, _x, _openWounds get _x, _countTXA, _countEACA] call _fnc_clotWound;
            };
        } forEach _shuffledKeys;
    }, missionNamespace getVariable [QEGVAR(pharma,coagulation_time), 5], [_unit, _fnc_clotWound]] call CBA_fnc_addPerFrameHandler;

    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _alive = alive _unit;

        if !(_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (!(EGVAR(pharma,coagulation_allowOnAI)) && ACE_Player != _unit) exitWith { // Check allowOnAI setting to save performance
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (_unit getVariable [QACEGVAR(medical,bloodVolume), 6.0] < EGVAR(pharma,coagulation_requireBV)) exitWith {}; // Blood volume check
        if ((_pulse < 20) && EGVAR(pharma,coagulation_requireHR)) exitWith {}; // Has pulse & require setting

        private _currentCoagFactors = _unit getVariable [QEGVAR(pharma,coagulationFactor), 15];
        private _savedCoagFactors = _unit getVariable [QEGVAR(pharma,coagulationSavedFactors), (_unit getVariable [QEGVAR(pharma,coagulationFactor), 15])];
        private _limitRegenCoagFactors = missionNamespace getVariable [QEGVAR(pharma,coagulation_factor_count), 15];
        private _cooldownON = _unit getVariable [QEGVAR(pharma,coagulationRegenCooldown), false];
        private _countTXA = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);
        private _countEACA = [_unit, "EACA"] call ACEFUNC(medical_status,getMedicationCount);
        private _ammountToAdd = 1;

        if (_currentCoagFactors < _savedCoagFactors) exitWith {
            [{
                params["_unit"];
                _unit setVariable [QEGVAR(pharma,coagulationSavedFactors), _unit getVariable [QEGVAR(pharma,coagulationFactor), 15], true];
            },
            [_unit], ((missionNamespace getVariable [QEGVAR(pharma,coagulation_factor_regenerate_time), 150]) / 2)] call CBA_fnc_waitAndExecute; // Block regen PFH instance from happening
        };
        
        if (_currentCoagFactors == _savedCoagFactors && _currentCoagFactors < _limitRegenCoagFactors) exitWith {
            
            if (_countTXA > 0 || _countEACA > 0) then { // If TXA or EACA are in system add more factors
                if (_countTXA > 0 && _countEACA > 0) exitWith {
                    _ammountToAdd = 4;
                };
                _ammountToAdd = 2;
            };

            _unit setVariable [QEGVAR(pharma,coagulationFactor), (_currentCoagFactors + _ammountToAdd), true];
            _unit setVariable [QEGVAR(pharma,coagulationSavedFactors), (_currentCoagFactors + _ammountToAdd), true];
        };

        if (_currentCoagFactors > _limitRegenCoagFactors && !(_cooldownON)) exitWith {
            
            if (_countTXA > 0 || _countEACA > 0) exitWith {}; // If TXA or EACA is in system don't remove factor
            
            _unit setVariable [QEGVAR(pharma,coagulationFactor), (_currentCoagFactors - 1), true];
            _unit setVariable [QEGVAR(pharma,coagulationSavedFactors), (_currentCoagFactors - 1), true];
            _unit setVariable [QEGVAR(pharma,coagulationRegenCooldown), true, true];

            [{
                params["_unit"];
                _unit setVariable [QEGVAR(pharma,coagulationRegenCooldown), false, true];
            },
            [_unit], missionNamespace getVariable [QEGVAR(pharma,coagulation_factor_regenerate_time), 150]] call CBA_fnc_waitAndExecute;
        };

        _unit setVariable [QEGVAR(pharma,coagulationSavedFactors), _currentCoagFactors, true];

    }, missionNamespace getVariable [QEGVAR(pharma,coagulation_factor_regenerate_time), 150], [_unit]] call CBA_fnc_addPerFrameHandler;
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
