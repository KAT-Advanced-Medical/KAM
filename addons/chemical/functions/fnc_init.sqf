#include "script_component.hpp"
/*
* Author: DiGii
*
* Arguments:
* 0: player <Object>
*
* Return Value:
* NONE
*
* Example:
* [] call kat_chemical_fnc_init;
*
* Public: No
*/
params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

private _items = missionNamespace getVariable [QGVAR(availGasmask), """G_AirPurifyingRespirator_01_F"""];
private _item_arr = [_items, "CfgGlasses"] call FUNC(getlist);
GVAR(availGasmaskList) = _item_arr;

if (hasinterface) then {
    [_unit] call FUNC(coughing);
    [_unit] spawn FUNC(handleGasMaskDur);
    [_unit] spawn FUNC(chemDetector);
    [_unit] spawn FUNC(breathing);

    _unit setVariable [QGVAR(timeleft), missionNamespace getVariable [QGVAR(infectionTime), 60], true];
    _unit setVariable [QGVAR(enteredPoison), false, true];
    _unit setVariable [QGVAR(gasmask_durability), 10, true];
    _unit setVariable [QGVAR(gasmask_durability_reset), false, true];
    _unit setVariable [QGVAR(chemDetectorState), true , true];

    [{
        params ["_args", "_pfhID"];
        _args params ["_unit"];
        private _playertime = _unit getVariable [QGVAR(timeleft), 60];
        private _maxtime = missionnamespace getVariable [QGVAR(infectionTime), 60];
        if (!(_unit getVariable [QGVAR(enteredPoison), false])) then {
            if (_playertime < missionnamespace getVariable [QGVAR(infectionTime), 60]) then {
                _playertime = _playertime + 1;
                if (_playertime >= _maxtime) then {
                    _playertime = _maxtime;
                };
                _unit setVariable[QGVAR(timeleft), _playertime, true];
            };
        };
    }, 2, _unit]call CBA_fnc_addPerFrameHandler;

    [{
        params ["_args", "_pfhID"];
        _args params ["_unit"];

        "KAT_CHEM_DETECtor" cutRsc ["RscWeaponChemicalDetector", "PLAin", 1, false];
        private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
        private _obj = _ui displayCtrl 101;
        if (!(_unit getVariable[QGVAR(enteredPoison), false])) then {
            _obj ctrlAnimatemodel ["Threat_Level_Source", 0, true];
        };
    }, 2, [_unit]]call CBA_fnc_addPerFrameHandler;
};
