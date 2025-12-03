#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Modified: Mazinski.H
 * Handles Cardiac Arrest State
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_statemachine_fnc_handleEnteredCardiacArrest
 *
 * Public: No
 */

 params ["_unit"];

 // If the unit died the loop is finished
 if (!alive _unit || {!local _unit}) exitWith {};
 
 [_unit] call ACEFUNC(medical_vitals,handleUnitVitals);
 
 private _timeDiff = CBA_missionTime - (_unit getVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLastUpdate), 0]);
 if ((_timeDiff >= 1) && !(EGVAR(brain,enable))) then {
     _timeDiff = _timeDiff min 10;
     _unit setVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLastUpdate), CBA_missionTime];
     private _recieveingCPR = alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull]);
     private _timeLeft = _unit getVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLeft), -1];
     private _hypothermia = linearConversion [20, 35, (_unit getVariable [QEGVAR(hypothermia,unitTemperature), 37]), 0.2, 1, true];
     TRACE_5("cardiac arrest life tick",_unit,_recieveingCPR,_timeLeft,_hypothermia,_timeDiff);
     if (_recieveingCPR) then { _timeDiff = _timeDiff * 0.5; }; // if being cpr'ed, then time decrease is reduced.
     _timeLeft = _timeLeft - (_timeDiff * _hypothermia); // if patient is hypothermic, then time decrease is reduced, regardless of CPR
     _unit setVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLeft), _timeLeft];
 };
