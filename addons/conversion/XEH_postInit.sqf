#include "script_component.hpp"

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;

[QGVAR(convertCasualty), {
    private _type = typeOf player; 
    private _group = createGroup [(side group player), true]; 
    private _previousUnit = player;
    private _setName = name _previousUnit;
    private _loadout = [player] call CBA_fnc_getLoadout;
    private _unit = _group createUnit [_type, [0,0,0], [], 0, "NONE"];
    [player, _loadout] call CBA_fnc_setLoadout;

    _previousUnit setVariable [QEGVAR(vitals,simpleMedical), false, true];
    _previousUnit setVariable [QGVAR(currentlyConverted), true, true];
    _previousUnit setVariable [QACEGVAR(medical_statemachine,AIUnconsciousness), true, true];

    selectPlayer _unit; 

    [QGVAR(unitTransfer), [_previousUnit]] call CBA_fnc_serverEvent;

    _previousUnit setName _setName;

    forceRespawn player;
    deleteVehicle _unit;
}] call CBA_fnc_addEventHandler;

[QGVAR(unitTransfer), {
    params ["_previousUnit"];
    private _group2 = createGroup [(side group _previousUnit), true]; 
    [_previousUnit] join _group2;
    _group2 setGroupOwner 2;
    [_previousUnit, true] call ACEFUNC(medical,setUnconscious);
}] call CBA_fnc_addEventHandler;

[QGVAR(respawnTimer), {
    params ["_time", "_unit"];
    private _currentRespawnTime = playerRespawnTime;
    setPlayerRespawnTime _time;
    private _currentUnit = _unit;

    [{
        params ["_currentUnit"];
    
        (lifeState _currentUnit isEqualTo "HEALTHY")
    }, {
        params [_currentRespawnTime];
        setPlayerRespawnTime _currentRespawnTime;
    }, [_currentUnit, _currentRespawnTime], 360, {}] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;
