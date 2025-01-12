#include "script_component.hpp"

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;

["kat_conversion_convertCasualty", {
    private _type = typeOf player; 
    private _group = createGroup [(side player), true]; 
    private _previousUnit = player;
    private _setName = name _previousUnit;
    private _loadout = getUnitLoadout player;
    private _unit = _group createUnit [_type, [0,0,0], [], 0, "NONE"];
    _unit setUnitLoadout _loadout;

    _previousUnit setVariable [QEGVAR(vitals,simpleMedical), false, true];
    _previousUnit setVariable [QGVAR(currentConverted), true, true];

    selectPlayer _unit; 

    ["kat_conversion_unitTransfer", [_previousUnit]] call CBA_fnc_serverEvent;

    _previousUnit setName _setName;

    _unit setDamage 1; 
    deleteVehicle _unit;
}] call CBA_fnc_addEventHandler;

["kat_conversion_unitTransfer", {
    params ["_previousUnit"];
    private _group2 = createGroup [(side _previousUnit), true]; 
    [_previousUnit] join _group2;
    _group2 setGroupOwner 2;
    [_previousUnit, true] call ACEFUNC(medical_engine,setUnconsciousAnim);
}] call CBA_fnc_addEventHandler;