#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
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

params ["_medic", "_patient", "_bodyPart", "", "", "_usedItem"];

_patient setVariable [QGVAR(IVplaced), true, true];

if (_usedItem == "kat_IV_16") then {
    switch (_bodyPart) do {
    	case "leftarm": {_patient setVariable [QGVAR(IVsite), 2, true];
    	};
    	case "rightarm": {_patient setVariable [QGVAR(IVsite), 3, true];
    	};
    	case "leftleg": {_patient setVariable [QGVAR(IVsite), 4, true];
    	};
    	case "rightleg": {_patient setVariable [QGVAR(IVsite), 5, true];
    	};
    };

    [_patient, "activity", LSTRING(iv_log), [[_medic] call ace_common_fnc_getName, "16g IV"]] call ace_medical_treatment_fnc_addToLog;
    [_patient, "16g IV"] call ace_medical_treatment_fnc_addToTriageCard;
} else {
    _patient setVariable [QGVAR(IVsite), 1, true];

    [_patient, 0.6] call ace_medical_status_fnc_adjustPainLevel;

    [_patient, "activity", LSTRING(iv_log), [[_medic] call ace_common_fnc_getName, "FAST IO"]] call ace_medical_treatment_fnc_addToLog;
    [_patient, "FAST IO"] call ace_medical_treatment_fnc_addToTriageCard;
};

[{
    private _patient = _this select 0;
    [_patient, _patient] call FUNC(retrieveIV);
}, [_patient], GVAR(IVdrop)] call CBA_fnc_waitAndExecute;

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_bodyPart"];

    private _alive = alive _patient;
    private _IVstatus = _patient getVariable[QGVAR(IVplaced), false];

    if ((!_alive) || (!_IVstatus)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;        
		_patient setVariable [QGVAR(IVplaced), false, true];
		_patient setVariable [QGVAR(IVsite), 0, true];
    };

	if ([_patient, _bodyPart] call ace_medical_treatment_fnc_hasTourniquetAppliedTo) then {
		_patient setVariable [QGVAR(flowRate), 0, true]
	} else {
		_patient setVariable [QGVAR(flowRate), ace_medical_ivFlowRate, true];
	};
}, 2, [_patient, _bodyPart]] call CBA_fnc_addPerFrameHandler;