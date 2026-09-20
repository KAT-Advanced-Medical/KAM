#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Confirm/cancel handler for the radiation Zeus module attributes dialog.
 * On confirm reads the radius/strength/point-source inputs and registers a
 * radiation source; on cancel deletes the placed logic. Mirrors fnc_ui_gasModule.
 *
 * Arguments:
 * 0: Control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_control] call kat_chemical_fnc_ui_radModule;
 *
 * Public: No
 */

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _fnc_onUnload = {
    params ["_display"];
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};
    if !(_display getVariable [QGVAR(Confirmed), false]) then {
        deleteVehicle _logic;
    };
};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _radius = _display getVariable [QGVAR(ui_radius), 20];
    private _strengths = _display getVariable [QGVAR(ui_radStrengths), [0, 0, 50, 0]];
    private _pointSource = _display getVariable [QGVAR(ui_radPointSource), false];
    private _falloff = ["linear", "inverseSquare"] select _pointSource;

    private _center = _logic;
    if !(isNull attachedTo _logic) then {
        _center = attachedTo _logic;
    };

    [QGVAR(addRadSource), [_center, _radius, _strengths, _falloff, _logic, {
        params ["_endTime", "_logic"];

        if (isNull _logic) exitWith {
            false
        };

        CBA_missionTime < _endTime
    }, [CBA_missionTime + 1e10, _logic]]] call CBA_fnc_serverEvent;

    _display setVariable [QGVAR(Confirmed), true];
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
