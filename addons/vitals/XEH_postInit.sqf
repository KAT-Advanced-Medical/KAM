#include "script_component.hpp"

[QGVAR(basicDiagnosticLocal), LINKFUNC(basicDiagnosticLocal)] call CBA_fnc_addEventHandler;

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
    private _bg = _unit getVariable [VAR_BLOOD_GAS, DEFAULT_BLOOD_GAS];
    private _spo2 = (_bg select 2) - 0.005;
    if (_spo2 < 0.01) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    _bg set [2, _spo2];
    _unit setVariable [VAR_BLOOD_GAS, _bg, true];
}, 10, [_unit]] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;

