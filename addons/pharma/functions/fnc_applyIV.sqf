#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_applyIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_usedItem"];

if (_patient getVariable ["kat_IVPharma_PFH", false]) exitWith {};
_patient setVariable ["kat_IVPharma_PFH", true];

_patient setVariable [QGVAR(IVplaced), true, true];

private _active = _patient getVariable [QGVAR(active), false];

if (_active) then {
    _patient setVariable [QGVAR(active), false, true];
};

if (_usedItem isEqualTo "kat_IV_16") then {
    switch (_bodyPart) do {
    	case "leftarm": {
    	    _patient setVariable [QGVAR(IVsite), 2, true];
    	};
    	case "rightarm": {
    	    _patient setVariable [QGVAR(IVsite), 3, true];
    	};
    	case "leftleg": {
    	    _patient setVariable [QGVAR(IVsite), 4, true];
    	};
    	case "rightleg": {
    	    _patient setVariable [QGVAR(IVsite), 5, true];
    	};
    };

    [_patient, "activity", LSTRING(iv_log), [[_medic] call ace_common_fnc_getName, "16g IV"]] call ace_medical_treatment_fnc_addToLog;
    [_patient, "16g IV"] call ace_medical_treatment_fnc_addToTriageCard;
} else {
    _patient setVariable [QGVAR(IVsite), 1, true];

    [_patient, 0.8] call ace_medical_status_fnc_adjustPainLevel;

    [_patient, "activity", LSTRING(iv_log), [[_medic] call ace_common_fnc_getName, "FAST IO"]] call ace_medical_treatment_fnc_addToLog;
    [_patient, "FAST IO"] call ace_medical_treatment_fnc_addToTriageCard;
};


if (GVAR(IVdropEnable)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        _patient setVariable [QGVAR(active), true, true];

        [{
            params ["_args", "_idPFH"];
            _args params ["_patient"];

            private _bloodBags = _patient getVariable ["ace_medical_ivBags", []];

            if !(_patient getVariable [QGVAR(IVplaced), false]) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            if !(_patient getVariable [QGVAR(active), false]) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            if (_bloodBags isEqualTo []) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
                private _site = _patient getVariable [QGVAR(IVsite), 0];

                if (_site == 1) then {
                    _patient addItem "kat_IO_FAST";
                } else {
                    _patient addItem "kat_IV_16";
                };

                _patient setVariable [QGVAR(IVplaced), false, true];
                _patient setVariable [QGVAR(IVsite), 0, true];
                _patient setVariable [QGVAR(active), false, true];
                _patient setVariable ["kat_IVPharma_PFH", nil];
            };
        }, GVAR(IVdrop), [_patient]] call CBA_fnc_addPerFrameHandler;

    }, [_patient], GVAR(IVdrop)] call CBA_fnc_waitAndExecute;
};