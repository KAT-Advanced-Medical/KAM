#include "script_component.hpp"
/*
 * Author: Tomcat, Blue
 * Place the AED/X in front of unit
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: AED Classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 'kat_AED'] call kat_circulation_fnc_placeAED;
 *
 * Public: No
 */

params ["_unit", "_AEDClassName"];

_unit removeItem _AEDClassName;

private _AED = ([_AEDClassName,"Item"] joinString "") createVehicle (position _unit);

[_AED, true] call ACEFUNC(dragging,setDraggable);
[_AED, true] call ACEFUNC(dragging,setCarryable);

[_unit, _AED] call ACEFUNC(dragging,carryObject);

if (_AEDClassName == "kat_X_AED") then {
    _AED setVariable [QGVAR(AED_X_Volume), _unit getVariable [QGVAR(AED_X_Volume), false], true];
    _AED setVariable [QGVAR(AED_X_Connected), false, true];
};

private _action = ["AED_pickupAction",
LLSTRING(PickUpAction),
"",
{
    params ["_AED", "_unit", "_args"];
    _args params ["_AEDClassName"];

    _AED setVariable [QGVAR(AEDinUse), false, true];

    if (_AEDClassName == "kat_X_AED") then {
        _AED setVariable [QGVAR(AED_X_Connected), false, true];
        _unit setVariable [QGVAR(AED_X_Volume), _AED getVariable [QGVAR(AED_X_Volume), false], true];
    };

    deleteVehicle _AED;
    _unit addItem _AEDClassName;
},
{
    params ["_AED", "_unit"];
    [_unit, GVAR(medLvl_AED_Station_Interact)] call ACEFUNC(medical_treatment,isMedic)
},
{},
[_AEDClassName]
] call ACEFUNC(interact_menu,createAction);
[_AED, 0, ["ACE_MainActions"], _action] call ACEFUNC(interact_menu,addActionToObject);