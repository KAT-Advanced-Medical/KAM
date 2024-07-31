#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins Remove Fluid Warmer treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "Carbonate", objNull, "kat_Carbonate"] call kat_hypothermia_fnc_removeFluidWarmer;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[_patient, _classname] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), _classname]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(removeFluidWarmer), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
