#include "script_component.hpp"

[QGVAR(useHandWarmer), LINKFUNC(useHandWarmerLocal)] call CBA_fnc_addEventHandler;
[QGVAR(applyFluidWarmer), LINKFUNC(applyFluidWarmerLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeFluidWarmer), LINKFUNC(removeFluidWarmerLocal)] call CBA_fnc_addEventHandler;
[QGVAR(applySpaceBlanket), LINKFUNC(applySpaceBlanketLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeSpaceBlanket), LINKFUNC(removeSpaceBlanketLocal)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
["ace_medical_death", {
    params ["_unit"];
    [{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    private _alive = alive _unit;
    if (_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _temp = _unit getVariable [QGVAR(unitTemperature), 37];
    if (_temp < 22) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _temp = _temp - 0.1;
    _unit setVariable [QGVAR(unitTemperature), _temp, true];
}, 10, [_unit]] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
