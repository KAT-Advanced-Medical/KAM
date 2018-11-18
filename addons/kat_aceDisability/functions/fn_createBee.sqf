/*
	Author: Katalam, Fynn

	Spawns a group of animals which will circle the spawn area.

	Argument(s):
	0: Spawn position <OBJECT, STRING, POSITION>
	1: Radius <NUMBER>
	2: Number of animals <NUMBER>
	3: Spawn height <NUMBER>
	4: Animal Classname <STRING>, optional

	Return Value:
	Spawned animals <ARRAY>

*/

// To-Do: functionality check and commentary at the beginning

params [
	["_centre", [0,0,0], [[], objnull, ""]],
	["_radius", 50, [0]],
	["_count", 5, [0]],
	["_height", 30 + random 10, [0]],
	["_animal", "HoneyBee", [""]]
];

_centre = _centre call {
	if (_this isEqualType objNull) exitWith {getPosASL _this};
	if (_this isEqualType "") exitWith {markerPos _this};
	_this
};

if (_centre isEqualTo [0,0,0]) exitWith {[]};


private _animalList = [];
private _wp0 = [_centre, _radius, 00] call BIS_fnc_relPos;
private _wp1 = [_centre, _radius, 090] call BIS_fnc_relPos;
private _wp2 = [_centre, _radius, 180] call BIS_fnc_relPos;
private _wp3 = [_centre, _radius, 270] call BIS_fnc_relPos;


for "_i" from 1 to _count do {
	// Random uniformly distributed position in a circle around the centre position
	private _pos = (_centre getPos [_radius * sqrt random 1 , random 360]) vectorAdd [0, 0, _height];

	private _newAnimal = createVehicle [_animal, _pos, [], 0, "NONE"];
	_newAnimal setVariable ["BIS_fnc_animalBehaviour_disable", true];

	// FSM for animal to circle the spawn area
	[_animal, _wp0, _wp1, _wp2, _wp3, _radius] execfsm "A3\Functions_F\Environment\fn_crows.fsm";
	_animalList pushBack _animal;
};

_animalList;
