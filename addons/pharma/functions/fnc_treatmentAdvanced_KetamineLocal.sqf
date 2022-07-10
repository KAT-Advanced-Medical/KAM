#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * 
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Item Classname <STRING>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "Ketamine"] call kat_pharma_fnc_treatmentAdvanced_KetamineLocal;
 *
 * Public: No
 */

params ["_patient", "_medicationString"];