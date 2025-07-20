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

if(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {
    if(missionNamespace getVariable [QGVAR(showOverlay), true]) then {
        if(!((goggles _unit == "G_AirPurifyingRespirator_01_F")||(goggles _unit == "G_AirPurifyingRespirator_01_nofilter_F ")||(goggles _unit == "G_AirPurifyingRespirator_02_black_F")||(goggles _unit == "G_AirPurifyingRespirator_02_olive_F")||(goggles _unit == "G_AirPurifyingRespirator_02_sand_F")||(goggles _unit == "G_RegulatorMask_F"))) then {
            if(goggles _unit =="kat_mask_M04") then {
                "KAT_UI_GasmaskOverlay" cutRsc ["KAT_GasmaskOverlay_m04", "PLAIN", -1, false];
            } else {
            "KAT_UI_GasmaskOverlay" cutRsc ["KAT_GasmaskOverlay", "PLAIN", -1, false];
            };
        };
    };
    if(missionNamespace getVariable [QGVAR(showGlassOverlay), true]) then {
        if((goggles _unit == "G_AirPurifyingRespirator_01_F")||(goggles _unit == "G_AirPurifyingRespirator_01_nofilter_F ")) then {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR", "PLAIN", -1, false];
        } else {
            if((goggles _unit == "G_AirPurifyingRespirator_02_black_F")||(goggles _unit == "G_AirPurifyingRespirator_02_olive_F")||(goggles _unit == "G_AirPurifyingRespirator_02_sand_F")) then {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR_02", "PLAIN", -1, false];
            } else {
                if(goggles _unit == "G_RegulatorMask_F") then {
            "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_Regulator", "PLAIN", -1, false];
            } else {
                "KAT_UI_GasmaskOverlay_glass" cutRsc ["RscCBRN_APR", "PLAIN", -1, false];
            };
            };
        };
    };
} else {
"KAT_UI_GasmaskOverlay" cutText ["", "PLAIN"];
"KAT_UI_GasmaskOverlay_glass" cutText ["", "PLAIN"];	
};