#include "..\script_component.hpp"
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

private _fnc_sliderMove_ptx = {
    params ["_slider","_curPTX"];
    private _idc = ctrlIDC _slider;
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    private _unit = attachedTo _logic;
    private _curVal = _unit getVariable [QEGVAR(breathing,pneumothorax), 0];
    _slider ctrlSetTooltip format [LLSTRING(sliderFormat13was23), round(sliderPosition _slider), round _curVal];
};

private _sliderPTX = _display displayCtrl 16105;
_sliderPTX sliderSetRange [0, 4];
_sliderPTX sliderSetSpeed [1,10];
private _curPTX = _unit getVariable [QEGVAR(breathing,pneumothorax), 0];
_sliderPTX sliderSetPosition (round _curPTX);
_sliderPTX ctrlAddEventHandler ["SliderPosChanged", _fnc_sliderMove_ptx];
[_sliderPTX,_curPTX] call _fnc_sliderMove_ptx;

private _fnc_sliderMove_SPO2 = {
    params ["_slider","_curSpO2Val"];
    private _idc = ctrlIDC _slider;
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    private _unit = attachedTo _logic;
    private _curVal = _unit getVariable [QEGVAR(breathing,airwayStatus), 50];
    _slider ctrlSetTooltip format [LLSTRING(sliderFormat13was23), round(sliderPosition _slider), round _curVal, "%"];
};

private _sliderSPO2 = _display displayCtrl 16106;
_sliderSPO2 sliderSetRange [0, 100];
_sliderSPO2 sliderSetSpeed [1,10];
private _curSpO2Val = _unit getVariable [QEGVAR(breathing,airwayStatus), 50];
_sliderSPO2 sliderSetPosition (round _curSpO2Val);
_sliderSPO2 ctrlAddEventHandler ["SliderPosChanged", _fnc_sliderMove_SPO2];
[_sliderSPO2,_curSpO2Val] call _fnc_sliderMove_SPO2;

(_display displayCtrl 16101) cbSetChecked (_unit getVariable [QEGVAR(airway,obstruction), false]);
(_display displayCtrl 16102) cbSetChecked (_unit getVariable [QEGVAR(airway,occluded), false]);
(_display displayCtrl 16103) cbSetChecked (_unit getVariable [QEGVAR(breathing,hemopneumothorax), false]);
(_display displayCtrl 16104) cbSetChecked (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), false]);

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
    } forEach [16101,16102,16103,16104];

    private _initBreathing = false;

    {
        private _targetState = _valueArr select _forEachIndex;
        private _currentState = _unit getVariable [_x, false];

        if (!_initBreathing && (_targetState && !_currentState)) then {
            _initBreathing = true;
        };

        _unit setVariable [_x, _targetState, true];
    } forEach [QEGVAR(airway,obstruction), QEGVAR(airway,occluded), QEGVAR(breathing,hemopneumothorax), QEGVAR(breathing,tensionpneumothorax)];

    private _curSpO2Val = _unit getVariable [QEGVAR(breathing,airwayStatus), 50];

    private _pneumothorax = round(sliderPosition (_display displayCtrl 16105));

    _unit setVariable [QEGVAR(breathing,pneumothorax), _pneumothorax, true];
    _unit setVariable [QEGVAR(breathing,airwayStatus), round(sliderPosition (_display displayCtrl 16106)), true];

    if (_curSpO2Val isEqualTo 100 || _initBreathing) then {
        [_unit] call EFUNC(breathing,handleBreathing);
    };

    if (_pneumothorax isEqualTo 0 && !(_valueArr select 2) && !(_valueArr select 3)) then {
        [_unit, 0, 0, "ptx_tension", true] call EFUNC(circulation,updateBloodPressureChange);
    } else {
        [_unit, -12 * _pneumothorax, -12 * _pneumothorax, "ptx_tension", true] call EFUNC(circulation,updateBloodPressureChange);
        [_unit, 0.5 * (_pneumothorax / 4)] call ACEFUNC(medical_status,adjustPainLevel);
    };

    if ((_valueArr select 2) || (_valueArr select 3)) then {
        _unit setVariable [QEGVAR(breathing,pneumothorax), 4, true];
        [_unit, -48, -48, "ptx_tension", true] call EFUNC(circulation,updateBloodPressureChange);
        [_unit, 0.5] call ACEFUNC(medical_status,adjustPainLevel);
    };

    if ((cbChecked (_display displayCtrl 16107)) && _pneumothorax > 0 && !(_valueArr select 2) && !(_valueArr select 3)) then {
        [_unit] call EFUNC(breathing,handlePneumothoraxDeterioration);
    };

    [_unit] call EFUNC(circulation,updateInternalBleeding);
};

_display displayAddEventHandler ["unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["buttonclick", _fnc_onConfirm];
