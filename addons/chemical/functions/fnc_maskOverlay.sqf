#include "..\script_component.hpp"
/*
* Author: kolmipilot
*
* Arguments:
* 0: player <Object>
*
* Return Value:
* NONE
*
* Example:
* [] call kat_chemical_fnc_maskOverlay;
*
* Public: No
*/
params ["_unit"];

if (goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {
    switch (goggles _unit) do {
        case "G_AirPurifyingRespirator_01_F": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
         };
        case "G_AirPurifyingRespirator_01_nofilter_F": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
         };
        case "G_AirPurifyingRespirator_02_black_F": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR_02", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
         };
        case "G_AirPurifyingRespirator_02_olive_F": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR_02", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
         };
        case "G_AirPurifyingRespirator_02_sand_F": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR_02", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
         };
        case "G_RegulatorMask_F": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_Regulator", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
         };
        case "kat_mask_M04": {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutRsc ["KAT_GasmaskOverlay_m04", "PLAIN", -1, false];
         };
        default { 
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR", "PLAIN", -1, false];
            "KAT_UI_GasmaskOverlay" cutRsc ["KAT_GasmaskOverlay", "PLAIN", -1, false];
        };
    };
} else {
    "KAT_UI_GasmaskOverlay_glass" cutText ["", "PLAIN"];
    "KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
};
