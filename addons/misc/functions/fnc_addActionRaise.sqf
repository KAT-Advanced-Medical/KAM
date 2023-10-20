#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - unwind/rewind the ropes.
 *
 *
 * Example:
 * ["_s","_h","_rope1","_rope2","_rope3","_rope4"] call kat_misc_fnc_addActionRaise;
 *
 * Public: No
 */

params ["_s","_h","_rope1","_rope2","_rope3","_rope4"];

_h addAction [
  format ["<ui image='x\kat\addons\misc\ui\uparrow.paa' size='1' shadow='false'/> <t>%1</t>", LLSTRING(helistretcher_raise)],
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

    ropeUnwind [_rope1, 10, 3];
    ropeUnwind [_rope2, 10, 3];
    ropeUnwind [_rope3, 10, 3];
    ropeUnwind [_rope4, 10, 3];

    waitUntil {ropeUnwound _rope1};

    _u = crew _s;
    if (count _u > 0) then {
      _patient = _u select 0;

      sleep 8;
      deleteVehicle _s;

      [_patient, _h] remoteExec ["moveInCargo", 0];

      ropeDestroy _rope1;
      ropeDestroy _rope2;
      ropeDestroy _rope3;
      ropeDestroy _rope4;

      _s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-5])];
      _s attachTo [_h,[0,0,-.1],"slingload0"];
      [_s,_h] call kat_misc_fnc_heliAddActionDeploy;
    } else {
      sleep 8;
      deleteVehicle _s;

      ropeDestroy _rope1;
      ropeDestroy _rope2;
      ropeDestroy _rope3;
      ropeDestroy _rope4;

      _s = createVehicle ["kat_stretcher", (_h modelToWorld [0,0,-5])];
      _s attachTo [_h,[0,0,-.1],"slingload0"];
      [_s,_h] call kat_misc_fnc_heliAddActionDeploy;
    };
  },
  [_s,_h,_rope1,_rope2,_rope3,_rope4],
  4,  // priority
  true,  // showWindow
  true,  // hideOnUse
  "",   // shortcut
  "!(isNull objectParent player)",  // condition
  10,   // radius
  false,  // unconscious
  "",   // selection
  ""   // memoryPoint
];
