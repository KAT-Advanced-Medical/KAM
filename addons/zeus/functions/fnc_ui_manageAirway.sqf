#include "script_component.hpp"
/*
 * Author: DiGi
 * Initalizes the "Manage Airways" Zeus module.
 *
 * Arguments:
 * 0: manageAirway controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [control] call kat_zeus_fnc_ui_manageAirway
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

private _fnc_sliderMove = {
    params ["_slider","_curSpO2Val"];
    private _idc = ctrlIDC _slider;
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    private _unit = attachedTo _logic;
    private _curVal = _unit getVariable [QEGVAR(breathing,airwayStatus), 50];
    _slider ctrlSetTooltip format [LLSTRING(sliderFormat13was23), round(sliderPosition _slider), round _curVal, "%"];
};

private _slider = _display displayCtrl 16106;
_slider sliderSetRange [0, 100];
_slider sliderSetSpeed [1,10];
private _curSpO2Val = _unit getVariable [QEGVAR(breathing,airwayStatus), 50];
_slider sliderSetPosition (round _curSpO2Val);
_slider ctrlAddEventHandler ["SliderPosChanged", _fnc_sliderMove];
[_slider,_curSpO2Val] call _fnc_sliderMove;

(_display displayCtrl 16101) cbSetChecked (_unit getVariable [QEGVAR(airway,obstruction), false]);
(_display displayCtrl 16102) cbSetChecked (_unit getVariable [QEGVAR(airway,occluded), false]);
(_display displayCtrl 16103) cbSetChecked (_unit getVariable [QEGVAR(breathing,pneumothorax), false]);
(_display displayCtrl 16104) cbSetChecked (_unit getVariable [QEGVAR(breathing,hemopneumothorax), false]);
(_display displayCtrl 16105) cbSetChecked (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), false]);



private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlparent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objnull);
    if (isNull _logic) exitWith {};

    private _unit = attachedTo _logic;

    private _valueArr = [];
    {
        private _value = cbChecked (_display displayCtrl _x);
        _valueArr pushBack _value;
    } forEach [16101,16102,16103,16104,16105];

    _unit setVariable [QEGVAR(airway,obstruction), _valueArr select 0, true];
    _unit setVariable [QEGVAR(airway,occluded), _valueArr select 1, true];
    _unit setVariable [QEGVAR(breathing,pneumothorax), _valueArr select 2, true];
    _unit setVariable [QEGVAR(breathing,hemopneumothorax), _valueArr select 3, true];
    _unit setVariable [QEGVAR(breathing,tensionpneumothorax), _valueArr select 4, true];
    private _curSpO2Val = _unit getVariable [QEGVAR(breathing,airwayStatus), 50];
    private _sliderValue = sliderPosition (_display displayCtrl 16106);
    
    _unit setVariable [QEGVAR(breathing,airwayStatus), round(_sliderValue), true]; 
    if(_curSpO2Val isEqualTo 100) then { 
        [_unit] call EFUNC(breathing,handleBreathing);
    };
    
    [_unit] call EFUNC(circulation,updateInternalBleeding);
};

_display displayAddEventHandler ["unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["buttonclick", _fnc_onConfirm];
