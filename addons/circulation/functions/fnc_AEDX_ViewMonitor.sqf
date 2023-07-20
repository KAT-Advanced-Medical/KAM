#include "script_component.hpp"
/*
 * Author: Blue
 * Open AED-X Vitals Monitor dialog
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Target <OBJECT>
 * 2: Monitor source <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 1] call kat_circulation_fnc_AEDX_ViewMonitor;
 *
 * Public: No
 */

params ["_medic", "_target", ["_source", 0]];

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening
 
if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _patient = _target;

switch (_source) do {
    case 1: {_patient = _target getVariable QGVAR(Defibrillator_Patient);}; // Placed
    case 2: {_patient = _medic getVariable QGVAR(MedicDefibrillator_Patient);}; // Self-interaction (medic)
    default {}; // Direct (patient)
};

GVAR(AEDX_MonitorTarget) = _patient;

createDialog QGVAR(AEDX_Monitor_Dialog);

private _dlg = findDisplay 69000;

ctrlShow [69030, false];
ctrlShow [69031, false];
ctrlShow [69032, false];
ctrlShow [69033, false];
ctrlShow [69034, false];
ctrlShow [69035, false];
ctrlShow [69036, false];
ctrlShow [69037, false];

ctrlShow [69040, false];
ctrlShow [69041, false];
ctrlShow [69042, false];
ctrlShow [69043, false];
ctrlShow [69044, false];
ctrlShow [69045, false];
ctrlShow [69046, false];
ctrlShow [69047, false];
ctrlShow [69048, false];
ctrlShow [69049, false];
ctrlShow [69050, false];
ctrlShow [69051, false];
ctrlShow [69052, false];
ctrlShow [69053, false];
ctrlShow [69054, false];
ctrlShow [69055, false];
ctrlShow [69056, false];
ctrlShow [69057, false];
ctrlShow [69058, false];
ctrlShow [69059, false];
ctrlShow [69060, false];

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg"];

    if (isNull _dlg) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _slider = _dlg displayCtrl 69010;

    _slider ctrlSetPosition [pxToScreen_X(250), (ctrlPosition _slider) select 1, (ctrlPosition _slider) select 2, (ctrlPosition _slider) select 3];
    _slider ctrlCommit 0;

    _slider ctrlSetPosition [pxToScreen_X(1460), (ctrlPosition _slider) select 1, (ctrlPosition _slider) select 2, (ctrlPosition _slider) select 3];
    _slider ctrlCommit 4;
}, 4, [_dlg]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg", "_target", "_source"];

    if (isNull _dlg) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if(_source isEqualTo 1) then {
        GVAR(AEDX_MonitorTarget) = _target getVariable QGVAR(Defibrillator_Patient);
    };

    private _pads = false;

    if !(GVAR(AEDX_MonitorTarget) isEqualTo objNull) then {
        _pads = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(DefibrillatorPads_Connected), false];
    } else {
        GVAR(AEDX_MonitorTarget) = objNull;
    };
    
    private _shockButton = "";

    if !(_pads) then {
        ctrlSetText [69021, "Check Pads"];
        ctrlSetText [69020, QPATHTOF(ui\ekg_off.paa)];
        GVAR(AEDX_MonitorTarget) = objNull;
    } else {
        ctrlSetText [69021, ""];
        private _ekgDisplay = QPATHTOF(ui\ekg_off.paa);

        switch (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0]) do {
            case 4: {_ekgDisplay = QPATHTOF(ui\ekg_vt.paa);};
            case 3: {_ekgDisplay = QPATHTOF(ui\ekg_vf.paa);};
            case 1: {_ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);};
            default {
                if(GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,inCardiacArrest), false] || !(alive GVAR(AEDX_MonitorTarget))) then {
                    _ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);
                } else {
                    _ekgDisplay = QPATHTOF(ui\ekg_sinus.paa);
                };
            };
        };

        ctrlSetText [69020, _ekgDisplay];
        
        if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false]) then {
            _shockButton = QPATHTOF(ui\shockbutton.paa);
        };
    };

    ctrlSetText [69022, _shockButton];

    // Handle date and time display - [year,month,day,hour,min]

    ctrlSetText [69017, format ["%1/%2/%3               %4:%5", (if (date select 2 < 10) then { "0" } else { "" }) + str (date select 2), (if (date select 1 < 10) then { "0" } else { "" }) + str (date select 1), date select 0, (if (date select 3 < 10) then { "0" } else { "" }) + str (date select 3), (if (date select 4 < 10) then { "0" } else { "" }) + str (date select 4)]];
    ctrlSetText [69018, format ["%1:%2:%3", (if ((floor(time/3600)) < 10) then { "0" } else { "" }) + str (floor(time/3600)), (if ((floor(((time/3600) - floor(time/3600)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((time/3600) - floor(time/3600)) * 60)), (if ((floor(((time/60) - floor(time/60)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((time/60) - floor(time/60)) * 60))]];
    
}, 0, [_dlg, _target, _source]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg"];

    private _pads = false;

    if !(GVAR(AEDX_MonitorTarget) isEqualTo objNull) then {
        _pads = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(DefibrillatorPads_Connected), false];
    };

    private _hr = 0;
    private _bp = [0,0];

    if (isNull _dlg) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if !(_pads) exitWith {
        ctrlSetText [69011, "---"];
        ctrlSetText [69012, "---"];
        ctrlSetText [69013, "---"];
        ctrlSetText [69014, ""];
        ctrlSetText [69016, "---"];
    };

    if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0] in [2,4]) then {
        _hr = GVAR(AEDX_MonitorTarget) call FUNC(getCardiacArrestHeartRate);
        _bp = [0,0];

        if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0] isEqualTo [4]) then {
            _bp = [random [0,4,10], random [4,12,20]];
        };
    } else {
        _hr = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0];
        _bp = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
    };

    ctrlSetText [69011, format["%1", round(_hr)]];

    if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
        ctrlSetText [69012, format["%1", round(_bp select 1)]];
        ctrlSetText [69013, format["%1", round(_bp select 0)]];
        ctrlSetText [69014, format["(%1)", round(((_bp select 1) - (_bp select 0))/3 + (_bp select 0))]];
        ctrlSetText [69016, format["%1", round(GVAR(AEDX_MonitorTarget) getVariable [QEGVAR(breathing,airwayStatus), 100])]];
    };
}, 1, [_dlg]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_dlg"];

    isNull _dlg || GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false];
}, {
    params ["_dlg", "_chargeBar"];

    if !(isNull _dlg) then {
        [true] call FUNC(AEDX_ViewMonitor_Charging);
    };
}, [_dlg, _chargeBar], 4, {}] call CBA_fnc_waitUntilAndExecute;