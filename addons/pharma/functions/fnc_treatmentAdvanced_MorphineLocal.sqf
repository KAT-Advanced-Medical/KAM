#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Applies the opioid factor from Morphine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Leftleg", 1] call kat_pharma_fnc_treatmentAdvanced_MorphineLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_opioidRelief"];
