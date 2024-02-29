#include "..\script_component.hpp"
/*
 * Author: DiGi, Blue
 * Initalizes the "Change Cardiac State" Zeus module.
 *
 * Arguments:
 * 0: changeCardiacState controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [control] call kat_zeus_fnc_ui_changeCardiacState
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

(_display displayCtrl 16112) lbSetCurSel (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0]);

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlparent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objnull);
    if (isNull _logic) exitWith {};

    private _unit = attachedTo _logic;

    private _currentState = _unit getVariable [QEGVAR(circulation,cardiacArrestType), 0];

    private _state = lbCurSel (_display displayCtrl 16112);

    _unit setVariable [QEGVAR(circulation,cardiacArrestType), _state, true];

    if (_state isEqualTo 0) then {
        [QACEGVAR(medical,CPRSucceeded), [_unit], _unit] call CBA_fnc_targetEvent;
    } else {
        if (_state > 0 && _currentState isEqualTo 0) then {
            [QACEGVAR(medical,FatalVitals), [_unit], _unit] call CBA_fnc_targetEvent;
        };
    };
};

_display displayAddEventHandler ["unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["buttonclick", _fnc_onConfirm];
