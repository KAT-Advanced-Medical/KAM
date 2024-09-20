#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_createSealAction;
 *
 * Public: No
*/
params ["_target", "_logic", "_key"];

private _action = [
    QGVAR(sealLeak),
    LLSTRING(sealLeak),
    "",
    {
        params ["_target", "_player", "_params"];
        _params params ["_logic", "_key"];

        [_player, "Acts_carFixingWheel"] call ACEFUNC(common,doAnimation);

        //add time to addon options
        [
            5,
            [_target, _player, _logic, _key],
            {
                params["_args"];
                _args params ["_target","_player", "_logic", "_key"];
                [_player, "kat_sealant"] call ACEFUNC(common,useItem);
                [QGVAR(removeGasSource), _key] call CBA_fnc_serverEvent;
                _target setVariable [QGVAR(sealable), false, true];
            },
            {
                params["_args"];
                _args params ["_target","_player"];
                [_player, "",1] call ACEFUNC(common,doAnimation);
            },
            LLSTRING(GasModule_SealLeak),
            {[_player, _player, ["kat_sealant"]] call ACEFUNC(medical_treatment,hasItem);},//conditions
            ["isNotInside"]
        ] call ace_common_fnc_progressBar;
    },
    {
        params["_target","_player"];

        ([_player, _target] call ACEFUNC(common,canInteractWith)) &&
        ([_player, _player, ["kat_sealant"]] call ACEFUNC(medical_treatment,hasItem)) &&
        (_target getVariable [QGVAR(sealable), false])
    },
    {},
    [_logic, _key]
] call ACEFUNC(interact_menu,createAction);


[_target, 0, ["ACE_MainActions"], _action] call ACEFUNC(interact_menu,addActionToObject);



