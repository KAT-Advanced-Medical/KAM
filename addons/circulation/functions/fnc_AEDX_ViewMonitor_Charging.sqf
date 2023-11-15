#include "..\script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Blue
 * Handle monitor visuals while charging
 *
 * Arguments:
 * 0: Skip charging <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call kat_circulation_fnc_AEDX_ViewMonitor_Charging;
 *
 * Public: No
 */

params [["_skip", false]];

private _dlg = findDisplay IDC_AEDX_MONITOR;

GVAR(AEDX_MonitorCharging) = true;
GVAR(AEDX_MonitorCharged) = false;
GVAR(AEDX_MonitorShockAdministered) = false;

private _fnc_showDialog = {
    params ["_show"];

    ctrlShow [IDC_CHARGE_BBACKGROUND, _show];
    ctrlShow [IDC_CHARGE_BBACKGROUND2, _show];
    ctrlShow [IDC_CHARGE_STATUS_TITLE, _show];
    ctrlShow [IDC_CHARGE_STATUS, _show];
    ctrlShow [IDC_CHARGE_ENERGY_SELECT, _show];
    ctrlShow [IDC_CHARGE_ENERGY_AMOUNT, _show];
    ctrlShow [IDC_CHARGE_BAR_BACKGROUND, _show];
    ctrlShow [IDC_CHARGE_SHOCKTOTAL, _show];

    ctrlShow [IDC_CHARGE_BACKGROUND, _show];
    ctrlShow [IDC_CHARGE_BAR_1, _show];
    ctrlShow [IDC_CHARGE_BAR_2, _show];
    ctrlShow [IDC_CHARGE_BAR_3, _show];
    ctrlShow [IDC_CHARGE_BAR_4, _show];
    ctrlShow [IDC_CHARGE_BAR_5, _show];
    ctrlShow [IDC_CHARGE_BAR_6, _show];
    ctrlShow [IDC_CHARGE_BAR_7, _show];
    ctrlShow [IDC_CHARGE_BAR_8, _show];
    ctrlShow [IDC_CHARGE_BAR_9, _show];
    ctrlShow [IDC_CHARGE_BAR_10, _show];
    ctrlShow [IDC_CHARGE_BAR_15, _show];
    ctrlShow [IDC_CHARGE_BAR_20, _show];
    ctrlShow [IDC_CHARGE_BAR_30, _show];
    ctrlShow [IDC_CHARGE_BAR_50, _show];
    ctrlShow [IDC_CHARGE_BAR_70, _show];
    ctrlShow [IDC_CHARGE_BAR_85, _show];
    ctrlShow [IDC_CHARGE_BAR_100, _show];
    ctrlShow [IDC_CHARGE_BAR_120, _show];
    ctrlShow [IDC_CHARGE_BAR_150, _show];
    ctrlShow [IDC_CHARGE_BAR_200, _show];
};

[true] call _fnc_showDialog;

private _chargeBar = (_dlg displayCtrl IDC_CHARGE_BAR_BACKGROUND);

ctrlSetText [IDC_CHARGE_SHOCKTOTAL, format ["%1", GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_ShockAmount), 0]]];

