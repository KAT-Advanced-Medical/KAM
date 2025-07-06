#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * outputs current unit state to that units RPT for debug tracing
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call kat_zeus_fnc_toggleAIDeathModule;
 *
 * Public: Yes
 */

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";


private _unit = attachedTo _logic;

scopeName "Main";
private _fnc_error = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call FUNC(showMessage);
    breakOut "Main";
};

switch (false) do {
    case !(isNull _unit): {
        [ACELSTRING(zeus,NothingSelected)] call _fnc_error;
    };
    case (_unit isKindOf "CAManBase"): {
        [ACELSTRING(zeus,OnlyInfantry)] call _fnc_error;
    };
};

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};
    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _unit = attachedTo _logic;

    private _json = ctrlText (_display displayCtrl 18112);
    
    [_unit, _json] call EFUNC(misc,deserializeState);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
