#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Calculates surgery actions treatment time
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient (not used) <OBJECT>
 * 2: Body Part (not used) <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item (not used) <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "Morphine", objNull, "ACE_morphine"] call kat_surgery_fnc_getTreatmentTime;
 *
 * Public: No
 */

params ["_medic", "", "", "_classname", "", ""];

private _medicLvl = _medic getVariable [QACEGVAR(medical,medicClass), parseNumber (_medic getUnitTrait "medic")];
private _classnameTime = format [QGVAR(%1_treatmentTime), _classname];
private _treatmentTime = missionNamespace getVariable [_classnameTime, 5];

switch (_medicLvl) do {
	case 0: {
		_treatmentTime = _treatmentTime;
	};
	case 1: {
		_treatmentTime = _treatmentTime * GVAR(medicMultiplier);
	};
	case 2: {
		_treatmentTime = _treatmentTime * GVAR(doctorMultiplier);
	};
};

_treatmentTime