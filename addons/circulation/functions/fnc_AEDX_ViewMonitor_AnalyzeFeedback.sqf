#include "..\script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Blue
 * Handle displaying AED mode message on monitor screen
 *
 * Arguments:
 * 0: Hide AED mode feedback
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call kat_circulation_fnc_AEDX_ViewMonitor_AnalyzeFeedback;
 *
 * Public: No
 */

params [["_hide", false]];

private _dlg = findDisplay IDC_AEDX_MONITOR;

GVAR(AEDX_MonitorShockAdministered) = false;

private _fnc_showDialog = {
    params ["_show"];

    ctrlShow [IDC_AEDMODE_MSG_BG, _show];
    ctrlShow [IDC_AEDMODE_MSG_TOP, _show];
    ctrlShow [IDC_AEDMODE_MSG, _show];
    ctrlShow [IDC_CHARGE_BBACKGROUND, _show];
};

if (_hide) exitWith {
    [false] call _fnc_showDialog;
};

private _fnc_displayMsg = {
    params ["_dlg", "_msg"];

    switch (_msg) do {
        case 0: {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [0, 0, 0, 0];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, LLSTRING(AEDX_Monitor_ANALYZINGEKG)];
            ctrlSetText [IDC_AEDMODE_MSG, LLSTRING(AEDX_Monitor_StandClear)];
        };
        case 1: {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [0, 0.6, 0.84, 1];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, LLSTRING(AEDX_Monitor_NOSHOCKADVISED)];
            ctrlSetText [IDC_AEDMODE_MSG, LLSTRING(AEDX_Monitor_PerformCPR)];
        };
        case 2: {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [0, 0, 0, 0];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, LLSTRING(AEDX_Monitor_SHOCKADVISED)];
            ctrlSetText [IDC_AEDMODE_MSG, LLSTRING(AEDX_Monitor_CHARGING)];
        };
        case 3: {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [1, 0.35, 0, 1];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, LLSTRING(AEDX_Monitor_SHOCKADVISED)];
            ctrlSetText [IDC_AEDMODE_MSG, LLSTRING(AEDX_Monitor_PUSHSHOCK)];
        };
        case 4: {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [0.05, 0.85, 0.36, 1];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, LLSTRING(AEDX_Monitor_ENERGYDELIVERED)];
            ctrlSetText [IDC_AEDMODE_MSG, LLSTRING(AEDX_Monitor_PushAnalyze)];
        };
        case 5: {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [0.94, 0.94, 0.03, 1];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, LLSTRING(AEDX_Monitor_AED_DISARMED)];
            ctrlSetText [IDC_AEDMODE_MSG, LLSTRING(AEDX_Monitor_PushAnalyze)];
        };
        default {
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_AEDMODE_MSG_TOP) ctrlSetBackgroundColor [0, 0, 0, 0];
            ctrlSetText [IDC_AEDMODE_MSG_TOP, ""];
            ctrlSetText [IDC_AEDMODE_MSG, ""];
        };
    };
};

[true] call _fnc_showDialog;

[_dlg, 0] call _fnc_displayMsg;

[{
    GVAR(AEDX_MonitorTarget) getVariable [QGVAR(RhythmAnalyzed), false];
},
{
    params ["_dlg", "_fnc_displayMsg"];

    if ((GVAR(AdvRhythm) && GVAR(AEDX_MonitorTarget) getVariable [QGVAR(cardiacArrestType), 0] > 2) || (!(GVAR(AdvRhythm)) && GVAR(AEDX_MonitorTarget) getVariable [QACEGVAR(medical,heartRate), 0] isEqualTo 0)) then {
        [_dlg, 2] call _fnc_displayMsg;

        [{
            GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false];
        },
        {
            params ["_dlg", "_fnc_displayMsg"];

            [_dlg, 3] call _fnc_displayMsg;

            [{
                !(GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false]);
            },
            {
                params ["_dlg", "_fnc_displayMsg"];

                if (GVAR(AEDX_MonitorShockAdministered)) exitWith {
                    [_dlg, 4] call _fnc_displayMsg;
                };

                [_dlg, 5] call _fnc_displayMsg;
            }, [_dlg, _fnc_displayMsg], 20.3,
            {
                params ["_dlg", "_fnc_displayMsg"];

                [_dlg, 5] call _fnc_displayMsg;
            }] call CBA_fnc_waitUntilAndExecute;
        }, [_dlg, _fnc_displayMsg], 8] call CBA_fnc_waitUntilAndExecute;
    } else {
        [_dlg, 1] call _fnc_displayMsg;
    };
}, [_dlg, _fnc_displayMsg], 15] call CBA_fnc_waitUntilAndExecute;

[{
    params ["_dlg"];

    isNull _dlg;
},{
    params ["_dlg", "_fnc_displayMsg"];

    [_dlg, -1] call _fnc_displayMsg;
    [false] call _fnc_showDialog;
}, [_dlg, _fnc_displayMsg], 3600] call CBA_fnc_waitUntilAndExecute;
