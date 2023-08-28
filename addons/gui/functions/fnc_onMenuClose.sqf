#include "script_component.hpp"
/*
 * Author: joko // Jonas
 * Handles closing the Medical Menu. Called from onUnload event.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_medical_gui_fnc_onMenuClose
 *
 * Public: No
 */

if (ACEGVAR(interact_menu,menuBackground) == 1) then {[QACEGVAR(medcial_gui,id), false] call EFUNC(common,blurScreen)};
if (ACEGVAR(interact_menu,menuBackground) == 2) then {(uiNamespace getVariable [QEGVAR(interact_menu,menuBackground), displayNull]) closeDisplay 0};

ACEGVAR(medical_gui,pendingReopen) = false;
ACEGVAR(medical_gui,menuPFH) call CBA_fnc_removePerFrameHandler;
ACEGVAR(medical_gui,menuPFH) = -1;
ACEGVAR(medical_gui,target) = objNull;