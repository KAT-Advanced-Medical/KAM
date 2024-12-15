#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * opens the syringe menu and populates it
 *
 * Arguments:
 * none
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_medical_gui_fnc_openSyringeMenu;
 *
 * Public: No
 */
[] call FUNC(updateMedications);
[] call FUNC(updateSyringes);
[{player setVariable ["SyringeMenu", true];
ctrlShow [71300, true];
ctrlShow [71301, true];
ctrlShow [71311, true];
ctrlShow [71310, false];}, []] call CBA_fnc_execNextFrame;
