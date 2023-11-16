#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - unwind/rewind the ropes.
 *
 *
 * Example:
 * ["_s","_h","_rope1","_rope2","_rope3","_rope4"] call kat_misc_fnc_actionLowerBy10;
 *
 * Public: No
 */

 params ["_s","_h","_rope1","_rope2","_rope3","_rope4"];

_lowerby10 = _h addAction [
  format ["<ui image='x\kat\addons\misc\ui\downarrow.paa' size='1' shadow='false'/> <t>%1</t>", LLSTRING(helistretcher_lower10m)],
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
  [_s,_h,_rope1,_rope2,_rope3,_rope4],  // arguments
  4,  // priority
  true,  // showWindow
  true,  // hideOnUse
  "",   // shortcut
  "true",  // condition
  10,   // radius
  false,  // unconscious
  "",   // selection
  ""   // memoryPoint
];

_raiseby10 = _h addAction
[
  format ["<ui image='x\kat\addons\misc\ui\uparrow.paa' size='1' shadow='false'/> <t>%1</t>", LLSTRING(helistretcher_raise10m)],
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
  [_s,_h,_rope1,_rope2,_rope3,_rope4],  // arguments
  4,  // priority
  true,  // showWindow
  true,  // hideOnUse
  "",   // shortcut
  "true",  // condition
  10,   // radius
  false,  // unconscious
  "",   // selection
  ""   // memoryPoint
];

waitUntil {isNull _rope1};

_h removeAction _lowerby10;
_h removeAction _raiseby10;
