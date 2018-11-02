/*
 * Author: Katalam
 * Open the pulsoxymeter for the medic
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

    private _display = uiNamespace getVariable "kat_aceBreathing_pulsoxymeter_menu";
    if (!isNil "_display") then {
        closeDialog 1000;
    };
};

// GVAR(INTERACTION_TARGET) = _interactionTarget; ?

createDialog "kat_aceBreathing_pulsoxymeter_menu";

true;
