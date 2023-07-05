#include "script_component.hpp"
/*
 * Author: Blue
 * Open EKG
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Monitor source <OBJECT> // TODO HEADER
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_openEKG;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_source",0]];

#define __GUI_GRID_W (safezoneW * 0.55)
#define __GUI_GRID_H (__GUI_GRID_W * 4/3)
#define __GUI_GRID_X (safezoneX + (safezoneW - __GUI_GRID_W) / 2)
#define __GUI_GRID_Y (safezoneY + (safezoneH - __GUI_GRID_H) / 2)

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening
 
if (dialog) then { // If another dialog is open (medical menu) close it
	closeDialog 0;
};

GVAR(AEDX_MonitorTarget) = _patient;

createDialog QGVAR(AEDX_Monitor_Dialog);

private _dlg = findDisplay 69000;

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
	_args params ["_dlg","_patient"];

	private _pads = _patient getVariable [QGVAR(DefibrillatorPads_Connected), false];

	if (isNull _dlg) exitWith {
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};

	if !(_pads) then {
		ctrlSetText [69021, "Check Pads"];
		ctrlSetText [69020, QPATHTOF(ui\ekg_off.paa)];
    } else {
		ctrlSetText [69021, ""];
		private _ekgDisplay = QPATHTOF(ui\ekg_off.paa);

		switch (_patient getVariable [QGVAR(cardiacArrestType), 0]) do {
			case 4: {_ekgDisplay = QPATHTOF(ui\ekg_vt.paa);};
			case 3: {_ekgDisplay = QPATHTOF(ui\ekg_vf.paa);};
			case 1: {_ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);};
			default {
                if(_patient getVariable [QACEGVAR(medical,inCardiacArrest), false] || !(alive _patient)) then {
                    _ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);
                } else {
                    _ekgDisplay = QPATHTOF(ui\ekg_sinus.paa);
                };
            };
		};

		ctrlSetText [69020, _ekgDisplay];
	};

	// Handle date and time display - [year,month,day,hour,min]

	ctrlSetText [69017, format ["%1/%2/%3               %4:%5", (if (date select 2 < 10) then { "0" } else { "" }) + str (date select 2), (if (date select 1 < 10) then { "0" } else { "" }) + str (date select 1), date select 0, (if (date select 3 < 10) then { "0" } else { "" }) + str (date select 3), (if (date select 4 < 10) then { "0" } else { "" }) + str (date select 4)]];
	ctrlSetText [69018, format ["%1:%2:%3", (if ((floor(time/3600)) < 10) then { "0" } else { "" }) + str (floor(time/3600)), (if ((floor(((time/3600) - floor(time/3600)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((time/3600) - floor(time/3600)) * 60)), (if ((floor(((time/60) - floor(time/60)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((time/60) - floor(time/60)) * 60))]];
	
}, 0, [_dlg, _patient]] call CBA_fnc_addPerFrameHandler;

[{
	params ["_args", "_idPFH"];
	_args params ["_dlg","_patient"];

	private _pads = _patient getVariable [QGVAR(DefibrillatorPads_Connected), false];

    private _hr = 0;
    private _bp = [0,0];

    if (_patient getVariable [QGVAR(cardiacArrestType), 0] in [2,4]) then {
        _hr = _patient call FUNC(getCardiacArrestHeartRate);
        _bp = [0,0];

        if (_patient getVariable [QGVAR(cardiacArrestType), 0] isEqualTo [4]) then {
            _bp = [random [0,4,10], random [4,12,20]];
        };
    } else {
        _hr = _patient getVariable [QACEGVAR(medical,heartRate), 0];
        _bp = _patient getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
    };

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

	ctrlSetText [69011, format["%1", round(_hr)]];

	if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
		ctrlSetText [69012, format["%1", round(_bp select 1)]];
		ctrlSetText [69013, format["%1", round(_bp select 0)]];
		ctrlSetText [69014, format["(%1)", round(((_bp select 1) - (_bp select 0))/3 + (_bp select 0))]];
		ctrlSetText [69016, format["%1", round(_patient getVariable [QEGVAR(breathing,airwayStatus), 100])]];
	};
}, 1, [_dlg, _patient]] call CBA_fnc_addPerFrameHandler;