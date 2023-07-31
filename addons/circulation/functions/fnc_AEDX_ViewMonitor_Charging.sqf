#include "script_component.hpp"
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

private _dlg = findDisplay 69000;

GVAR(AEDX_MonitorCharging) = true;
GVAR(AEDX_MonitorCharged) = false;
GVAR(AEDX_MonitorShockAdministered) = false;

fnc_showDialog = {
    params ["_show"];

    ctrlShow [69030, _show];
    ctrlShow [69031, _show];
    ctrlShow [69032, _show];
    ctrlShow [69033, _show];
    ctrlShow [69034, _show];
    ctrlShow [69035, _show];
    ctrlShow [69036, _show];
    ctrlShow [69037, _show];

    ctrlShow [69040, _show];
    ctrlShow [69041, _show];
    ctrlShow [69042, _show];
    ctrlShow [69043, _show];
    ctrlShow [69044, _show];
    ctrlShow [69045, _show];
    ctrlShow [69046, _show];
    ctrlShow [69047, _show];
    ctrlShow [69048, _show];
    ctrlShow [69049, _show];
    ctrlShow [69050, _show];
    ctrlShow [69051, _show];
    ctrlShow [69052, _show];
    ctrlShow [69053, _show];
    ctrlShow [69054, _show];
    ctrlShow [69055, _show];
    ctrlShow [69056, _show];
    ctrlShow [69057, _show];
    ctrlShow [69058, _show];
    ctrlShow [69059, _show];
    ctrlShow [69060, _show];
};

[true] call fnc_showDialog;

private _chargeBar = (_dlg displayCtrl 69036);

ctrlSetText [69037, format ["%1", GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_ShockAmount), 0]]];

