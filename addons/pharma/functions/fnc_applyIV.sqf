#include "..\script_component.hpp"
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
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_16"] call kat_circulation_fnc_applyIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_usedItem"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _IVpfh = _patient getVariable [QGVAR(IVpfh), [0,0,0,0,0,0]];
private _IVpfhActual = _IVpfh select _partIndex;
private _IVrate = _patient getVariable [QGVAR(IVrate), [0,0,0,0,0,0]];

if (_IVpfhActual > 0) then {
    [_IVpfhActual] call CBA_fnc_removePerFrameHandler;
    _IVpfhActual = 0;
    _IVpfh set [_partIndex, _IVpfhActual];
    _patient setVariable [QGVAR(IVpfh), _IVpfh, true];
} else {
    _IVpfhActual = _IVpfhActual - 1;
    _IVpfh set [_partIndex, _IVpfhActual];
    _patient setVariable [QGVAR(IVpfh), _IVpfh, true];
};
switch (_usedItem) do {
    case "kat_IV_16": {
        _IVarray set [_partIndex, 2];
        _IVrate set [_partIndex, 1];
        _patient setVariable [QGVAR(IV), _IVarray, true];
        _patient setVariable [QGVAR(IVrate), _IVrate, true];
        [_patient, "activity", LSTRING(iv_log), [[_medic] call ACEFUNC(common,getName), "16g IV"]] call ACEFUNC(medical_treatment,addToLog);
        [_patient, "16g IV"] call ACEFUNC(medical_treatment,addToTriageCard); };
        
    case "kat_IV_14": {     
        _IVarray set [_partIndex, 3];
        _IVrate set [_partIndex, 1.5];
        _patient setVariable [QGVAR(IV), _IVarray, true];
        _patient setVariable [QGVAR(IVrate), _IVrate, true];
        [_patient, "activity", LSTRING(iv_log), [[_medic] call ACEFUNC(common,getName), "14g IV"]] call ACEFUNC(medical_treatment,addToLog);
        [_patient, "14g IV"] call ACEFUNC(medical_treatment,addToTriageCard);};

    case "kat_IV_20": {     
        _IVarray set [_partIndex, 4];
        _IVrate set [_partIndex, 0.5];
        _patient setVariable [QGVAR(IV), _IVarray, true];
        _patient setVariable [QGVAR(IVrate), _IVrate, true];
        [_patient, "activity", LSTRING(iv_log), [[_medic] call ACEFUNC(common,getName), "20g IV"]] call ACEFUNC(medical_treatment,addToLog);
        [_patient, "20g IV"] call ACEFUNC(medical_treatment,addToTriageCard);};

    case "kat_IO_FAST": {
        _IVarray set [_partIndex, 1];
        _IVrate set [_partIndex, 0.4];
        _patient setVariable [QGVAR(IV), _IVarray, true];
        _patient setVariable [QGVAR(IVrate), _IVrate, true];
        private _medStack = _patient call ACEFUNC(medical_treatment,getAllMedication);
        private _medsToCheck = ["fentanyl", "ketamine", "nalbuphine", "morphine", "morphineIV"];
        private _fentanylEffectiveness = 0;
        private _ketamineEffectiveness = 0;
        private _nalbuphineEffectiveness = 0;
        private _morphineEffectiveness = 0;
        private _morphineIVEffectiveness = 0;
        {
            private _medName = toLower (_x select 0);
            private _effectiveness = _x select 2;
            if ("fentanyl" in _medName) then {
                _fentanylEffectiveness = _fentanylEffectiveness max _effectiveness;
            };
            if ("ketamine" in _medName) then {
                _ketamineEffectiveness = _ketamineEffectiveness max _effectiveness;
            };
            if ("nalbuphine" in _medName) then {
                _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
            };
            if ("morphine" in _medName) then {
                _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
            };
            if ("morphineIV" in _medName) then {
                _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
            };
        } forEach _medStack;
        if (
            _fentanylEffectiveness <= 0.8 &&
            _ketamineEffectiveness <= 0.8 &&
            _nalbuphineEffectiveness <= 0.8 &&
            _morphineEffectiveness <= 0.8 &&
            _morphineIVEffectiveness <= 0.8
        ) then {
            [_patient, [0.6, 0.7, 0.8] select (floor random 3)] call ACEFUNC(medical_status,adjustPainLevel);
        };
        [_patient, "activity", LSTRING(iv_log), [[_medic] call ACEFUNC(common,getName), "FAST IO"]] call ACEFUNC(medical_treatment,addToLog);
        [_patient, "FAST IO"] call ACEFUNC(medical_treatment,addToTriageCard);};
    default {};
};

if (GVAR(IVdropEnable) && ((_usedItem isEqualTo "kat_IV_16") || (_usedItem isEqualTo "kat_IV_14") || (_usedItem isEqualTo "kat_IV_20"))) then {
    [{
        params ["_patient", "_partIndex", "_IVpfhActual"];

        private _IVpfh = _patient getVariable [QGVAR(IVpfh), [0,0,0,0,0,0]];
        private _IVpfhCurrent = _IVpfh select _partIndex;

        if (_IVpfhCurrent == _IVpfhActual) then {
            [{
                params ["_args", "_idPFH"];
                _args params ["_patient", "_partIndex"];

                private _IVpfh = _patient getVariable [QGVAR(IVpfh), [0,0,0,0,0,0]];
                _IVpfh set [_partIndex, _idPFH];
                _patient setVariable [QGVAR(IVpfh), _IVpfh, true];

                private _bloodBags = _patient getVariable [QACEGVAR(medical,ivBags), []];

                if (_bloodBags isEqualTo []) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                    private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
                    private _IVactual = _IVarray select _partIndex;

                    if(GVAR(IVreuse)) then {
                        switch (_IVactual) do {
                        case "1": {_patient addItem "kat_IO_FAST"};
                        case "2": {_patient addItem "kat_IV_16"};
                        case "3": {_patient addItem "kat_IV_14"};
                        case "4": {_patient addItem "kat_IV_20"};
                        };
                    };

                    _IVarray set [_partIndex, 0];
                    _patient setVariable [QGVAR(IV), _IVarray, true];
                };
            }, GVAR(IVdrop), [_patient, _partIndex]] call CBA_fnc_addPerFrameHandler;
        };
    }, [_patient, _partIndex, _IVpfhActual], GVAR(IVdrop)] call CBA_fnc_waitAndExecute;
};
