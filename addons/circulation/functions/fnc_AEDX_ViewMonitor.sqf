#include "..\script_component.hpp"
#include "..\defines.hpp"
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
    case 1: {
        _patient = _target getVariable [QGVAR(Defibrillator_Patient), objNull];
        if (_patient isEqualTo objNull) then {
            _patient = _target getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull];
        };
    }; // Placed
    case 2: {
        _patient = _medic getVariable [QGVAR(MedicDefibrillator_Patient), objNull];
        if (_patient isEqualTo objNull) then {
            _patient = _medic getVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), objNull];
        };
    }; // Self-interaction (medic)
    default {}; // Direct (patient)
};

GVAR(AEDX_MonitorTarget) = _patient;

createDialog QGVAR(AEDX_Monitor_Dialog);

private _dlg = findDisplay IDC_AEDX_MONITOR;

GVAR(PulseRateReady) = true;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg"];

    if (isNull _dlg) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _slider = _dlg displayCtrl IDC_EKG_SLIDER;

    _slider ctrlSetPosition [KAT_pxToScreen_X(250), (ctrlPosition _slider) select 1, (ctrlPosition _slider) select 2, (ctrlPosition _slider) select 3];
    _slider ctrlCommit 0;

    _slider ctrlSetPosition [KAT_pxToScreen_X(1460), (ctrlPosition _slider) select 1, (ctrlPosition _slider) select 2, (ctrlPosition _slider) select 3];
    _slider ctrlCommit 4;
}, 4, [_dlg]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg", "_target", "_source"];

    if (isNull _dlg) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _pads = false;

    if !(GVAR(AEDX_MonitorTarget) isEqualTo objNull) then {
        _pads = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(DefibrillatorPads_Connected), false];
    };

    if !(_pads) then {
        ctrlSetText [IDC_EKG_DISPLAY_MIDTEXT, LLSTRING(AEDX_Monitor_CheckPads)];
        ctrlSetText [IDC_EKG_DISPLAY, QPATHTOF(ui\ekg_off.paa)];
    } else {
        ctrlSetText [IDC_EKG_DISPLAY_MIDTEXT, ""];
        private _ekgDisplay = QPATHTOF(ui\ekg_off.paa);

        if !(GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then {
            _ekgDisplay = QPATHTOF(ui\ekg_cpr.paa);
        } else {
            if !(GVAR(AEDX_MonitorTarget) getVariable [QGVAR(heartRestart), false]) then {
                switch (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0]) do {
                    case 4: {_ekgDisplay = QPATHTOF(ui\ekg_vt.paa);};
                    case 3: {_ekgDisplay = QPATHTOF(ui\ekg_vf.paa);};
                    case 2: {_ekgDisplay = QPATHTOF(ui\ekg_sinus.paa);};
                    case 1: {_ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);};
                    default {
                        if ((GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,inCardiacArrest), false] && !(GVAR(AdvRhythm))) || !(alive GVAR(AEDX_MonitorTarget))) then {
                            _ekgDisplay = QPATHTOF(ui\ekg_asystole.paa);
                        } else {
                            private _hr = 0;
                            if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 2) then {
                                _hr = GVAR(AEDX_MonitorTarget) call FUNC(getCardiacArrestHeartRate);
                            } else {
                                _hr = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0];
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

        ctrlSetText [IDC_EKG_DISPLAY, _ekgDisplay];

        if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false]) then {
            ctrlShow [IDC_SHOCKBUTTON, true];
        } else {
            ctrlShow [IDC_SHOCKBUTTON, false];
        };
    };

    // Handle date and time display - [year,month,day,hour,min]

    ctrlSetText [IDC_DISPLAY_DATEANDTIME, format ["%1/%2/%3               %4:%5", (["", "0"] select (date select 2 < 10)) + str (date select 2), (["", "0"] select (date select 1 < 10)) + str (date select 1), date select 0, (["", "0"] select (date select 3 < 10)) + str (date select 3), (["", "0"] select (date select 4 < 10)) + str (date select 4)]];
    ctrlSetText [IDC_DISPLAY_ELAPSEDTIME, format ["%1:%2:%3", (["", "0"] select (floor time / 3600 < 10)) + str (floor(time/3600)), (["", "0"] select (floor time / 3600 - floor time / 3600 * 60 < 10)) + str (floor(((time/3600) - floor(time/3600)) * 60)), (["", "0"] select (floor time / 60 - floor time / 60 * 60 < 10)) + str (floor(((time/60) - floor(time/60)) * 60))]];

    if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
        private _partIndex = ((GVAR(AEDX_MonitorTarget) getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [-1, -1, -1]]) select 2);

        ctrlShow [IDC_DISPLAY_PULSERATEBORDER, true];
        ctrlShow [IDC_DISPLAY_PULSERATEBG, true];
        ctrlShow [IDC_DISPLAY_PULSERATEDSPBAR, true];
        ctrlShow [IDC_DISPLAY_PULSERATEBAR, true];

        private _PRBar = _dlg displayCtrl IDC_DISPLAY_PULSERATEBAR;

        if (!(HAS_TOURNIQUET_APPLIED_ON(GVAR(AEDX_MonitorTarget),_partIndex))) then {
            if (GVAR(PulseRateReady)) then {
                GVAR(PulseRateReady) = false;
                private _pr = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0];

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
        ctrlShow [IDC_DISPLAY_PULSERATEBORDER, false];
        ctrlShow [IDC_DISPLAY_PULSERATEBG, false];
        ctrlShow [IDC_DISPLAY_PULSERATEDSPBAR, false];
        ctrlShow [IDC_DISPLAY_PULSERATEBAR, false];
    };
}, 0, [_dlg, _target, _source]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_dlg"];

    private _pads = false;
    private _vitalsMonitor = false;

    if !(GVAR(AEDX_MonitorTarget) isEqualTo objNull) then {
        _pads = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(DefibrillatorPads_Connected), false];
        _vitalsMonitor = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false];
    };

    private _hr = 0;
    private _pr = 0;
    private _bp = [0,0];
    private _spO2 = 0;

    if (isNull _dlg) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (!_pads && !_vitalsMonitor) exitWith {
        ctrlSetText [IDC_DISPLAY_HEARTRATE, "---"];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_T, "---"];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_B, "---"];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_M, ""];
        ctrlSetText [IDC_DISPLAY_SPO2, "---"];
    };

    if !(GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then {

        private _rhythmHR = 0;

        if(GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0] > 0) then {
            _rhythmHR = GVAR(AEDX_MonitorTarget) call FUNC(getCardiacArrestHeartRate);
        } else {
            _rhythmHR = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0];
        };

        _hr = random [100, 100 + _rhythmHR / 2, _rhythmHR];

        if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
            _bp = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(StoredBloodPressure), [0,0]];
        } else {
            _bp = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
        };
    } else {
        if !(GVAR(AEDX_MonitorTarget) getVariable [QGVAR(heartRestart), false]) then {
            if (GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0] > 0) then {
                _hr = GVAR(AEDX_MonitorTarget) call FUNC(getCardiacArrestHeartRate);

                if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
                    _bp = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(StoredBloodPressure), [0,0]];
                };
            } else {
                _hr = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0];

                if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
                    _bp = GVAR(AEDX_MonitorTarget) getVariable [QGVAR(StoredBloodPressure), [0,0]];
                } else {
                    _bp = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
                };
            };
        };
    };

    private _partIndex = ((GVAR(AEDX_MonitorTarget) getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [-1, -1, -1]]) select 2);

    if (HAS_TOURNIQUET_APPLIED_ON(GVAR(AEDX_MonitorTarget),_partIndex)) then {
        _bp = [0,0];
    } else {
        _spO2 = GVAR(AEDX_MonitorTarget) getVariable [QEGVAR(breathing,airwayStatus), 100];
        _pr = GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0];
    };

    if (_pads) then {
        ctrlSetText [IDC_DISPLAY_HEARTRATE, format["%1", round(_hr)]];
        ctrlSetText [IDC_DISPLAY_HEARTRATE_TEXT, LLSTRING(AEDX_Monitor_HR)];
    } else {
        ctrlSetText [IDC_DISPLAY_HEARTRATE, format["%1", round(_pr)]];
        ctrlSetText [IDC_DISPLAY_HEARTRATE_TEXT, LLSTRING(AEDX_Monitor_PR)];
    };

    if (_vitalsMonitor) then {
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_T, format["%1", round(_bp select 1)]];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_B, format["%1", round(_bp select 0)]];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_M, format["(%1)", round(((_bp select 1) - (_bp select 0))/3 + (_bp select 0))]];
        ctrlSetText [IDC_DISPLAY_SPO2, format["%1", round(_spO2)]];
    } else {
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_T, "---"];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_B, "---"];
        ctrlSetText [IDC_DISPLAY_BLOODPRESSURE_M, ""];
        ctrlSetText [IDC_DISPLAY_SPO2, "---"];
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
