#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * 
 *
 * Arguments:
 *
 *
 * Example:
 * [] call kat_pharma_fnc_AMScheck;
 *
 * Public: No
 */
private _medicationsRequireInsIV = GVAR(MedicationsRequireInsIV);
private _amsEnabled = GVAR(AMS_Enabled);
private _removeIV = FUNC(removeIV);
    
[false, true] select ((! _medicationsRequireInsIV || _removeIV) && ! _amsEnabled);