#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * closes the syringe menu
 *
 * Arguments:
 * none
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_medical_gui_fnc_closeSyringeMenu;
 *
 * Public: No
 */
[{ACEGVAR(medical_gui,target) setVariable ["kat_SyringeMenu", false, true];
ctrlShow [71300, false];
ctrlShow [71301, false];
ctrlShow [71311, false];
ctrlShow [71310, true];}, []] call CBA_fnc_execNextFrame;