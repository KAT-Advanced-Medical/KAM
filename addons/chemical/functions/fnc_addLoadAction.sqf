#include "script_component.hpp"
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
	if ((ace_csw_ammoHandling == 0) && {!([false, true, true, ace_csw_defaultAssemblyMode] select (_target getVariable [ace_csw_assemblyMode, 3]))}) exitWith { false };
	[_player, _target, ["isNotSwimming", "isNotSitting"]] call ace_common_canInteractWith;
};

private _childenCode = {
	private _ret = (call ace_csw_reload_actionsLoad) + (call ace_csw_reload_actionsUnload);
	_ret
};

private _magazineLocation = getText (configFile >> "CfgVehicles" >> "Mortar_01_base_F" >> "ace_csw" >> "magazineLocation");
private _positionCode = compile _magazineLocation;
private _ammoAction = ["ace_csw_magazine",localize "STR_ACE_CSW_ammoHandling_displayName", "", {}, _condition, _childenCode, [], _positionCode, 4] call ace_interact_menu_fnc_createAction;
private _ammoActionPath = ["Mortar_01_base_F", 0, [], _ammoAction] call ACE_interact_menu_fnc_addActionToClass;

