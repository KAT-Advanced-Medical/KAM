#include "..\script_component.hpp"
/*
 * Author: DiGii
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

systemChat "Initialize Module Test";

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

systemChat str _ctrlButtonOK;


_control ctrlRemoveAllEventHandlers "SetFocus";


private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};
    if !(_display getVariable [QGVAR(Confirmed), false]) then
    {
        if !(isNull attachedTo _logic) then
        {
            deleteVehicle _logic;
        } else
        {
            detach (attachedTo _logic);
            deleteVehicle _logic;
        };
    };
};

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

};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    systemChat "Module Confirm Click";

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _gasTypeValue = _display getVariable[QGVAR(ui_gastype),0];
    private _gastype = "";
    switch (_gasTypeValue) do {
        case 1: { //CS
            _gastype = "CS";
        };
        default { //toxic gas (default)
            _gastype = "Toxic";
        };
    };

    private _radius_max = _display getVariable [QGVAR(ui_radiusMax), 20];
    private _radius_min = _display getVariable [QGVAR(ui_radiusMin), 10];
    if(_radius_min > _radius_max) then {
        [CSTRING(GasModule_Needbigger)] call ACEFUNC(zeus,showMessage);
    } else {
        private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
        if (isNull _logic) exitWith {};

        if !(isNull attachedTo _logic) then {
            private _object = attachedto _logic;

            systemChat "Module Gas Check Initialize";
            [_logic,getPos _object,_radius_max,_radius_min,_gastype] call FUNC(gasCheck);

            if (_display getVariable[QGVAR(ui_sealable),false]) then {
                [_object] call FUNC(createSealAction);
            };

        } else {
            systemChat "Module Gas Check Initialize";

            [_logic,getPos _logic,_radius_max,_radius_min,_gastype] call FUNC(gasCheck);
        };

        _display setVariable [QGVAR(Confirmed), true];
    };
};


_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];

