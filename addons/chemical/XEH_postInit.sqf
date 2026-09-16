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
[QEGVAR(pharma,atnaaLocal),    LINKFUNC(treatmentAdvanced_AtnaaLocal)]    call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn),   LINKFUNC(handleRespawn)]                   call CBA_fnc_addEventHandler;

// Delayed-effect dispatcher (fires on the unit's owner via target event)
[QGVAR(applyDelayedEffect), LINKFUNC(applyDelayedEffect)] call CBA_fnc_addEventHandler;

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

// Client-side particle tracking (all machines)
GVAR(clientParticles) = createHashMap;

// Maps gas-id → [carpetClass, wispsClass]. Built lazily on first use to allow
// missions / mods to extend the registry before the first cloud spawns.
GVAR(particleClassByGasId) = createHashMapFromArray [
    ["chlorine", [QGVAR(Toxic_Gas_Particles),    QGVAR(Toxic_Gas_Wisps)]],
    ["phosgene", [QGVAR(Phosgene_Gas_Particles), QGVAR(Phosgene_Gas_Wisps)]],
    ["mustard",  [QGVAR(Mustard_Gas_Particles),  QGVAR(Mustard_Gas_Wisps)]],
    ["sarin",    [QGVAR(Sarin_Gas_Particles),    QGVAR(Sarin_Gas_Wisps)]],
    ["vx",       [QGVAR(VX_Gas_Particles),       QGVAR(VX_Gas_Wisps)]]
];

[QGVAR(createZoneParticles), {
    params ["_gasLogic", "_radius", ["_gasLevel", 1]];
    if (isNull _gasLogic) exitWith {};  // zone removed before JIP fired
    private _netId = netId _gasLogic;
    if (_netId in GVAR(clientParticles)) exitWith {};  // idempotency guard

    private _gasId = (GVAR(toxicLvLToId) getOrDefault [_gasLevel, "chlorine"]);
    private _classes = (GVAR(particleClassByGasId) getOrDefault [_gasId, [QGVAR(Toxic_Gas_Particles), QGVAR(Toxic_Gas_Wisps)]]);
    _classes params ["_carpetClass", "_wispsClass"];

    private _sourcePos = getPosATL _gasLogic;
    private _particleObjects = [];

    // Layer 1: Ground carpet — bulk mass, area-fill via setParticleRandom
    private _carpet = "#particlesource" createVehicleLocal _sourcePos;
    _carpet setParticleClass _carpetClass;
    _carpet setParticleCircle [0, [0, 0, 0]];
    _carpet setParticleRandom [
        2,
        [_radius, _radius, 0.3],
        [0.3, 0.3, 0.05],
        1, 0.3, [0.03, 0.03, 0.03, 0.1], 0, 0, 360
    ];
    _carpet setDropInterval 0.0035;
    _carpet attachTo [_gasLogic, [0, 0, 0]];
    _particleObjects pushBack _carpet;

    // Layer 2: Drifting wisps — volumetric body with vertical lift
    private _wisps = "#particlesource" createVehicleLocal _sourcePos;
    _wisps setParticleClass _wispsClass;
    _wisps setParticleCircle [0, [0, 0, 0]];
    _wisps setParticleRandom [
        1,
        [_radius * 0.7, _radius * 0.7, 0.5],
        [0.2, 0.2, 0.3],
        1, 0.3, [0, 0, 0, 0.05], 0, 0, 360
    ];
    _wisps setDropInterval 0.02;
    _wisps attachTo [_gasLogic, [0, 0, 0]];
    _particleObjects pushBack _wisps;

    // Layer 3: Perimeter creep — circle emission with slight inward velocity
    private _creep = "#particlesource" createVehicleLocal _sourcePos;
    _creep setParticleClass _carpetClass;
    _creep setParticleCircle [_radius * 0.95, [-0.4, -0.4, 0]];
    _creep setParticleRandom [
        2,
        [1, 1, 0.2],
        [0.2, 0.2, 0.05],
        1, 0.2, [0, 0, 0, 0.1], 0, 0, 360
    ];
    _creep setDropInterval 0.025;
    _creep attachTo [_gasLogic, [0, 0, 0]];
    _particleObjects pushBack _creep;

    GVAR(clientParticles) set [_netId, _particleObjects];
}] call CBA_fnc_addEventHandler;

[QGVAR(removeZoneParticles), {
    params ["_gasLogicNetId"];
    if !(_gasLogicNetId in GVAR(clientParticles)) exitWith {};
    private _particleObjects = GVAR(clientParticles) deleteAt _gasLogicNetId;
    { detach _x; deleteVehicle _x; } forEach _particleObjects;
}] call CBA_fnc_addEventHandler;

