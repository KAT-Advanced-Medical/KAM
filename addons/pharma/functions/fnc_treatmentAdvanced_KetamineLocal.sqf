#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * 
 *
 * Arguments:
 * 0: Medic <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "Ketamine"] call kat_pharma_fnc_treatmentAdvanced_KetamineLocal;
 *
 * Public: No
 */

params ["_patient"];

[true] call FUNC(effectKetamine);