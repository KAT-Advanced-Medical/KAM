#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Applies the opioid factor from Nalbuphine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Leftleg", 1] call kat_pharma_fnc_treatmentAdvanced_NalbuphineLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_opioidRelief"];
