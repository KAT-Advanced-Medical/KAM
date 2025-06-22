#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks for if AMS is enabled and an IV sutible for medications is placed/if an IV is required
 *
 * Arguments:
 * 0: None
 *
 * Example:
 * [] call kat_pharma_fnc_AMScheck;
 *
 * Public: No
 */
private _medicationsRequireInsIV = GVAR(MedicationsRequireInsIV);
private _amsEnabled = true;
private _removeIV = FUNC(removeIV);
    
[false, true] select ((!_medicationsRequireInsIV || _removeIV));