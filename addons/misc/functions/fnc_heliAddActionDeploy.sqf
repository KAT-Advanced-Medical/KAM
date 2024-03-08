#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - unwind the ropes.
 *
 *
 * Example:
 * [_stretcher,_heli] call kat_misc_fnc_heliAddActionDeploy;
 *
 * Public: No
 */

 params ["_s","_h"]; //_s == Stretcher (Object) | _h == Heli (Object)

_h addAction [
  format ["<ui image='x\kat\addons\misc\ui\downarrow.paa' size='1' shadow='false'/> <t>%1</t>", LLSTRING(helistretcher_lower)],
  {
    params ["_target", "_caller", "_actionId", "_arguments"];
    _caller removeAction _actionId;
    _target removeAction _actionId;
    _s = _arguments select 0;
    _h = _arguments select 1;
    deleteVehicle _s;
    _s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-3])];

    _s addAction [
      format ["<ui image='x\kat\addons\misc\ui\fliparrow.paa' size='1' shadow='false'/> <t>%1</t>", LLSTRING(helistretcher_flip)],
      {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target setVectorUp [0,0,1];
        _target setPosATL [(getPosATL _target) select 0, (getPosATL _target) select 1, 0];
      },
      nil,  // arguments
      5,  // priority
      true,  // showWindow
      true,  // hideOnUse
      "",   // shortcut
      "true",  // condition
      3,   // radius
      false,  // unconscious
      "",   // selection
      ""   // memoryPoint
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
    [_s,_h,_rope1,_rope2,_rope3,_rope4] call kat_misc_fnc_addActionRaise;
    [_s,_h,_rope1,_rope2,_rope3,_rope4] call kat_misc_fnc_actionLowerBy10;
  },
  [_s,_h],
  1,  // priority
  true,  // showWindow
  true,  // hideOnUse
  "",   // shortcut
  "!(isNull objectParent player)",  // condition
  10,   // radius
  false,  // unconscious
  "",   // selection
  ""   // memoryPoint
];
