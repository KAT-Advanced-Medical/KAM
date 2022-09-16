#include "script_component.hpp"
/*
 * Author: DiGi
 * Initalizes the "Change Shockable State" Zeus module.
 *
 * Arguments:
 * 0: changeShockableState controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [control] call kat_zeus_fnc_ui_changeAsystole
 *
 * Public: No
 */

params ["_control"]; 

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "setFocus";


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
        [LSTRING(NothingSelected)] call _fnc_error;
    };
    case (_unit isKindOf "CAManBase"): {
        [LSTRING(OnlyInfantry)] call _fnc_error;
    };
};

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};
    deleteVehicle _logic;
};

private _state = _unit getVariable [QEGVAR(circulation,asystole), 0];

(_display displayCtrl 16112) lbSetCurSel _select;


private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlparent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objnull);
    if (isNull _logic) exitWith {};

    private _unit = attachedTo _logic;
    private _asystolestate = lbCurSel (_display displayCtrl 16112);
    _unit setVariable [QEGVAR(circulation,asystole), _asystolestate, true];
    
};

_display displayAddEventHandler ["unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["buttonclick", _fnc_onConfirm];
