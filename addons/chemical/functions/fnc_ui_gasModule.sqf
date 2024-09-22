#include "..\script_component.hpp"
/*
 * Author: DiGii, MiszczuZPolski
 * Creates the UI for the Zeus Module
 *
 * Arguments:
 * 0: Control <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [1105] call kat_chemical_fnc_ui_gasModule;
 *
 * Public: No
*/

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _ctrlButtonCancel = _display displayCtrl 2;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call ACEFUNC(zeus,showMessage);
    breakOut "Main";
};

if !(isNull attachedTo _logic) then {
    private _object = attachedTo _logic;
    switch (true) do {
        case (isNull _object): {
            [ACELSTRING(zeus,NothingSelected)] call _fnc_errorAndClose;
        };
        case (isPlayer _object): {
            ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call _fnc_errorAndClose;
        };
        case (!alive _object): {
            [ACELSTRING(zeus,OnlyAlive)] call _fnc_errorAndClose;
        };
        default {};
    };

} else {
    [LLSTRING(OnlyObject)] call _fnc_errorAndClose;
};

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};
    if !(_display getVariable [QGVAR(Confirmed), false]) then
    {
        if !(isNull attachedTo _logic) then {
            deleteVehicle _logic;
        } else {
            detach (attachedTo _logic);
            deleteVehicle _logic;
        };
    };
};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _gasLevel = _display getVariable [QGVAR(ui_gastype), 0];
    private _radius = _display getVariable [QGVAR(ui_radius), 20];
    private _isSealable = _display getVariable [QGVAR(ui_sealable), false];

    [QGVAR(addGasSource), [attachedTo _logic, _radius, _gasLevel, _logic, {
        params ["_endTime", "_logic"];

        // If logic no longer exists, exit
        if (isNull _logic) exitWith {
            false // return
        };

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + 1e10, _logic], _isSealable]] call CBA_fnc_serverEvent;

    _display setVariable [QGVAR(Confirmed), true];

};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];

