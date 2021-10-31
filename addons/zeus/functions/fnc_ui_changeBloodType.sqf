#include "script_component.hpp"
/*
 * Author: DiGi
 * Initalizes the "Manage Airways" Zeus module.
 *
 * Arguments:
 * 0: changeBloodType controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [control] call kat_zeus_fnc_ui_changeBloodType
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

private _playerBloodyType = _unit getVariable [QEGVAR(circulation,bloodtype), "O"];
private _select = switch (_playerBloodyType) do 
{
	case "O":  {0};
  	case "A":  {1};
 	case "B":  {2};
  	case "AB": {3};
};
(_display displayCtrl 16107) lbSetCurSel _select;

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlparent _ctrlButtonOK;
    if (isNull _display) exitWith {};

	private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objnull);
    if (isNull _logic) exitWith {};

	private _unit = attachedTo _logic;
	private _bloodtypeSel = lbCurSel (_display displayCtrl 16107);
	private _bloodtype = ["0","A","B","AB"] select _bloodtypeSel;
	_unit setVariable [QEGVAR(circulation,bloodtype), _bloodtype, true];
    private _dogtagData = _unit getVariable "ace_dogtags_dogtagData";
    if(!isNil "_dogtagData") then {
        _dogtagData set [2, _bloodtype];
    };
};

_display displayAddEventHandler ["unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["buttonclick", _fnc_onConfirm];