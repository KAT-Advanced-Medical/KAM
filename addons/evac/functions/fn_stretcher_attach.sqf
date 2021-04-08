_h = cursorObject;
if ( player distance2D _h <= 15 ) then {
if (_h isKindOf "Helicopter") then {
_s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-5])];

_s attachTo [_h,[0,0,-.1],"slingload0"];

ActionLowerBy10 = {
params ["_s","_h","_rope1","_rope2","_rope3","_rope4"];
_lowerby10 = _h addAction
[
	"<img image='\evac\img\downarrow.paa' size='1' shadow='false'/> | Lower Strecher By 10m",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
    _rope1 = _arguments select 2;
    _rope2 = _arguments select 3;
    _rope3 = _arguments select 4;
    _rope4 = _arguments select 5;
    if (ropeLength _rope1 < 50) then {
    ropeUnwind [_rope1, 2, 10, true];
    ropeUnwind [_rope2, 2, 10, true];
    ropeUnwind [_rope3, 2, 10, true];
    ropeUnwind [_rope4, 2, 10, true];
    };
	},
	[_s,_h,_rope1,_rope2,_rope3,_rope4],		// arguments
	4,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	10,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];
_raiseby10 = _h addAction
[
	"<img image='\evac\img\uparrow.paa' size='1' shadow='false'/> | Raise Strecher By 10m",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
    _rope1 = _arguments select 2;
    _rope2 = _arguments select 3;
    _rope3 = _arguments select 4;
    _rope4 = _arguments select 5;
    if (ropeLength _rope1 > 10) then {
    ropeUnwind [_rope1, 2, -10, true];
    ropeUnwind [_rope2, 2, -10, true];
    ropeUnwind [_rope3, 2, -10, true];
    ropeUnwind [_rope4, 2, -10, true];
    };
	},
	[_s,_h,_rope1,_rope2,_rope3,_rope4],		// arguments
	4,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	10,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];
waitUntil {isNull _rope1};
_h removeAction _lowerby10;
_h removeAction _raiseby10;
};

addActionRaise = {
params ["_s","_h","_rope1","_rope2","_rope3","_rope4"];
_s = _s;
_h = _h;
_rope1 = _rope1;
_rope2 = _rope2;
_rope3 = _rope3;
_rope4 = _rope4;
_h addAction
[
 "<img image='\evac\img\uparrow.paa' size='1' shadow='false'/> | Raise Strecher",
 {
  params ["_target", "_caller", "_actionId", "_arguments"];
_caller removeAction _actionId;
_target removeAction _actionId;
_s = _arguments select 0;
_h = _arguments select 1;
_rope1 = _arguments select 2;
_rope2 = _arguments select 3;
_rope3 = _arguments select 4;
_rope4 = _arguments select 5;

_h = vehicle _caller;
ropeUnwind [_rope1, 10, 3];
ropeUnwind [_rope2, 10, 3];
ropeUnwind [_rope3, 10, 3];
ropeUnwind [_rope4, 10, 3];
sleep 1;
waitUntil {ropeUnwound _rope1};
_u = crew _s;
if (count _u == 1) then {
  _uu = _u select 0;
  sleep 8;
  deleteVehicle _s;
  _uu moveInCargo _h;
  ropeDestroy _rope1;
  ropeDestroy _rope2;
  ropeDestroy _rope3;
  ropeDestroy _rope4;
  _h = _target;
  _s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-5])];
  _s attachTo [_h,[0,0,-.1],"slingload0"];
  [_s,_h] call addActionDeploy;
} else {
sleep 8;
deleteVehicle _s;
ropeDestroy _rope1;
ropeDestroy _rope2;
ropeDestroy _rope3;
ropeDestroy _rope4;
_h = _target;
_s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-5])];
_s attachTo [_h,[0,0,-.1],"slingload0"];
[_s,_h] call addActionDeploy;
};
 },
 [_s,_h,_rope1,_rope2,_rope3,_rope4],
 4,		// priority
 true,		// showWindow
 true,		// hideOnUse
 "",			// shortcut
 "!(isNull objectParent player)", 	// condition
 10,			// radius
 false,		// unconscious
 "",			// selection
 ""			// memoryPoint
];

};

addActionDeploy = {
params ["_s","_h"];
_s = _s;
_h = _h;

_h addAction
[
 "<img image='\evac\img\downarrow.paa' size='1' shadow='false'/> | Lower Strecher",
 {
  params ["_target", "_caller", "_actionId", "_arguments"];
_caller removeAction _actionId;
_target removeAction _actionId;
_s = _arguments select 0;
_h = _arguments select 1;
deleteVehicle _s;
_s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-3])];

_s addAction
[
	"<img image='\evac\img\fliparrow.paa' size='1' shadow='false'/> | Flip Stretcher",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
    _target setVectorUp [0,0,1];
    _target setPosATL [(getPosATL _target) select 0, (getPosATL _target) select 1, 0];
	},
	nil,		// arguments
	5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

_rope1 = ropeCreate [_h, "slingload0", _s, [.25,1,0], 5];
_rope2 = ropeCreate [_h, "slingload0", _s, [-.25,1,0], 5];
_rope3 = ropeCreate [_h, "slingload0", _s, [-.25,-1,0], 5];
_rope4 = ropeCreate [_h, "slingload0", _s, [.25,-1,0], 5];


ropeUnwind [_rope1, 2, 20];
ropeUnwind [_rope2, 2, 20];
ropeUnwind [_rope3, 2, 20];
ropeUnwind [_rope4, 2, 20];


waitUntil {ropeUnwound _rope1};
[_s,_h,_rope1,_rope2,_rope3,_rope4] call addActionRaise;
[_s,_h,_rope1,_rope2,_rope3,_rope4] call ActionLowerBy10;
 },
 [_s,_h],
 1,		// priority
 true,		// showWindow
 true,		// hideOnUse
 "",			// shortcut
 "!(isNull objectParent player)", 	// condition
 10,			// radius
 false,		// unconscious
 "",			// selection
 ""			// memoryPoint
];
};

[_s,_h] call addActionDeploy;
} else {
  ["The vehicle you are looking at is not a helicopter!", 2, ace_player, 10] call ace_common_fnc_displayTextStructured;
  player addItem "Attachable_Stretcher";
};
} else {
  ["You must be within 15m of the helicopter!", 2, ace_player, 10] call ace_common_fnc_displayTextStructured;
  player addItem "Attachable_Stretcher";
};
