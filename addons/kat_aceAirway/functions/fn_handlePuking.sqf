/*
 * Author: Katalam
 * Called when a unit enters the unconscious state. Will add a FrameHandler for puking while unconscious.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_aceAirway_fnc_handlePuking;
 *
 * Public: No
 */

params ["_unit"];

[{
  params ["_args", "_idPFH"];
  _args params ["_unit"];
  private _alive = _unit getVariable ["ACE_isUnconscious", false];
  if (!_alive || (_unit getVariable ["kat_aceAirway_airway_item", ""] isEqualTo "larynx")) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
  };
	if (random(100) <= kat_aceAirway_probability_occluded) then {
		if !(_unit getVariable ["ace_medical_airwayOccluded", false]) then {
			_unit setVariable ["ace_medical_airwayOccluded", true, true];
      if (kat_aceAirway_checkbox_puking_sound) then {
        playsound3D ["kat_aceAirway\sounds\Puking.wav", _unit, false, getPosASL _unit, 8, 1, 15];
      };
		};
	};
}, 60, [_unit]] call CBA_fnc_addPerFrameHandler;
