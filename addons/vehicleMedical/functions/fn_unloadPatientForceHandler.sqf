params["_patient", "_medic"];

private _name = [_medic] call ace_common_fnc_getName;
[format["Being forced out by %1", _name], false, 2, 1] call ACE_common_fnc_displayText;
unassignVehicle _patient;
[_patient] orderGetIn false;
_patient action ["Eject", vehicle _patient];
if (vehicle _patient != _patient) then {
	moveOut _patient;
};
[_patient, false, "ace_common_fnc_loadPerson", side group _patient] call ace_common_fnc_switchToGroupSide;

[
	{
		params ["_patient"];
		(alive _patient) && {(vehicle _patient) != _patient}
	},
	{
		params ["_patient"];
	},
	[_patient, _medic],
	2, 
	{
		params ["_patient", "_medic"];
		private _name = [_medic] call ace_common_fnc_getName;
		[format["Being forced out by %1", _name], false, 4, 1] call ACE_common_fnc_displayText;
		unassignVehicle _patient;
		[_patient] orderGetIn false;
		_patient action ["Eject", vehicle _patient];
		if (vehicle _patient != _patient) then {
			moveOut _patient;
		};
		[_patient, false, "ace_common_fnc_loadPerson", side group _patient] call ace_common_fnc_switchToGroupSide;
	}
] call CBA_fnc_waitUntilAndExecute;