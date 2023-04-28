#include "script_component.hpp"
/*
 * Author: Blue
 * Checks if target arm has pulse oximeter.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * Has pulse oximeter <BOOL>
 *
 * Example:
 * [cursorTarget, "LeftArm"] call kat_breathing_fnc_checkPulseOximeter
 *
 * Public: No
 */

params ["_patient", "_bodyPart"];

if(_patient getVariable [QGVAR(PulseOximeter_Attached), [0,0]] select (ALL_BODY_PARTS find toLower _bodyPart)-2 > 0) exitWith {true};

false