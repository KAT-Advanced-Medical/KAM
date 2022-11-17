#include "script_component.hpp"
/*
*     Author: Tomcat
* 
*     Place the AED in front of the player
*
*     Arguments:
*         0: Item <STRING> 
*         1: Classname <STRING>
*
*     Return Value:
*     None
*
*/

ACE_player removeItem "kat_AED";

private _AED = createVehicle ["kat_AEDItem", position ACE_player, [], 0, "NONE"];

[_AED, true, [0, 1, 0]] remoteExecCall ["ace_dragging_fnc_setDraggable", 0, true];
[_AED, true, [0, 1, 0]] remoteExecCall ["ace_dragging_fnc_setCarryable", 0, true];

[player, _AED] call ACEFUNC(dragging,carryObject);

private _pickupAED = [
    "AED_pickupAction",
    localize "STR_KAT_circulation_PickUpAction",
    "",
    {
        params ["_target", "_player"];
        
        deleteVehicle _target;
        _player addItem "kat_AED";
    },
    {true}
] call ACEFUNC(interact_menu,createAction);

[_AED, 0, ["ACE_MainActions"], _pickupAED] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", 0, true];