[QGVAR(csGrenadeEffect), {
    params ["_projectile", "_timeToLive"];
    if (isNull _projectile) exitWith {};
    private _position = position _projectile;
    private _particleSource = "#particlesource" createVehicleLocal _position;
    _particleSource setParticleParams [
        ["\A3\data_f\cl_basic",1,0,1], "", "Billboard",
        1, 5, [0,0,0], [0,0,1], 5 + random 10, 0.05, 0.04, 0.05,
        [1.5, 15.9], [[0.9294,0.9843,1,0.001], [0.9294,0.9843,1,0.1], [1,1,1,0]],
        [0,0], 0.1, 0.08, "", "", _projectile
    ];
    _particleSource setParticleRandom [2.5, [0.5,0.5,0.2], [0.3,0.3,0.5], 1, 0, [0,0,0,0.06], 0, 0];
    _particleSource setDropInterval (1 / 5);
    [{deleteVehicle _this}, _particleSource, _timeToLive] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

if (!isServer) exitWith {};

GVAR(gasSources) = createHashMap;
GVAR(exposureWatcherUnits) = createHashMap;

// Units the gas manager touched on its previous tick, so it can clear areaIntensity
// on the ones that have since left every cloud
GVAR(exposedUnits) = [];

// Server-side: register a unit with the exposure watcher PFH (idempotent).
// Triggered by FUNC(addToExposureWatcher) on the unit's owner.
[QGVAR(serverAddExposureWatcher), {
    params ["_unit"];
    if (isNull _unit) exitWith {};
    private _netId = netId _unit;
    if (_netId in GVAR(exposureWatcherUnits)) exitWith {};
    GVAR(exposureWatcherUnits) set [_netId, _unit];
    if !(missionNamespace getVariable [QGVAR(exposureWatcherActive), false]) then {
        missionNamespace setVariable [QGVAR(exposureWatcherActive), true];
        [LINKFUNC(exposureWatcherPFH), 1, []] call CBA_fnc_addPerFrameHandler;
    };
}] call CBA_fnc_addEventHandler;

// Server-side: start the contamination tick PFH for a unit.
[QGVAR(serverStartContaminationTick), LINKFUNC(startContaminationTick)] call CBA_fnc_addEventHandler;

[QGVAR(addGasSource), {
    params [
        ["_source", objNull, [objNull, []]],
        ["_radius", 0, [0]],
        ["_gasLevel", 0, [0]],
        ["_key", ""],
        ["_condition", {true}, [{}]],
        ["_conditionArgs", []],
        ["_isSealable", false]
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
    } else {
        _gasLogic setPosATL [_sourcePos select 0, _sourcePos select 1, 0];
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

    // Gas particles are only created for toxic zones right now
    if (_gasLevel != 0 && GVAR(enableParticleEffects)) then {
        // Broadcast particle creation to all machines (JIP-safe). Gas level is
        // forwarded so each client can pick the right per-gas particle class.
        private _effectsJipID = [QGVAR(createZoneParticles), [_gasLogic, _radius, _gasLevel]] call CBA_fnc_globalEventJIP;
        _gasLogic setVariable [QGVAR(effectsJipID), _effectsJipID];
    };

    GVAR(gasSources) set [_hashedKey, [_gasLogic, _radius, _gasLevel, _condition, _conditionArgs, _isSealable]];
}] call CBA_fnc_addEventHandler;

[QGVAR(removeGasSource), {
    params ["_key"];
    private _hashedKey = hashValue _key;

    if (isNil "_hashedKey") exitWith {
        ERROR_2("Unsupported key type used: %1 - %2",_key,typeName _key);
    };

    (GVAR(gasSources) deleteAt _hashedKey) params [["_gasLogic", objNull]];

    // Cancel JIP so future joiners don't get particles for a removed zone
    private _effectsJipID = _gasLogic getVariable [QGVAR(effectsJipID), ""];
    if (_effectsJipID != "") then {
        [_effectsJipID] call CBA_fnc_removeGlobalEventJIP;
    };
    // Tell all current machines to delete their local particles
    // Must fire BEFORE deleteVehicle so netId is still valid on clients
    [QGVAR(removeZoneParticles), [netId _gasLogic]] call CBA_fnc_globalEvent;

    detach _gasLogic;
    deleteVehicle _gasLogic;
}] call CBA_fnc_addEventHandler;

[LINKFUNC(gasManagerPFH), GAS_MANAGER_PFH_DELAY, []] call CBA_fnc_addPerFrameHandler;

