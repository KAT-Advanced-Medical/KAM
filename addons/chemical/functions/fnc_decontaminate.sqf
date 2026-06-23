#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Self-action handler: decontaminate skin contamination (mustard, VX) on
 * yourself. Consumes a kat_decon_kit and clears the contamination + delayed
 * mustard deadlines so the symptoms scheduled at exposure don't still fire.
 *
 * Medic-on-other path uses the Decontaminate treatment action defined in
 * ACE_Medical_Treatment_Actions.hpp, which calls FUNC(clearContamination)
 * directly via ACE's treatment flow (no progressBar here).
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT> (default: _player)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_player", ["_target", objNull, [objNull]]];

if (isNull _target) then { _target = _player; };

private _duration = missionNamespace getVariable [QGVAR(deconActionTime), 8];

[_player, "Acts_carFixingWheel"] call ACEFUNC(common,doAnimation);

[
    _duration,
    [_player, _target],
    {
        params ["_args"];
        _args params ["_player", "_target"];
        [_player, "kat_decon_kit"] call ACEFUNC(common,useItem);
        [_player, _target] call FUNC(clearContamination);
        [_player, "", 1] call ACEFUNC(common,doAnimation);
    },
    {
        params ["_args"];
        _args params ["_player"];
        [_player, "", 1] call ACEFUNC(common,doAnimation);
    },
    LLSTRING(UseDecon_Progress),
    {
        params ["_args"];
        _args params ["_player", "_target"];
        ([_player, _player, ["kat_decon_kit"]] call ACEFUNC(medical_treatment,hasItem)) &&
        {((_target getVariable [QGVAR(chemicalContamination), ""]) != "") || {(_target getVariable [QGVAR(radExternalContam), 0]) > 0}}
    },
    ["isNotInside"]
] call ACEFUNC(common,progressBar);
