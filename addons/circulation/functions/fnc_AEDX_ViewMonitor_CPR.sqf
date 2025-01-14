#include "..\script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Blue
 * Open AED-X Vitals Monitor dialog
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 1] call kat_circulation_fnc_AEDX_ViewMonitor;
 *
 * Public: No
 */

params ["_medic", "_target"];

GVAR(AEDX_MonitorTarget_Title) = _target;
GVAR(PulseRateReady) = true;

private _dlg = uiNamespace getVariable ["KAT_Circulation_AEDX_Monitor_Display", displayNull];

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg"];

    if !(GVAR(CPRDisplayActive)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _slider = _dlg displayCtrl IDC_EKG_SLIDER_TITLE;

    _slider ctrlSetPosition [KAT_pxToScreen_X(250), (ctrlPosition _slider) select 1, (ctrlPosition _slider) select 2, (ctrlPosition _slider) select 3];
    _slider ctrlCommit 0;

    _slider ctrlSetPosition [KAT_pxToScreen_X(1460), (ctrlPosition _slider) select 1, (ctrlPosition _slider) select 2, (ctrlPosition _slider) select 3];
    _slider ctrlCommit 4;
}, 4, [_dlg]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg", "_target"];

    if !(GVAR(CPRDisplayActive)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _pads = false;

    if !(GVAR(AEDX_MonitorTarget_Title) isEqualTo objNull) then {
        _pads = GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(DefibrillatorPads_Connected), false];
    };

    if !(_pads) then {
        (_dlg displayCtrl IDC_EKG_DISPLAY_MIDTEXT_TITLE) ctrlSetText (LLSTRING(AEDX_Monitor_CheckPads));
        (_dlg displayCtrl IDC_EKG_DISPLAY_TITLE) ctrlSetText (QPATHTOF(ui\ekg_off.paa));
    } else {
        (_dlg displayCtrl IDC_EKG_DISPLAY_MIDTEXT_TITLE) ctrlSetText "";
        private _ekgDisplay = QPATHTOF(ui\ekg_off.paa);

        if !(GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then {
            _ekgDisplay = QPATHTOF(ui\ekg_cpr.paa);
        } else {
            if (!(GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(heartRestart), false]) && alive GVAR(AEDX_MonitorTarget_Title)) then {
                switch (GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(cardiacArrestType), 0]) do {
                    case 4: {_ekgDisplay = QPATHTOF(ui\ekg_vt.paa);};
                    case 3: {_ekgDisplay = QPATHTOF(ui\ekg_vf.paa);};
                    case 2: {_ekgDisplay = QPATHTOF(ui\ekg_sinus.paa);};
                    case 1: {_ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);};
                    default {
                        if ((GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,inCardiacArrest), false] && !(GVAR(AdvRhythm))) || !(alive GVAR(AEDX_MonitorTarget_Title))) then {
                            _ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);
                        } else {
                            private _hr = 0;
                            if (GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 2) then {
                                _hr = GVAR(AEDX_MonitorTarget_Title) call FUNC(getCardiacArrestHeartRate);
                            } else {
                                _hr = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,heartRate), 0];
                            };

                            switch (true) do {
                                case (_hr > 130): {_ekgDisplay = QPATHTOF(ui\ekg_sinus_130.paa);};
                                case (_hr > 110 && _hr < 130): {_ekgDisplay = QPATHTOF(ui\ekg_sinus_120.paa);};
                                case (_hr > 90 && _hr < 110): {_ekgDisplay = QPATHTOF(ui\ekg_sinus_100.paa);};
                                case (_hr > 70 && _hr < 90): {_ekgDisplay = QPATHTOF(ui\ekg_sinus.paa);};
                                case (_hr > 50 && _hr < 70): {_ekgDisplay = QPATHTOF(ui\ekg_sinus_60.paa);};
                                case (_hr > 0): {_ekgDisplay = QPATHTOF(ui\ekg_sinus_40.paa);};
                                default {
                                    _ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);
                                };
                            };
                        };
                    };
                };
            } else {
                _ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);
            };
        };

        (_dlg displayCtrl IDC_EKG_DISPLAY_TITLE) ctrlSetText (_ekgDisplay);
    };

    // Handle date and time display - [year,month,day,hour,min]

    date params ["_year", "_month", "_day", "_hours", "_minutes"];
    (_dlg displayCtrl IDC_DISPLAY_DATEANDTIME_TITLE) ctrlSetText (format ["%1/%2/%3               %4:%5", [_day, 2] call CBA_fnc_formatNumber, [_month, 2] call CBA_fnc_formatNumber, _year, [_hours, 2] call CBA_fnc_formatNumber, [_minutes, 2] call CBA_fnc_formatNumber]);

    private _time = time;
    private _hours = floor (_time / 3600);
    private _minutes = floor ((_time / 60) - (_hours * 60));
    private _seconds = floor (_time % 60);
    (_dlg displayCtrl IDC_DISPLAY_ELAPSEDTIME_TITLE) ctrlSetText (format ["%1:%2:%3", [_hours, 2] call CBA_fnc_formatNumber, [_minutes, 2] call CBA_fnc_formatNumber, [_seconds, 2] call CBA_fnc_formatNumber]);

    if (GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
        private _partIndex = ((GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [-1, -1, -1]]) select 2);

        (_dlg displayCtrl IDC_DISPLAY_PULSERATEBORDER_TITLE) ctrlShow true;
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEBG_TITLE) ctrlShow true;
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEDSPBAR_TITLE) ctrlShow true;
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEBAR_TITLE) ctrlShow true;

        private _PRBar = _dlg displayCtrl IDC_DISPLAY_PULSERATEBAR_TITLE;

        if (!(HAS_TOURNIQUET_APPLIED_ON(GVAR(AEDX_MonitorTarget_Title),_partIndex))) then {
            if (GVAR(PulseRateReady)) then {
                GVAR(PulseRateReady) = false;
                private _pr = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,heartRate), 0];

                if (_pr > 0) then {
                    private _delay = 60/_pr;

                    private _randomHigh = round(random [2, 2, 3]);
                    _PRBar ctrlSetPosition [(ctrlPosition _PRBar) select 0, (ctrlPosition _PRBar) select 1, (ctrlPosition _PRBar) select 2, KAT_pxToScreen_H(_randomHigh)];
                    _PRBar ctrlCommit (0.2 max (_delay/4));

                    [{
                        params ["_PRBar", "_delay"];

                        private _randomMid = round(random [24, 25, 29]);

                        _PRBar ctrlSetPosition [(ctrlPosition _PRBar) select 0, (ctrlPosition _PRBar) select 1, (ctrlPosition _PRBar) select 2, KAT_pxToScreen_H(_randomMid)];
                        _PRBar ctrlCommit 0.1;

                        [{
                            params ["_PRBar", "_delay"];

                            private _randomLow = round(random [67, 68, 70]);
                            _PRBar ctrlSetPosition [(ctrlPosition _PRBar) select 0, (ctrlPosition _PRBar) select 1, (ctrlPosition _PRBar) select 2, KAT_pxToScreen_H(_randomLow)];
                            _PRBar ctrlCommit (0.2 max (_delay/2));
                        }, [_PRBar, _delay], 0.1] call CBA_fnc_waitAndExecute;
                    }, [_PRBar, _delay], (0.2 max (_delay/3))] call CBA_fnc_waitAndExecute;

                    [{
                        GVAR(PulseRateReady) = true;
                    }, [], _delay] call CBA_fnc_waitAndExecute;
                } else {
                    _PRBar ctrlSetPosition [(ctrlPosition _PRBar) select 0, (ctrlPosition _PRBar) select 1, (ctrlPosition _PRBar) select 2, KAT_pxToScreen_H(71)];
                    _PRBar ctrlCommit 0.1;

                    [{
                        GVAR(PulseRateReady) = true;
                    }, [], 0.1] call CBA_fnc_waitAndExecute;
                };
            };
        } else {
            _PRBar ctrlSetPosition [(ctrlPosition _PRBar) select 0, (ctrlPosition _PRBar) select 1, (ctrlPosition _PRBar) select 2, KAT_pxToScreen_H(71)];
            _PRBar ctrlCommit 0;
        };
    } else {
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEBORDER_TITLE) ctrlShow false;
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEBG_TITLE) ctrlShow false;
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEDSPBAR_TITLE) ctrlShow false;
        (_dlg displayCtrl IDC_DISPLAY_PULSERATEBAR_TITLE) ctrlShow false;
    };
}, 0, [_dlg, _target]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg"];

    private _pads = false;
    private _vitalsMonitor = false;

    if !(GVAR(AEDX_MonitorTarget_Title) isEqualTo objNull) then {
        _pads = GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(DefibrillatorPads_Connected), false];
        _vitalsMonitor = GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false];
    };

    private _hr = 0;
    private _pr = 0;
    private _bp = [0,0];
    private _spO2 = 0;

    if !(GVAR(CPRDisplayActive)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (!_pads && !_vitalsMonitor) exitWith {
        (_dlg displayCtrl IDC_DISPLAY_HEARTRATE_TITLE) ctrlSetText "---";
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_T_TITLE) ctrlSetText "---";
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_B_TITLE) ctrlSetText "---";
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_M_TITLE) ctrlSetText "";
        (_dlg displayCtrl IDC_DISPLAY_SPO2_TITLE) ctrlSetText "---";
    };

    if !(GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then {

        private _rhythmHR = 0;

        if(GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(cardiacArrestType), 0] > 0) then {
            _rhythmHR = GVAR(AEDX_MonitorTarget_Title) call FUNC(getCardiacArrestHeartRate);
        } else {
            _rhythmHR = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,heartRate), 0];
        };

        _hr = random [100, 100 + _rhythmHR / 2, _rhythmHR];

        if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
            _bp = GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(StoredBloodPressure), [0,0]];
        } else {
            _bp = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
        };
    } else {
        if !(GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(heartRestart), false]) then {
            if (GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(cardiacArrestType), 0] > 0) then {
                _hr = GVAR(AEDX_MonitorTarget_Title) call FUNC(getCardiacArrestHeartRate);

                if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
                    _bp = GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(StoredBloodPressure), [0,0]];
                };
            } else {
                _hr = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,heartRate), 0];

                if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
                    _bp = GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(StoredBloodPressure), [0,0]];
                } else {
                    _bp = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
                };
            };
        };
    };

    private _partIndex = ((GVAR(AEDX_MonitorTarget_Title) getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [-1, -1, -1]]) select 2);

    if (HAS_TOURNIQUET_APPLIED_ON(GVAR(AEDX_MonitorTarget_Title),_partIndex)) then {
        _bp = [0,0];
    } else {
        _spO2 = GET_KAT_SPO2(GVAR(AEDX_MonitorTarget_Title));
        _pr = GVAR(AEDX_MonitorTarget_Title) getVariable [QACEGVAR(medical,heartRate), 0];
    };

    if (_pads) then {
        (_dlg displayCtrl IDC_DISPLAY_HEARTRATE_TITLE) ctrlSetText (format["%1", round(_hr)]);
        (_dlg displayCtrl IDC_DISPLAY_HEARTRATE_TEXT_TITLE) ctrlSetText (LLSTRING(AEDX_Monitor_HR));
    } else {
        (_dlg displayCtrl IDC_DISPLAY_HEARTRATE_TITLE) ctrlSetText (format["%1", round(_pr)]);
        (_dlg displayCtrl IDC_DISPLAY_HEARTRATE_TEXT_TITLE) ctrlSetText (LLSTRING(AEDX_Monitor_PR));
    };

    if (_vitalsMonitor) then {
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_T_TITLE) ctrlSetText (format["%1", round(_bp select 1)]);
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_B_TITLE) ctrlSetText (format["%1", round(_bp select 0)]);
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_M_TITLE) ctrlSetText (format["(%1)", round(((_bp select 1) - (_bp select 0))/3 + (_bp select 0))]);
        (_dlg displayCtrl IDC_DISPLAY_SPO2_TITLE) ctrlSetText (format["%1", round(_spO2)]);
    } else {
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_T_TITLE) ctrlSetText "---";
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_B_TITLE) ctrlSetText "---";
        (_dlg displayCtrl IDC_DISPLAY_BLOODPRESSURE_M_TITLE) ctrlSetText "";
        (_dlg displayCtrl IDC_DISPLAY_SPO2_TITLE) ctrlSetText "---";
    };
}, 1, [_dlg]] call CBA_fnc_addPerFrameHandler;