if (_skip) then { // Skip visual charging process
    _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(681), (ctrlPosition _chargeBar) select 2, pxToScreen_H(679)];
    _chargeBar ctrlCommit 0;

    (_dlg displayCtrl 69041) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69042) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69043) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69044) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69045) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69046) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69047) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69048) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69049) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69050) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69051) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69052) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69053) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69054) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69055) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69056) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69057) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69058) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69059) ctrlSetTextColor [0, 0, 0, 1];
    (_dlg displayCtrl 69059) ctrlSetBackgroundColor [1, 0.35, 0, 1];

    GVAR(AEDX_MonitorCharging) = false;
    GVAR(AEDX_MonitorCharged) = true;

    [{
        if(GVAR(AEDX_MonitorCharged)) then {
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
            (_dlg displayCtrl 69033) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl 69033) ctrlSetBackgroundColor [1, 0.35, 0, 1];

            (_dlg displayCtrl 69035) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl 69035) ctrlSetBackgroundColor [1, 0.35, 0, 1];

            ctrlSetText [69033, "CHARGED"];

            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (switchColor) then {
            (_dlg displayCtrl 69033) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl 69033) ctrlSetBackgroundColor [1, 0.35, 0, 1];
            switchColor = false;
        } else {
            (_dlg displayCtrl 69033) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69033) ctrlSetBackgroundColor [0, 0, 0, 0];
            switchColor = true;
        };
    }, 0.5, [_dlg]] call CBA_fnc_addPerFrameHandler;

    [{
        GVAR(AEDX_MonitorCharging) = false;
        GVAR(AEDX_MonitorCharged) = true;
        [{ // Auto disarm timer
            if(GVAR(AEDX_MonitorCharged) && !(GVAR(AEDX_MonitorTarget) getVariable [QGVAR(Defibrillator_Charged), false])) then {
                GVAR(AEDX_MonitorCharged) = false;
                GVAR(AEDX_MonitorShockAdministered) = false;
            };
        }, [], 20.3] call CBA_fnc_waitAndExecute;
    }, [], 4] call CBA_fnc_waitAndExecute;

    // Begin bar charge
    [{
        params ["_dlg", "_chargeBar"];

        (_dlg displayCtrl 69041) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69042) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69043) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69044) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69045) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69046) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69047) ctrlSetTextColor [0, 0, 0, 1];
        (_dlg displayCtrl 69048) ctrlSetTextColor [0, 0, 0, 1];

        _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(1089), (ctrlPosition _chargeBar) select 2, pxToScreen_H(271)];
        _chargeBar ctrlCommit 0;

        [{
            params ["_dlg", "_chargeBar"];

            (_dlg displayCtrl 69049) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl 69050) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl 69051) ctrlSetTextColor [0, 0, 0, 1];
            (_dlg displayCtrl 69052) ctrlSetTextColor [0, 0, 0, 1];

            _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(953), (ctrlPosition _chargeBar) select 2, pxToScreen_H(407)];
            _chargeBar ctrlCommit 0;

            [{
                params ["_dlg", "_chargeBar"];

                (_dlg displayCtrl 69053) ctrlSetTextColor [0, 0, 0, 1];

                _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(918), (ctrlPosition _chargeBar) select 2, pxToScreen_H(442)];
                _chargeBar ctrlCommit 0;

                [{
                    params ["_dlg", "_chargeBar"];

                    (_dlg displayCtrl 69054) ctrlSetTextColor [0, 0, 0, 1];

                    _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(884), (ctrlPosition _chargeBar) select 2, pxToScreen_H(476)];
                    _chargeBar ctrlCommit 0;

                    [{
                        params ["_dlg", "_chargeBar"];

                        (_dlg displayCtrl 69055) ctrlSetTextColor [0, 0, 0, 1];
                        (_dlg displayCtrl 69056) ctrlSetTextColor [0, 0, 0, 1];

                        _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(817), (ctrlPosition _chargeBar) select 2, pxToScreen_H(543)];
                        _chargeBar ctrlCommit 0;

                        [{
                            params ["_dlg", "_chargeBar"];

                            (_dlg displayCtrl 69057) ctrlSetTextColor [0, 0, 0, 1];

                            _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(782), (ctrlPosition _chargeBar) select 2, pxToScreen_H(578)];
                            _chargeBar ctrlCommit 0;

                            [{
                                params ["_dlg", "_chargeBar"];

                                (_dlg displayCtrl 69058) ctrlSetTextColor [0, 0, 0, 1];

                                _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(748), (ctrlPosition _chargeBar) select 2, pxToScreen_H(612)];
                                _chargeBar ctrlCommit 0;

                                [{
                                    params ["_dlg", "_chargeBar"];

                                    (_dlg displayCtrl 69059) ctrlSetTextColor [0, 0, 0, 1];
                                    (_dlg displayCtrl 69059) ctrlSetBackgroundColor [1, 0.35, 0, 1];

                                    _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(680), (ctrlPosition _chargeBar) select 2, pxToScreen_H(680)];
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
    params ["_dlg", "_chargeBar"];

    if !(isNull _dlg) then {
        if(GVAR(AEDX_MonitorShockAdministered)) then {
            ctrlSetText [69033, "Delivered Energy"];
            (_dlg displayCtrl 69033) ctrlSetBackgroundColor [0.05, 0.85, 0.36, 1];
            (_dlg displayCtrl 69033) ctrlSetFontHeight (GRID_H * 1.1);
        } else {
            ctrlSetText [69033, "DISARMED"];
            (_dlg displayCtrl 69033) ctrlSetBackgroundColor [0.94, 0.94, 0.03, 1];
        };

        [{
            params ["_dlg", "_chargeBar"];

            [false] call fnc_showDialog;

            (_dlg displayCtrl 69033) ctrlSetBackgroundColor [1, 0.35, 0, 0];
            ctrlSetText [69033, "CHARGING"];
            (_dlg displayCtrl 69033) ctrlSetFontHeight (GRID_H * 1.5);

            (_dlg displayCtrl 69035) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69035) ctrlSetBackgroundColor [0, 0, 0, 1];

            (_dlg displayCtrl 69041) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69042) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69043) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69044) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69045) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69046) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69047) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69048) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69049) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69050) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69051) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69052) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69053) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69054) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69055) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69056) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69057) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69058) ctrlSetTextColor [1, 1, 1, 1];

            (_dlg displayCtrl 69059) ctrlSetTextColor [1, 1, 1, 1];
            (_dlg displayCtrl 69059) ctrlSetBackgroundColor [0, 0, 0, 0];

            _chargeBar ctrlSetPosition [(ctrlPosition _chargeBar) select 0, pxToScreen_Y(1360), (ctrlPosition _chargeBar) select 2, pxToScreen_H(1)];
            _chargeBar ctrlCommit 0;
        }, [_dlg, _chargeBar], 1] call CBA_fnc_waitAndExecute;
    };
}, [_dlg, _chargeBar], 3600, {}] call CBA_fnc_waitUntilAndExecute;