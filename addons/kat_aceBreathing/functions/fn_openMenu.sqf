/*
 * Author: Katalam
 * Open the pulsoximeter for the medic
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * If action was taken <BOOL>
 *
 * Example:
 * [bob] call kat_aceBreathing_fnc_openMenu;
 *
 * Public: No
 */

params ["_interactionTarget"];

if (dialog || {isNull _interactionTarget}) exitWith {
    disableSerialization;

    private _display = uiNamespace getVariable "kat_aceBreathing_pulsoximeter_menu";
    if (!isNil "_display") then {
        closeDialog 1000;
    };
};

// GVAR(INTERACTION_TARGET) = _interactionTarget; ?

createDialog "kat_aceBreathing_pulsoximeter_menu";

true;
