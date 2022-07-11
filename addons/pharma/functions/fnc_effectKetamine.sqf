#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_applyIV;
 *
 * Public: No
 */

params ["_ketamine"];

GVAR(ppKetamineBlur) = ppEffectCreate ["RadialBlur", 100];
GVAR(ppKetamineWet) = ppEffectCreate ["WetDistortion",300];
GVAR(ppKetamineColor) = ppEffectCreate ["ColorInversion",2500];

GVAR(ppKetamineBlur) ppEffectEnable true;
GVAR(ppKetamineWet) ppEffectEnable true;
GVAR(ppKetamineColor) ppEffectEnable true;

GVAR(ppKetamineBlur) ppEffectAdjust [0.05,0.04,0.12,0.16];
GVAR(ppKetamineWet) ppEffectAdjust [4.73,0.51,0.2,1,1,1,1,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];
GVAR(ppKetamineColor) ppEffectAdjust [0.46,0.58,0.5];

GVAR(ppKetamineBlur) ppEffectCommit 1;
GVAR(ppKetamineWet) ppEffectCommit 3;
GVAR(ppKetamineColor) ppEffectCommit 5;