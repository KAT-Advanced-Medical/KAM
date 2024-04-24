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
params["_target"];

private _action = [
    "kat_gas_interaction",
    LLSTRING(sealLeak),
    "",
    {
        params["_target", "_player"];

        [_player, "Acts_carFixingWheel"] call ACEFUNC(common,doAnimation);

        //add time to addon options
        [
            20,
            [_target,_player],
            {
                params["_args"];
                _args params ["_target","_player"];
                _target setVariable [QGVAR(gas_active), false, true];
                [_target, 0, ["ACE_MainActions", "kat_gas_interaction"]] call ACEFUNC(interact_menu,removeActionFromObject);
                [_player, "kat_sealant"] call ACEFUNC(common,useItem);
            },
            {
                params["_args"];
                _args params ["_target","_player"];
                [_player, "",1] call ACEFUNC(common,doAnimation);
            },
            LLSTRING(GasModule_SealLeak),
            {[_player,_player,["kat_sealant"]] call ACEFUNC(medical_treatment,hasItem);},//conditions
            ["isNotInside"]
        ] call ace_common_fnc_progressBar;
    },
    {
        params["_target","_player"];

        [_player, _target] call ACEFUNC(common,canInteractWith);
        [_player, _player, ["kat_sealant"]] call ACEFUNC(medical_treatment,hasItem);
    },
    {},
    []
] call ACEFUNC(interact_menu,createAction);

[_target, 0, ["ACE_MainActions"], _action] call ACEFUNC(interact_menu,addActionToObject);
