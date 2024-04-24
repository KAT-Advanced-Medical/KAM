#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_addLoadAction;
 *
 * Public: No
 *
 * This adds the function to Load gas mortar rounds into a mortar using the CSW function from ace
*/
private _condition = { //IGNORE_PRIVATE_WARNING ["_target", "_player"];
    // If magazine handling is enabled or weapon assembly/disassembly is enabled we enable ammo handling
    if ((ACEGVAR(csw,ammoHandling) == 0) && {!([false, true, true, ACEGVAR(csw,defaultAssemblyMode)] select (_target getVariable [QACEGVAR(csw,assemblyMode), 3]))}) exitWith { false };
    [_player, _target, ["isNotSwimming", "isNotSitting"]] call ACEFUNC(common,canInteractWith);
};

private _childenCode = {
    private _return = (call ACEFUNC(csw,reload_actionsLoad)) + (call ACEFUNC(csw,reload_actionUnload));
    _return
};

private _magazineLocation = getText (configFile >> "CfgVehicles" >> "Mortar_01_base_F" >> "ace_csw" >> "magazineLocation");
private _positionCode = compile _magazineLocation;
private _ammoAction = ["ace_csw_magazine",ACELSTRING(CSW,ammoHandling_displayName), "", {}, _condition, _childenCode, [], _positionCode, 4] call ACEFUNC(interact_menu,createAction);
private _ammoActionPath = ["Mortar_01_base_F", 0, [], _ammoAction] call ACEFUNC(interact_menu,addActionToClass);