if (_skip) then { // Skip visual charging process
    _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(681), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(679)];
    _chargeBar ctrlCommit 0;

    (_dlg displayCtrl IDC_CHARGE_BAR_1) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_2) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_3) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_4) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_5) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_6) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_7) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_8) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_9) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_10) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_15) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_20) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_30) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_50) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_70) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_85) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_100) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_120) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_150) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl IDC_CHARGE_BAR_150) ctrlSetBackgroundColor [1, 0.35, 0, 1];

    GVAR(AEDX_MonitorCharging) = false;
    GVAR(AEDX_MonitorCharged) = true;

    [{
        if (GVAR(AEDX_MonitorCharged)) then {
            GVAR(AEDX_MonitorCharged) = false;
        };
    }, [], 20] call CBA_fnc_waitAndExecute;
} else {
    switchColor = false;
    switchDelay = false;

    [{
        params ["_args", "_idPFH"];
        _args params ["_dlg"];

        if (isNull _dlg) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if !(GVAR(AEDX_MonitorCharging)) exitWith {
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [1, 0.35, 0, 1];

            (_dlg displayCtrl IDC_CHARGE_ENERGY_AMOUNT) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_ENERGY_AMOUNT) ctrlSetBackgroundColor [1, 0.35, 0, 1];

            ctrlSetText [IDC_CHARGE_STATUS, LLSTRING(AEDX_Monitor_CHARGED)];

            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (switchColor) then {
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [1, 0.35, 0, 1];
            switchColor = false;
        } else {
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [0, 0, 0, 0];
            switchColor = true;
        };
    }, 0.5, [_dlg]] call CBA_fnc_addPerFrameHandler;

    [{
        params ["_dlg"];

        isNull _dlg || !(GVAR(AEDX_MonitorCharging));
    }, {
        params ["_dlg"];

        if !(isNull _dlg) then {
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [1, 0.35, 0, 1];

            (_dlg displayCtrl IDC_CHARGE_ENERGY_AMOUNT) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_ENERGY_AMOUNT) ctrlSetBackgroundColor [1, 0.35, 0, 1];

            ctrlSetText [IDC_CHARGE_STATUS, LLSTRING(AEDX_Monitor_CHARGED)];
        };

    }, [_dlg], 60, {}] call CBA_fnc_waitUntilAndExecute;

    [{
        GVAR(AEDX_MonitorCharging) = false;
        GVAR(AEDX_MonitorCharged) = true;
        [{ // Auto disarm timer
            if (GVAR(AEDX_MonitorCharged) && !(GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false])) then {
                GVAR(AEDX_MonitorCharged) = false;
                GVAR(AEDX_MonitorShockAdministered) = false;
            };
        }, [], 20.3] call CBA_fnc_waitAndExecute;
    }, [], 4] call CBA_fnc_waitAndExecute;

    // Begin bar charge
    [{
        params ["_dlg", "_chargeBar"];

        (_dlg displayCtrl IDC_CHARGE_BAR_1) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_2) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_3) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_4) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_5) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_6) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_7) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl IDC_CHARGE_BAR_8) ctrlSetTextColor [0, 0, 0, 1];

        _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(1089), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(271)];
        _chargeBar ctrlCommit 0;

        [{
            params ["_dlg", "_chargeBar"];

            (_dlg displayCtrl IDC_CHARGE_BAR_9) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_10) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_15) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_20) ctrlSetTextColor [0, 0, 0, 1];

            _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(953), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(407)];
            _chargeBar ctrlCommit 0;

            [{
                params ["_dlg", "_chargeBar"];

                (_dlg displayCtrl IDC_CHARGE_BAR_30) ctrlSetTextColor [0, 0, 0, 1];

                _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(918), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(442)];
                _chargeBar ctrlCommit 0;

                [{
                    params ["_dlg", "_chargeBar"];

                    (_dlg displayCtrl IDC_CHARGE_BAR_50) ctrlSetTextColor [0, 0, 0, 1];

                    _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(884), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(476)];
                    _chargeBar ctrlCommit 0;

                    [{
                        params ["_dlg", "_chargeBar"];

                        (_dlg displayCtrl IDC_CHARGE_BAR_70) ctrlSetTextColor [0, 0, 0, 1];
                        (_dlg displayCtrl IDC_CHARGE_BAR_85) ctrlSetTextColor [0, 0, 0, 1];

                        _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(817), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(543)];
                        _chargeBar ctrlCommit 0;

                        [{
                            params ["_dlg", "_chargeBar"];

                            (_dlg displayCtrl IDC_CHARGE_BAR_100) ctrlSetTextColor [0, 0, 0, 1];

                            _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(782), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(578)];
                            _chargeBar ctrlCommit 0;

                            [{
                                params ["_dlg", "_chargeBar"];

                                (_dlg displayCtrl IDC_CHARGE_BAR_120) ctrlSetTextColor [0, 0, 0, 1];

                                _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(748), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(612)];
                                _chargeBar ctrlCommit 0;

                                [{
                                    params ["_dlg", "_chargeBar"];

                                    (_dlg displayCtrl IDC_CHARGE_BAR_150) ctrlSetTextColor [0, 0, 0, 1];
                                    (_dlg displayCtrl IDC_CHARGE_BAR_150) ctrlSetBackgroundColor [1, 0.35, 0, 1];

                                    _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(680), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(680)];
                                    _chargeBar ctrlCommit 0;
                                }, [_dlg, _chargeBar], 0.5] call CBA_fnc_waitAndExecute;
                            }, [_dlg, _chargeBar], 0.6] call CBA_fnc_waitAndExecute;
                        }, [_dlg, _chargeBar], 0.6] call CBA_fnc_waitAndExecute;
                    }, [_dlg, _chargeBar], 0.6] call CBA_fnc_waitAndExecute;
                }, [_dlg, _chargeBar], 0.5] call CBA_fnc_waitAndExecute;
            }, [_dlg, _chargeBar], 0.4] call CBA_fnc_waitAndExecute;
        }, [_dlg, _chargeBar], 0.3] call CBA_fnc_waitAndExecute;
    }, [_dlg, _chargeBar], 0.1] call CBA_fnc_waitAndExecute;
};

// Clear everything after administering shock
[{
    params ["_dlg"];

    isNull _dlg || (!(GVAR(AEDX_MonitorCharging)) && !(GVAR(AEDX_MonitorCharged)));
}, {
    params ["_dlg", "_chargeBar", "_fnc_showDialog"];

    if !(isNull _dlg) then {
        if (GVAR(AEDX_MonitorShockAdministered)) then {
            ctrlSetText [IDC_CHARGE_STATUS, LLSTRING(AEDX_Monitor_DeliveredEnergy)];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [0.05, 0.85, 0.36, 1];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetFontHeight (GRID_H * 1.1);
        } else {
            ctrlSetText [IDC_CHARGE_STATUS, LLSTRING(AEDX_Monitor_DISARMED)];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [0.94, 0.94, 0.03, 1];
        };

        [{
            params ["_dlg", "_chargeBar", "_fnc_showDialog"];

            [false] call _fnc_showDialog;

            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetBackgroundColor [1, 0.35, 0, 0];
            ctrlSetText [IDC_CHARGE_STATUS, LLSTRING(AEDX_Monitor_CHARGING)];
            (_dlg displayCtrl IDC_CHARGE_STATUS) ctrlSetFontHeight (GRID_H * 1.5);

            (_dlg displayCtrl IDC_CHARGE_ENERGY_AMOUNT) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_ENERGY_AMOUNT) ctrlSetBackgroundColor [0, 0, 0, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_1) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_2) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_3) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_4) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_5) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_6) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_7) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_8) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_9) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_10) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_15) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_20) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_30) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_50) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_70) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_85) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_100) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_120) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl IDC_CHARGE_BAR_150) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl IDC_CHARGE_BAR_150) ctrlSetBackgroundColor [0, 0, 0, 0];

            _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, KAT_pxToScreen_Y(1360), (ctrlPosition _chargeBar) select 2, KAT_pxToScreen_H(1)];
            _chargeBar ctrlCommit 0;
        }, [_dlg, _chargeBar, _fnc_showDialog], 1] call CBA_fnc_waitAndExecute;
    };
}, [_dlg, _chargeBar, _fnc_showDialog], 3600, {}] call CBA_fnc_waitUntilAndExecute;
