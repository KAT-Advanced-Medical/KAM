#include "script_component.hpp"

#define CBA_SETTINGS_CAT LSTRING(cba_name)

//Events
["ace_glassesChanged", LINKFUNC(breathing)] call CBA_fnc_addEventHandler;
[QGVAR(poison), LINKFUNC(poison)] call CBA_fnc_addEventHandler;
[QGVAR(handleGasMaskDur), LINKFUNC(handleGasMaskDur)] call CBA_fnc_addEventHandler;
[QGVAR(addSealAction), LINKFUNC(createSealAction)] call CBA_fnc_addEventHandler;

[QGVAR(playTone), {
    params ["_unit", "_tone"];
    _unit say3D [_tone, 5];
}] call CBA_fnc_addEventHandler;

// ACE Events
[QACEGVAR(medical_gui,updateInjuryListGeneral), LINKFUNC(gui_updateInjuryListGeneral)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;

// Handlers
[QEGVAR(pharma,atropineLocal), LINKFUNC(treatmentAdvanced_AtropineLocal)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;

//Mortar Events
["Mortar_01_base_F", "fired", {call FUNC(handleFired)}] call CBA_fnc_addClassEventHandler;
KAT_ProjectileCache = ("([_x, 'KAT_projectile', 0] call BIS_fnc_returnConfigEntry) != 0" configClasses (configFile >> "cfgAmmo")) apply {configName _x};

//Grenade Events
["ace_firedPlayer", LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;
["ace_firedPlayerNonLocal", LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;
["ace_firedNonPlayer", LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;

private _items = missionNamespace getVariable [QGVAR(availGasmask), "'G_AirPurifyingRespirator_01_F'"];
private _array = [_items, "CfgGlasses"] call FUNC(getList);
missionNamespace setVariable [QGVAR(availGasmaskList), _array, true];

[CBA_SETTINGS_CAT, QGVAR(showChemDetector), "Show Chemical Detector", {
    // Conditions: canInteract
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_ChemicalDetector' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(ChemDetectorActive),false)) then {
        [ACE_player] call FUNC(showChemDetector);
    } else {
        call FUNC(hideChemDetector);
    };

    true
}, { false }, [24, [false, false, false]], false] call CBA_fnc_addKeybind;

if (!isServer) exitWith {};

GVAR(gasSources) = createHashMap;

[QGVAR(addGasSource), {
    params [
        ["_source", objNull, [objNull, []]],
        ["_radius", 0, [0]],
        ["_gasLevel", 0, [0]],
        ["_key", ""],
        ["_condition", {true}, [{}]],
        ["_conditionArgs", []],
        ["_isSealable", false],
        ["_UseParticles", true],
        ["_UseCustomParticles", true]
    ];

    private _isObject = _source isEqualType objNull;

    // Check if the source is valid
    if !(_isObject || {_source isEqualTypeParams [0, 0, 0]}) exitWith {};

    if (_isObject && {isNull _source}) exitWith {};
    if (_radius == 0) exitWith {};
    if (_key isEqualTo "") exitWith {}; // key can be many types

    // hashValue supports more types than hashmaps do by default, but not all (e.g. locations)
    private _hashedKey = hashValue _key;

    if (isNil "_hashedKey") exitWith {
        ERROR_2("Unsupported key type used: %1 - %2",_key,typeName _key);
    };

    // If a position is passed, create a static object at said position
    private _sourcePos = if (_isObject) then {
        getPosATL _source
    } else {
        ASLToATL _source
    };

    private _gasLogic = createVehicle [QGVAR(logic), _sourcePos, [], 0, "CAN_COLLIDE"];

    // If an object was passed, attach logic to the object
    if (_isObject) then {
        _gasLogic attachTo [_source];
    };

    // To avoid issues, remove existing entries first before overwriting
    if (_hashedKey in GVAR(gasSources)) then {
        [QGVAR(removeGasSource), _key] call CBA_fnc_localEvent;
    };

    if (_isSealable) then {
        private _jipID = [QGVAR(addSealAction), [_source, _gasLogic, _key]] call CBA_fnc_globalEventJIP;
        [_jipID, _source] call CBA_fnc_removeGlobalEventJIP;
        _source setVariable [QGVAR(sealable), true, true];
    };

    if (_UseParticles) then{
        //Create all needed Particle effects
        private _particleObjectAmount = (_radius / 10) max 1;
        private _particleObjects = [];
        private _particleSource;

        for "_i" from 0 to _particleObjectAmount do {
            private _tier = _gasLevel;
            if (!_UseCustomParticles) then {
                _tier = "d";
            };
            _particleSource = "#particlesource" createVehicle _sourcePos;
            private _particleClassName = format ["kat_chemical_Toxic_Gas_Particles_%1", _tier];
            _particleSource setParticleClass _particleClassName;

            if (_i == 0) then {
                _particleSource setParticleCircle [1, [0,0,0]];
            } else {
                _particleSource setParticleCircle [_i * 10, [0,0,0]];
            };

            _particleObjects pushBack _particleSource;
        };

        _gasLogic setVariable [QGVAR(particleObjects), _particleObjects, true];
    };
    GVAR(gasSources) set [_hashedKey, [_gasLogic, _radius, _gasLevel, _condition, _conditionArgs, _UseParticles, _UseCustomParticles]];
}] call CBA_fnc_addEventHandler;

[QGVAR(applyBurnDamage), {
    params ["_unit", "_source"];
    private _masks = missionNamespace getVariable [QGVAR(availGasmaskList), []];
    private _suits = missionNamespace getVariable [QGVAR(availSuitsList), []];
    if(missionNamespace getVariable [QGVAR(enableDecontamination), false]) then {
        if(!((goggles _unit in _masks)&&{_unit getVariable [QGVAR(gasmask_durability), 10] > 0})) then {
            _unit setVariable [QGVAR(contaminatedHead), true, true];
        };
        if(!(uniform _unit in _suits)) then {
            _unit setVariable [QGVAR(contaminatedBody), true, true];
        };
        if(!(_unit getVariable [QGVAR(Contaminated), false])) then {
            _unit call FUNC(contaimatedEh);
        };
        
    }else{
    private _timebetween = missionNamespace getVariable [QGVAR(burnTime), 15];
    private _burnKey = format ["KAT_BurnStart_%1", _source];
    private _lastDamageKey = format ["KAT_BurnLastDamage_%1", _source];

    private _now = time;

    // save start time if dosent exists
    private _startTime = _unit getVariable [_burnKey, -1];
    if (_startTime == -1) then {
        _startTime = _now;
        _unit setVariable [_burnKey, _startTime];
    };

    // calculate time since start
    private _lastDamageTime = _unit getVariable [_lastDamageKey, -_timebetween]; // -_timebetween to ensure first damage is applied

    if ((_now - _lastDamageTime) >= _timebetween) then {
        _unit setVariable [_lastDamageKey, _now];

        // if dosent have mask on give damage on face
        private _masks = missionNamespace getVariable [QGVAR(availGasmaskList), []];
        if (!(goggles _unit in _masks)&&{_unit getVariable [QGVAR(gasmask_durability), 10] > 0}) then {
            if (random 1 < 0.5) then {
            [_unit, 0.2, "head", "chemburn"] call ace_medical_fnc_addDamageToUnit;
        };
        };

        //if dosent have suit on give damage on body
        private _suits = missionNamespace getVariable [QGVAR(availSuitsList), []];
        if !(uniform _unit in _suits) then {
            private _bodyParts = ["body", "leftarm", "rightarm", "leftleg", "rightleg"];
            private _randomPart = selectRandom _bodyParts;
            [_unit, 0.2, _randomPart, "chemburn"] call ace_medical_fnc_addDamageToUnit;
        };
    };
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(EHVX), {
    params ["_unit"];
    if(_unit getVariable [QGVAR(VXPoisoned), false]) exitWith {};
    _unit call FUNC(handleVX);
}] call CBA_fnc_addEventHandler;


_inventoryEH = [
    "loadout", {
    params ["_player"];
    _player call FUNC(maskOverlay);
    }
] call CBA_fnc_addPlayerEventHandler;

_airsupplylist = missionNamespace getVariable [QGVAR(availAirSupplyList), []];
{
    [_x, "initPost",{
    (_this select 0) call FUNC(airSupply);
    }, false, [], true]call CBA_fnc_addClassEventHandler;
    
} forEach _airsupplylist;

[QGVAR(removeGasSource), {
    params ["_key"];
    private _hashedKey = hashValue _key;

    if (isNil "_hashedKey") exitWith {
        ERROR_2("Unsupported key type used: %1 - %2",_key,typeName _key);
    };

    (GVAR(gasSources) deleteAt _hashedKey) params [["_gasLogic", objNull]];

    // Delete all particle objects for this zone, if there are some
    private _particleObjects = _gasLogic getVariable [QGVAR(particleObjects), []];
    {
        deleteVehicle _x;
    } forEach _particleObjects;

    detach _gasLogic;
    deleteVehicle _gasLogic;
}] call CBA_fnc_addEventHandler;

[LINKFUNC(gasManagerPFH), GAS_MANAGER_PFH_DELAY, []] call CBA_fnc_addPerFrameHandler;

