#include "script_component.hpp"

//Events
["ace_glassesChanged", LINKFUNC(breathing)] call CBA_fnc_addEventHandler;
[QGVAR(poison), LINKFUNC(poison)] call CBA_fnc_addEventHandler;
[QGVAR(handleGasMaskDur), LINKFUNC(handleGasMaskDur)] call CBA_fnc_addEventHandler;
[QGVAR(addSealAction), LINKFUNC(createSealAction)] call CBA_fnc_addEventHandler;

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

["KAT_ChemicalDetector", QGVAR(showChemDetector), "Show Chemical Detector", {
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

    GVAR(gasSources) set [_hashedKey, [_gasLogic, _radius, _gasLevel, _condition, _conditionArgs]];
}] call CBA_fnc_addEventHandler;

[QGVAR(removeGasSource), {
    params ["_key"];
    private _hashedKey = hashValue _key;

    if (isNil "_hashedKey") exitWith {
        ERROR_2("Unsupported key type used: %1 - %2",_key,typeName _key);
    };

    (GVAR(gasSources) deleteAt _hashedKey) params [["_gasLogic", objNull]];

    detach _gasLogic;
    deleteVehicle _gasLogic;
}] call CBA_fnc_addEventHandler;

[LINKFUNC(gasManagerPFH), GAS_MANAGER_PFH_DELAY, []] call CBA_fnc_addPerFrameHandler;

