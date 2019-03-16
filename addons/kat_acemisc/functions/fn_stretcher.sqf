params [["_veh",objNull,[objNull]]];
if !(_veh isKindOf "kat_stretcher") exitWith {false};
if (isClass(configFile >> "CfgPatches" >> "ace_dragging")) then {
	[_veh] call ace_dragging_fnc_initObject;
};
_veh addAction ["Disassemble stretcher",{
	_litter = (_this select 0);
	if ((count crew _litter > 0) || !(isNull attachedTo _litter)) exitWith {false};
	_bag = "kat_stretcher_bag" createVehicle (position _litter);
	_bag setPosASL getPosASL _litter;
	deleteVehicle _litter;
},[],1.5,false,true,"","(alive _target) && (vehicle _this == _this) && (isNull attachedTo _target) && (count crew _target == 0)"];
_veh addAction ["Unload Stretcher",{
	_litter = (_this select 0);
	_veh = attachedTo _litter;
	_arr = _veh getVariable ["kat_seat_litter_slots",[]];
	if (!(isNull _veh) && (isNull isVehicleCargo _litter)) then {
		detach _litter;
		_litter setVehiclePosition [player,[],0,"NONE"];
		{if ((_x select 0) == _litter) then { _x set [0,objNull];}} forEach _arr;
	};
},[],1.5,false,true,"","(alive _target) && (vehicle _this == _this) && !(isNull attachedTo _target) && (isNull isVehicleCargo _target)"];
true
